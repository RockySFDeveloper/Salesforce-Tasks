import { LightningElement } from 'lwc';

export default class SubComponent extends LightningElement {

    toParent;
    handleChild(event) {
        this.toParent = event.detail.value;
    }

    handleClick() {
        console.log('toParent=====>'+this.toParent);
        const custEvent = new CustomEvent('buttons',{detail : this.toParent });
        this.dispatchEvent(custEvent);
    }
}