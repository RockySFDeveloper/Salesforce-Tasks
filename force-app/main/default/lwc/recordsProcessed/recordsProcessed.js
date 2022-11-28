import { LightningElement, track } from 'lwc';

export default class RecordsProcessed extends LightningElement {

   @track handlemycustomevent = 0;
   handlemycustomevent(event) {
    this.handlemycustomevent = event.details;
   }
}