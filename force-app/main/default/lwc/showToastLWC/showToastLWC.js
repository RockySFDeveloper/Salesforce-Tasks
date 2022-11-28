import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ShowToastLWC extends LightningElement {
    //Sample Success Toast message code
    @api showSuccessNotification() {
        const evt = new ShowToastEvent({
            title: "Success",
            message: "Record has been saved Successfully",
            variant: "success",
        });
        this.dispatchEvent(evt);
    }
    
    //Sample code for showing error message in Toast
    showErrorNotification() {
        const evt = new ShowToastEvent({
            title: "Error",
            message: "This is sample error message",
            variant: "error",
        });
        this.dispatchEvent(evt);
    }

    //Sample code for showing warning message in Toast
    showWarningNotification() {
        const evt = new ShowToastEvent({
            title: "Warning",
            message: "This is sample warning message",
            variant: "warning",
            mode: "sticky"
        });
        this.dispatchEvent(evt);
    }

    //Sample code for showing Info message in Toast
    showInfoNotification() {
        const evt = new ShowToastEvent({
            title: "Info",
            message: "This is sample info message",
            variant: "info",
            mode: "pester"
        });

        this.dispatchEvent(evt);
    }
}