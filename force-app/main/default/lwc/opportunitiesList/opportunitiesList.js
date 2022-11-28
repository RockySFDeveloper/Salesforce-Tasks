import { LightningElement,track } from 'lwc';
import getOpportunity from '@salesforce/apex/OpportunityHolder.getOpportunityDetails';

const columns = [
    {
        label: 'Name',
        fieldName: 'OpportunityName',
        type: 'url',
        typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'}
    },{
        label: 'StageName',
        fieldName: 'StageName',
    }, 
];

export default class OpportunitiesList extends LightningElement {

    @track searchData;
    @track columns = columns;
    @track errorMsg = '';
    searchOpportunityName = '';
    searchStageName = '';
    searchCloseDate = '';


    handleOpportunityName(event) {
        this.searchOpportunityName = event.detail.value;
    }

    handleStageName(event) {
        this.searchStageName = event.detail.value;
    }

    handleSearch() {
        if(!this.searchOpportunityName) {
            this.errorMsg = 'Please enter atleast Opportunity name to search.';
            this.searchData = undefined;
            return;
        }

        console.log('======>'+JSON.stringify(this.searchOpportunityName));
        console.log('======>'+JSON.stringify(this.searchStageName));

        getOpportunity({opportunityName : this.searchOpportunityName, stageName : this.searchStageName})
        .then(result => {
            result.forEach((record) => {
                record.OpportunityName = '/' + record.Id;
            });

            this.searchData = result;
            
        })
        .catch(error => {
            this.searchData = undefined;
            window.console.log('error =====> '+JSON.stringify(error));
            if(error) {
                this.errorMsg = error.body.message;
            }
        }) 
    }
}
