import { LightningElement,track,api,wire} from 'lwc';
import { subscribe, unsubscribe, onError, } from 'lightning/empApi';
import getCustomSettings from '@salesforce/apex/BatchAccountUpdate.getCustomSettings';
import getAsyncProcess from '@salesforce/apex/AsyncJobProcess.toGetJobProcess';

export default class ShowBatchProcess extends LightningElement {

    channelName = '/topic/ContactOperation';
    isSubscribeDisabled = false;
    isUnsubscribeDisabled = !this.isSubscribeDisabled;
    @track jobIdFromBatch = '';
    @track jobProcessed = '';
    @track valueFromResult;
    @track batchprocessing ;
    @track totalBatches ;
    @track progress;
    @track getValue;
    subscription = {};
    
    // Tracks changes to channelName text field
    handleChannelName(event) {
        this.channelName = event.target.value;
    }

    // Initializes the component
    connectedCallback() {
        // Register error listener
        this.registerErrorListener();
    }
    
    // Handles subscribe button click
    async handleSubscribe() {

        // Callback invoked whenever a new event message is received
        const messageCallback = function (response) {

            console.log('New message received: ', JSON.stringify(response));
            
        };

        const storeCustomvalue = await getCustomSettings();
        this.jobIdFromBatch = storeCustomvalue.Job_Id__c;
        console.log('Job Process ===>'+JSON.stringify(storeCustomvalue));
        console.log('Job Id from Batch ===>'+this.jobIdFromBatch);


        getAsyncProcess({getJobId : this.jobIdFromBatch})
        .then(result => {
            result.forEach((record) => {
                this.batchprocessing  = record.JobItemsProcessed;
                this.totalBatches = record.TotalJobItems;
            });
            this.progress = (this.batchprocessing/this.totalBatches) * 100;

            // this.valueFromResult = result;
            // this.jobProcessed = this.valueFromResult[2];
            console.log('Result asyncJobProcess ===>'+JSON.stringify(result));               
                    
        }).catch(error => {
                    
            console.log('Error ===>'+JSON.stringify(error));
        });
        // Invoke subscribe method of empApi. Pass reference to messageCallback
        subscribe(this.channelName, -1, messageCallback).then((response) => {
            // Response contains the subscription information on subscribe call
            console.log('Subscription request sent to: ',JSON.stringify(response.channel));
            this.subscription = response;
            this.toggleSubscribeButton(true);

        });
    }
    
    // Handles unsubscribe button click
    handleUnsubscribe() {

        this.toggleSubscribeButton(false);

        // Invoke unsubscribe method of empApi
        unsubscribe(this.subscription, (response) => {
            console.log('unsubscribe() response: ', JSON.stringify(response));
            // Response is true for successful unsubscribe
        });
    }

    toggleSubscribeButton(enableSubscribe) {

        this.isSubscribeDisabled = enableSubscribe;
        this.isUnsubscribeDisabled = !enableSubscribe;
    }

    registerErrorListener() {
        // Invoke onError empApi method
        onError((error) => {
            console.log('Received error from server : ', JSON.stringify(error));
            // Error contains the server-side error
        });
    } 
}