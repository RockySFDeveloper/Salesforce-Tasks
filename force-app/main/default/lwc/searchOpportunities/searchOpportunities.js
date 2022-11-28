import { LightningElement, track } from 'lwc';
//importing Opportunity Holder class and its method
import getOpportunity from '@salesforce/apex/OpportunityHolder.getOpportunityDetails';

// Declaring fields which is in Opportunity object
const columns = [
    {
        label: 'Name',
        fieldName: 'OpportunityName',
        type: 'url',
        typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'}
    },{
        label: 'StageName',
        fieldName: 'StageName',
    }, {
        label: 'CloseDate',
        fieldName: 'CloseDate',
        type: 'Date'
    },
];

// Class to get Input values from user and Parse them to Apex class called OpportunityHolder
export default class SearchOpportunities extends LightningElement {

    @track searchData;
    @track columns = columns;
    @track errorMsg = '';
    searchOpportunityName = '';
    searchStageName = '';
    searchCloseDate = '';

    // Getting the onchange input values
    handleOpportunityName(event) {
        this.searchOpportunityName = event.detail.value;
    }

    handleStageName(event) {
        this.searchStageName = event.detail.value;
    }

    /*
        * If searchOpportunityName contains nothing it show error message
        * If searchOpportunityName contains Value it parse value to the called class
    */
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
