import { LightningElement } from 'lwc';

export default class SuperComponent extends LightningElement {

    valueFromChild;
    calledFromChild(event) {
        console.log(event.detail);
        this.valueFromChild = event.detail;
    }
}