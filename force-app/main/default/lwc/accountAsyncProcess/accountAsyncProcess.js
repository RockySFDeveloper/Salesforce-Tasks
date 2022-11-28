import { LightningElement,track } from 'lwc';

export default class AccountAsyncProcess extends LightningElement {

   @track recordsProcessed;

   handlRecordsPorcessing(event) {
      this.recordsProcessed = event.detail;
   }
}