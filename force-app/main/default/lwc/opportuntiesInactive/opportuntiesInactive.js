import { LightningElement } from 'lwc';

export default class OpportuntiesInactive extends LightningElement {

    opportunityAge

    handleOpportunityAge(event) {
        this.opportunityAge = event.detail.value;
    }

    handleSearch()  {

        
    }
}