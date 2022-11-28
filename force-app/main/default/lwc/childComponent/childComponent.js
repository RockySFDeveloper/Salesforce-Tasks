import { LightningElement,api} from 'lwc';

export default class ChildComponent extends LightningElement {

    showdata = null;

    @api childMethodVisible () {
        this.showdata = 'Hi! I am from Child Component';

    }

    @api childMethodInvisible () {
        this.showdata = null;

    }
}

