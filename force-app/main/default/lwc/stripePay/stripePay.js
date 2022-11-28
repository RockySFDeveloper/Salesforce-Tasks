import { LightningElement,api,track } from 'lwc';
import getDetails from '@salesforce/apex/StripeDemo.getDetails';
import getOpportunityDetails from '@salesforce/apex/StripeDemo.getOpportunityDetails';
import updatePaymentStatus from '@salesforce/apex/OpportunityUpdation.updateOppPaymentStatus';
import oppAmount from '@salesforce/schema/Opportunity.Amount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { subscribe } from 'lightning/empApi';

export default class StripePay extends LightningElement {

    accNumber;
    exactResult;
    channelName = '/event/Platform_Eve_Lwc__e';
    paymentStatus;
    opportunityAmount;
    showPayment = false;
    @api recordId;
    @track opportunityRecords = {
        Amount : oppAmount
    };

    handleAccNumber(event) {
        this.accNumber = event.target.value;
        
    }

    connectedCallback() {
        this.handleOpportunityAmount();
        this.handleSubscribe(); 
    }

    handleOpportunityAmount() {

        getOpportunityDetails({oppIdFromlwc : this.recordId})
        .then(result => {
                    
            this.opportunityAmount = result.Amount;
            this.paymentStatus = result.Payment_Status_Org__c;
            if(this.opportunityAmount !== null && this.paymentStatus === 'Not Paid') {

                this.showPayment = true;
            }
            console.log('Result ===>'+JSON.stringify(result)); 
            
        }).catch(error => {
            
            console.log('Error ===>'+JSON.stringify(error));          
        });
    }

    handleSubscribe() {
        
        // Callback invoked whenever a new event message is received
        const messageCallback = (response) => {
            // Response contains the payload of the new message received
            this.updateOpportunityAmount(response.data.payload.Amount__c);
        };

        // Invoke subscribe method of empApi. Pass reference to messageCallback
        subscribe(this.channelName, -1, messageCallback).then(response => {
            // Response contains the subscription information on subscribe call
            console.log('Subscription request sent to: ', JSON.stringify(response.channel));
            // this.toggleSubscribeButton(true);
        });

    }

    updateOpportunityAmount(updatedAmountFromTrigger) {

        this.updatedAmount = updatedAmountFromTrigger;
        if(this.updatedAmount !== null) {
            this.opportunityAmount = this.updatedAmount;
            this.showPayment = true;
        }

        // if(this.updatedAmount === null) {
        //     this.opportunityAmount = null;
        // }
        
    }
    handleSubmit() {

        getDetails({accountNumberFromUser : this.accNumber})
        .then(result => {
                    
            this.exactResult = result;
            console.log('Result ===>'+JSON.stringify(result)); 

            if(this.exactResult === "success" && this.opportunityAmount !== null && this.opportunityAmount !== 0) {
                
                const eventForSuccess = new ShowToastEvent({
                    title: "Success",
                    message: "Amount Paid Successfully  ",
                    variant: "success",
                });
                this.dispatchEvent(eventForSuccess);
                this.showPayment = false;                
                updatePaymentStatus({opportunityId : this.recordId})
                window.location.reload();
            }
            
            if(this.exactResult === "error") {

                const eventForSuccess = new ShowToastEvent({
                    title: "Transaction Declined",
                    message: "Payment Failed due to Mismatch Account Number",
                    variant: "error",
                });
                this.dispatchEvent(eventForSuccess);
            }

            if(this.opportunityAmount === 0) {

                const eventForSuccess = new ShowToastEvent({
                    title: "Transaction Declined",
                    message: "Enter Amount in Opportunity",
                    variant: "error",
                });
                this.dispatchEvent(eventForSuccess);
            }
            
        }).catch(error => {
            
            console.log('Error ===>'+JSON.stringify(error));          
        });
    }
}