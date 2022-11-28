import { LightningElement, track} from 'lwc';
import saveResult from '@salesforce/apex/LWCAccountCreation.accountInsert';
import schAccName from '@salesforce/schema/Account.Name';
import schDesc from '@salesforce/schema/Account.Description';
import schPhone from '@salesforce/schema/Account.Phone';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountLWC extends LightningElement {

    @track accounts = {

        Name : schAccName,
        Description : schDesc,
        Phone : schPhone,
    }
    
    handleNameChange(event) {
        this.accounts.Name = event.target.value;
        
    }

    handleDescChange(event) {
        this.accounts.Description = event.target.value;
        
    }

    handlePhoneChange(event) {
        this.accounts.Phone = event.target.value;
    }

    handleClick() {
   
        if(this.accounts.Phone == "" || this.accounts.Description == "" || this.accounts.Name == "") {
            
            this.dispatchEvent(new ShowToastEvent({
                title: "error",
                message: "Dont leave blank fields, Name, Phone and Description must be Entered",
                variant: "error"
            }));  
        }

        if(isNaN(this.accounts.Phone)) {
           
            this.dispatchEvent(new ShowToastEvent({
                title: "error",
                message: "Enter only numbers in Phone",
                variant: "error"
            }));
        }

        if(!isNaN(this.accounts.Description)) {

            this.dispatchEvent(new ShowToastEvent({
                title: "error",
                message: "Enter only Text in Description",
                variant: "error"
            }));
        }

        if(!isNaN(this.accounts.Phone) && (isNaN(this.accounts.Description))) {

            if(this.accounts.Phone != "" && this.accounts.Description != "" && this.accounts.Name != "") {
                            
                saveResult({accountRecords : this.accounts})
                        
                .then(result => {
                
                    console.log('Result ===>'+JSON.stringify(result));
                    this.dispatchEvent(new ShowToastEvent({
                    title: "Success",
                    message: "Account Created Successfully",
                    variant: "success"
                }));       
                
                }).catch(error => {
                
                    this.dispatchEvent(new ShowToastEvent({
                        title: "error",
                        message: "Something Went Wrong, Dont leave blank fields",
                        variant: "error"
                    }));
                    console.log('Error ===>'+JSON.stringify(error));
                });  
            }
        }

        
        
              
    }
}