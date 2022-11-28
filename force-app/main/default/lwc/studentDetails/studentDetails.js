import { LightningElement, track } from 'lwc';
import contactInsert from '@salesforce/apex/ContactCreation.contactInsert';
import contName from '@salesforce/schema/Contact.LastName';
import contPhone from '@salesforce/schema/Contact.Phone';
import contDesc from '@salesforce/schema/Contact.Description';
import contEmail from '@salesforce/schema/Contact.Email';
import contTitle from '@salesforce/schema/Contact.Title';
import contPassedOut from '@salesforce/schema/Contact.Passed_Out__c';

export default class StudentDetails extends LightningElement {

    activeTab = '1';
    get disableBackButton(){
        return Number(this.activeTab) == 1 ? true : false;
    }

    get disableNextButton(){
        return Number(this.activeTab) == 3 ? true : false;
    }

    goBack(){
        let activeTabValue = Number(this.activeTab) - 1;
        this.activeTab = activeTabValue;
    }
    
    goNext(){

        let activeTabValue = Number(this.activeTab) + 1;
        this.activeTab = activeTabValue;

    }

    @track contacts = {

        LastName : contName,
        Description : contDesc,
        Phone : contPhone,
        Passed_Out__c : contPassedOut,
        Title : contTitle,
        Email : contEmail
    };
    
    handleActive(event) {

        this.activeTab = event.target.value;
    }

    handleNameChange(event) {
        this.contacts.LastName = event.target.value;
        
    }

    handleDescChange(event) {
        this.contacts.Description = event.target.value;
        
    }

    handlePhoneChange(event) {
        this.contacts.Phone = event.target.value;
    }

    handlePassedOutChange(event) {
        this.contacts.Passed_Out__c = event.target.value;
        
    }

    handleCollegeChange(event) {
        this.contacts.Title = event.target.value;
        
    }

    handleEmailChange(event) {
        this.contacts.Email = event.target.value;
    }
    
    handleClick() {       
           
        contactInsert({contactRecords : this.contacts})
        .then(result => {
                    
            console.log('Result ===>'+JSON.stringify(result)); 
            this.template.querySelector('c-toast-Calling').successMesage();         
            window.location.reload();      
            
        }).catch(error => {
            
            console.log('Error ===>'+JSON.stringify(error));
            this.template.querySelector('c-toast-Calling').errorMessageForBlank();
        });              

      
            
            
                                        
    }

        
                
}