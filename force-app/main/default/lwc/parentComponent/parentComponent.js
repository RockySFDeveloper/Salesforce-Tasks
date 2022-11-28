import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {

    showChildMethod () {

        this.template.querySelector('c-child-Component').childMethodVisible();
    }

    hideChildMethod () {

        this.template.querySelector('c-child-Component').childMethodInvisible();
    }
}