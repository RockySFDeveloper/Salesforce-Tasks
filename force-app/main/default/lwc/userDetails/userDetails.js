import { LightningElement, track} from 'lwc';

export default class UserDetails extends LightningElement {

    @track userName;

    handleNameChange(event) {
        this.userName = event.target.value;       
    } 

    handleNameChange(event) {
        this.userDegree = event.target.value;       
    }

    handleNameChange(event) {
        this.userAddress = event.target.value;       
    }

    educationDetails() {

    }

    personalDetails() {

    }

    communicationDetails() {

    }

    saveDetails() {

    }
}