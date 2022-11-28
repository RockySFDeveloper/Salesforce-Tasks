import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from'@salesforce/schema/Account';
import Name from'@salesforce/schema/Account.Name';
import AccountNumber from'@salesforce/schema/Account.AccountNumber';
import Phone from'@salesforce/schema/Account.Phone';
import AnnualRevenue from'@salesforce/schema/Account.Site';
import Description from'@salesforce/schema/Account.Description';


export default class formAccountCreation extends LightningElement {

    objectApiName = ACCOUNT_OBJECT;
    fields = [Name,AccountNumber,Phone,AnnualRevenue,Description];

    handleSuccess(){
        const toastEventSuccess = new ShowToastEvent({
            title: "Success",
            message: "Account Created Successfully",
            variant: "success"
        });
        this.dispatchEvent(toastEventSuccess);
    }
}