import { LightningElement, wire, track } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
import WEBSITE_FIELD from '@salesforce/schema/Account.Website';
import SLA_FIELD from '@salesforce/schema/Account.SLA__c';
import SLA_EXP_FIELD from '@salesforce/schema/Account.SLAExpirationDate__c';
//import ACTIVE_FIELD from '@salesforce/schema/Account.IsActive__c';
//import createAccount from '@salesforce/apex/createAccountController.createAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class template extends LightningElement {
    @track name = NAME_FIELD;
    @track type = TYPE_FIELD;
    @track website = WEBSITE_FIELD;
    @track sla = SLA_FIELD;
    @track slaExpDate = SLA_EXP_FIELD;
    @track active = ACTIVE_FIELD;

    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    objectInfo;

    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: TYPE_FIELD})
    TypePicklistValues;

    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: SLA_FIELD})
    SLAPicklistValues;
    rec = {
        Name : this.name,
        Type : this.type,
        Website : this.website,
        SLA__c : this.sla,
        SLAExpirationDate__c : this.slaExpDate,
        IsActive__c : this.active
    }
    
    handleNameChange(event) {
        this.rec.Name = event.target.value;
    }
    handleURLChange(event) {
        this.rec.Website = event.target.value;
    }
    handleSLADAteChange(event) {
        this.rec.SLAExpirationDate__c = event.target.value;
    }
    handleActiveChnage(event) {
        this.rec.IsActive__c = event.target.checked;
    }
    handleChangeType(event){
        this.rec.Type = event.target.value;
    }
    handleSLAType(event){
        this.rec.SLA__c = event.target.value;
    }
    handleClick() {
        createAccount({ acc : this.rec })
            .then(result => {
                this.message = result;
                this.error = undefined;
                if(this.message !== undefined) {
                    this.rec.Name = '';
                    this.rec.Type = '';
                    this.rec.Website = '';
                    this.rec.SLA__c = '';
                    this.rec.SLAExpirationDate__c = '';
                    this.rec.IsActive__c = '';
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Account created',
                            variant: 'success',
                        }),
                    );
                }
                window.location.reload();
            })
            .catch(error => {
                this.message = undefined;
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
           
    }
}