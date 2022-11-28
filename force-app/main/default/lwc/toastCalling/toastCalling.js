import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ToastCalling extends LightningElement {

    @api successMesage() {
        const evt = new ShowToastEvent({
            title: "Success",
            message: "Amount Paid Successfully",
            variant: "success",
        });
        this.dispatchEvent(evt);
    }

    @api errorMessageForBlank() {
        const evt = new ShowToastEvent({
            title: "Error",
            message: "Transaction Failed",
            variant: "error",
        });
        this.dispatchEvent(evt);
    }
}