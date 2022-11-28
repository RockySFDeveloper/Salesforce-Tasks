import { LightningElement, api } from 'lwc';
import { subscribe, unsubscribe } from 'lightning/empApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class BatchProgress extends LightningElement {

    channelName = '/event/Batch_Progress__e';
    subscription = {};
    @api recordId;
    recordsProcessed ;
    totalBatches ;
    finishToast ;
    jobId ;
    recordIdFromBatch;
    percentage;
    correctRecordflag = false;
    spinnerFlag = true;
    hideComponentFlag = true;
    hideComponentIfBatchFails = true;
    getErrorMessage ;
    methodEnabled = true;
    initialComponentHide = false ;
    
    handleColor() {
        let text = "Batch Progress";
        text.fontcolor("blue");
    }

    get processedPercent() {
        return this.recordsProcessed / this.totalBatches * 100
    }

    get percentageOfProcess() {
        return Math.round((this.recordsProcessed / this.totalBatches) * 100)
    }

    updatetotalProcessed(totalCount) {
        this.totalBatches = totalCount - 1;
    }

    updateRecordValue(batchProcessing) {
        this.recordsProcessed = batchProcessing + 1;
    }

    updateRecordId(getRecordId){
        this.recordIdFromBatch = getRecordId;
    }

    updateErrorMessage(errorMessage) {
        this.getErrorMessage = errorMessage;
    }

    updatefinishProcess(toastValue,batchId) {
      
        this.finishToast = toastValue;
        this.jobId = batchId;

        if(this.finishToast != 'Completed') {
            this.spinnerFlag = true ;
        }

        if(this.recordId === this.recordIdFromBatch ) {
            this.correctRecordflag = true;
        }

        if(this.finishToast ==='Completed' ) {
            this.hideComponentFlag = false ;
        }

        if(this.recordsProcessed >= 1) {
            this.initialComponentHide = true;
        }

        if(this.finishToast === 'Completed' && this.correctRecordflag === true && this.recordId === this.recordIdFromBatch) {
            this.spinnerFlag = false ;
            const eventForSuccess = new ShowToastEvent({
                title: "Batch Process",
                message: "Batch Process done Successfully  ",
                variant: "Success",
            });
            this.dispatchEvent(eventForSuccess);          
            window.location.reload();
        }       
    } 

    updateBatchStatus(status) {

        if(this.methodEnabled == true) {
            this.batchStatus = status;
            if(this.batchStatus === 'Failed' && this.recordId === this.recordIdFromBatch) {
                this.hideComponentIfBatchFails = false;
    
                const eventForFailure = new ShowToastEvent({
                    title: "Batch Failed",
                    message: "Error Occurs in Batch Apex",
                    variant: "error",
                });
                this.dispatchEvent(eventForFailure);
    
            }
        }
        this.methodEnabled = false ;     
    }

    // Process of Platform Event Subscription
    connectedCallback() {
        this.handleSubscribe();    
    }

    disconnectedCallback() {
        this.handleUnsubscribe();
    }

    handleSubscribe() {
        
        // Callback invoked whenever a new event message is received
        const messageCallback = (response) => {
            // Response contains the payload of the new message received
            this.updateRecordValue(response.data.payload.Batches_Processing__c);
            this.updatetotalProcessed(response.data.payload.Total_Batches__c);
            this.updatefinishProcess(response.data.payload.Finish_Toast__c,response.data.payload.Batch_Id__c);
            this.updateRecordId(response.data.payload.Record_Id__c);
            this.updateBatchStatus(response.data.payload.Batch_Status__c);
            this.updateErrorMessage(response.data.payload.Error_Message__c);
        };

        // Invoke subscribe method of empApi. Pass reference to messageCallback
        subscribe(this.channelName, -1, messageCallback).then(response => {
            // Response contains the subscription information on subscribe call
            console.log('Subscription request sent to: ', JSON.stringify(response.channel));
            this.subscription = response;
            // this.toggleSubscribeButton(true);
        });

    }
    
    handleUnsubscribe() {
        // this.toggleSubscribeButton(false);

        // Invoke unsubscribe method of empApi
        unsubscribe(this.subscription, response => {
            console.log('unsubscribe() response: ', JSON.stringify(response));
            // Response is true for successful unsubscribe
        });
    }
}