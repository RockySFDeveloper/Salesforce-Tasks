import { LightningElement, api, wire, track } from 'lwc';
import getAllStages from '@salesforce/apex/OpportunityController.getAllStages';

const COLUMNS = [
    {label: 'Name', fieldName: 'Name', type:'text'},
    {label: 'Stage', fieldName: 'StageName', type:'text'}
];

export default class WireDemo extends LightningElement {
    columns = COLUMNS;

    oppresult;
    errorMsg;

    allStages(){
        getAllStages()
        .then(result =>{
            this.oppresult = result;
        })
        .catch(error =>{
            this.errorMsg = error;
        })
    }
}