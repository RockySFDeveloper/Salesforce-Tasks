import { LightningElement } from 'lwc';
import paypalDetails from '@salesforce/apex/PaypalIntegration.getPaypalDetails';

export default class CardDetails extends LightningElement {

    cardNumber;
    expiryDate;
    cvv;

    handleCardNumber(event) {
        this.cardNumber = event.target.value;
    }

    handleExpiryDate(event) {
        this.expiryDate = event.target.value;
    }

    handleCvv(event) {
        this.cvv = event.target.value;
    }

    handlePaypal() {

        paypalDetails({cardNumber : this.cardNumber, expiryDate : this.expiryDate, cvv : this.cvv})
    }
    
}