import { LightningElement } from 'lwc';

export default class AccountDetails extends LightningElement {

    activeTab = '1';
    get bDisableBackBtn(){
        return Number(this.activeTab) == 1 ? true : false;
    }
    get bDisableNextBtn(){
        return Number(this.activeTab) == 4 ? true : false;
    }
    
    handleActive(event) {
     this.activeTab = event.target.value;
    }
    
    goBack(){
        let activeTabValue = Number(this.activeTab) - 1;
        this.activeTab = activeTabValue.toString();
      }
    goNext(){
      let activeTabValue = Number(this.activeTab) + 1;
      this.activeTab = activeTabValue.toString();
    }
}