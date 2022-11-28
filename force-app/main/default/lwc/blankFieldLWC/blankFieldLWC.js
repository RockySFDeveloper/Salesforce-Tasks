import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class BlankFieldLWC extends LightningElement {

    inputData = "";
    
    handleClick() {

        if(this.inputData == null){

            const evt = new ShowToastEvent({
                title: "Error",
                message: "Field should not be Blank",
                variant: "error",
            });
            this.dispatchEvent(evt);
            
        }

        if(this.inputData.length >= 1){

            const evt = new ShowToastEvent({
                title: "Success",
                message: "This is sample success message",
                variant: "success",
            });
            this.dispatchEvent(evt);
            
        }
    }
    
    
}