import { LightningElement, track } from 'lwc';
import { subscribe, unsubscribe} from 'lightning/empApi';

export default class PlatformEvent extends LightningElement {

    channelName = '/event/Record_Creation__e';
    @track payload = '';
    subscription = {};
    @track accountNameList = [];

    connectedCallback() {
        this.handleSubscribe();
    }

    handleSubscribe() {

        subscribe(this.channelName, -1, this.messageCallback). then(response => {
            console.log('Subscription request sent to ',JSON.stringify(response.channel));
            this.subscription = response;
        });
    }

    handleUnsubscribe() {

        unsubscribe(this.subscription, response => {
            console.log('unsubscribe() response : ',JSON.stringify(response));
        });
    }

    disconnectedCallback() {
        this.handleUnsubscribe();
    }

    messageCallBack = (response) => {
        let actName = response.data.payload.Record_Name__c;
        let actId = response.data.payload.Record_Id__c;
        let recPath = '/'+response.data.payload.Record_Id__c;
        this.accountNameList.push({"Id":actId,"Name":actName,"Path":recPath});
        console.log('Account Name List : '+JSON.stringify(this.accountNameList));  
    }
}