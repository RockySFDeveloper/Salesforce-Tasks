import { LightningElement,track,api,wire} from 'lwc';
import { subscribe, unsubscribe, onError, } from 'lightning/empApi';
import asyncJobProcess from '@salesforce/apex/AsyncJobProcess.toGetJobProcess';
import batchCustomSetting from '@salesforce/apex/BatchAccountUpdate.getCustomSetting';

export default class EmpApiLWC extends LightningElement {

    channelName = '/topic/AccountOperation';
    isSubscribeDisabled = false;
    isUnsubscribeDisabled = !this.isSubscribeDisabled;
    @api getValue;
    @track fullLogs;
    @track jobId = '';
    @track jobProcessed = '';
    subscription = {};

    // Tracks changes to channelName text field
    handleChannelName(event) {
        this.channelName = event.target.value;
    }

    @wire(batchCustomSetting) myCustomSettings ({data}){
        if(data) {
            this.jobId = data;
        }
        console.log('Wire JobId' +this.jobId);
    };  

    // Initializes the component
    connectedCallback() {
        // Register error listener
        this.registerErrorListener();
    }

    handleJobs() {

        
    }

    // Handles subscribe button click
    handleSubscribe() {

        asyncJobProcess({getJobId : this.jobId})
        .then(result => {
                        
            console.log('Result asyncJobProcess ===>'+JSON.stringify(result));
            this.jobProcessed = result.Status;
            console.log('Job Items Processed: '+ this.jobProcessed); 
            this.fullLogs = result.JobItemsProcessed;
                     
                    
        }).catch(error => {
                    
            console.log('Error ===>'+JSON.stringify(error));
        });
        // Callback invoked whenever a new event message is received
            
        const messageCallback = function (response) {

            console.log('New message received: ', JSON.stringify(response));

            // Response contains the payload of the new message received
            this.getValue = response.data.sobject.Records_Processing__c;     
            console.log('Get Value ',this.getValue);
            
        };

        

        // Invoke subscribe method of empApi. Pass reference to messageCallback
        subscribe(this.channelName, -1, messageCallback).then((response) => {
            // Response contains the subscription information on subscribe call
            console.log('Subscription request sent to: ',JSON.stringify(response.channel));
            this.subscription = response;
            this.toggleSubscribeButton(true);
            console.log('Wire JobId' +this.jobId);
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











//1
//2
//3