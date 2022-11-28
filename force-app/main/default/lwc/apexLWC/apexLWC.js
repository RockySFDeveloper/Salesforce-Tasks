import { wire,LightningElement,track } from 'lwc';
import getContactsImp from '@salesforce/apex/LWCApexClass.getContacts';
export default class ApexLWC extends LightningElement {

    bulkContacts;
    /* @track addBulkContacts=[];
    @wire(getContactsImp)

    contactRecords({data, error}) {

        if(data){ 

            this.bulkContacts = data;
            for(let initiate=0; initiate<this.bulkContacts.length; initiate++) {

                if(this.bulkContacts[initiate].LastName == 'Test') {
                    this.addBulkContacts.push({LastName: this.bulkContacts[initiate].LastName});
                    this.addBulkContacts.push({Phone: this.bulkContacts[initiate].Phone});
                }
            }            
        }
        else if (error) {
            this.error = error;
            this.contacts = undefined;
        }
    } */
    getContacts() {

        getContactsImp().then(result=>{
            this.bulkContacts = result;
            console.log('bc===>'+JSON.stringify(bulkContacts));
        })
        .catch(error=>{
            console.log('Error ===>'+error);
        })
    }
}
