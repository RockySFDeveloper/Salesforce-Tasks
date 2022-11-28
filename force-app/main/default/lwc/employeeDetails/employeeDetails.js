import { LightningElement, track } from 'lwc';
import employeeInsert from '@salesforce/apex/EmployeeCreation.employeeInsert'; 
import empName from '@salesforce/schema/Employee_Information_System__c.Name__c';
import empAge from '@salesforce/schema/Employee_Information_System__c.Age__c';
import empDesignation from '@salesforce/schema/Employee_Information_System__c.Designation__c';
import empEmail from '@salesforce/schema/Employee_Information_System__c.Email__c';
import empExperience from '@salesforce/schema/Employee_Information_System__c.Experience__c';
import empPan from '@salesforce/schema/Employee_Information_System__c.PAN__c';
import empPhone from '@salesforce/schema/Employee_Information_System__c.Phone__c';
import empUan from '@salesforce/schema/Employee_Information_System__c.UAN_No__c';
import empAadhar from '@salesforce/schema/Employee_Information_System__c.Aadhar_No__c';
import empExpereinced from '@salesforce/schema/Employee_Information_System__c.Experienced__c';
import empPrevCompany from '@salesforce/schema/Employee_Information_System__c.Previous_Company__c';
import empSkillsPL from '@salesforce/schema/Employee_Information_System__c.Skills_Picklist__c';
import empSkillsSpecifics from '@salesforce/schema/Employee_Information_System__c.Skills_Specifics__c';

export default class EmployeeDetails extends LightningElement {

    @track value;
    @track options= [
        { label: 'Salesforce', value: 'Salesforce' },
        { label: 'Dotnet', value: 'Dotnet' },
        { label: 'JAVA', value: 'JAVA' },
    ];
    @track allValues=[];
    @track optionsMaster=[
        { label: 'Salesforce', value: 'Salesforce' },
        { label: 'Dotnet', value: 'Dotnet' },
        { label: 'JAVA', value: 'JAVA' },
    ];
    @track employees = {

        Name__c : empName,
        Age__c : empAge,
        Designation__c : empDesignation,
        Email__c : empEmail,
        Experience__c : empExperience,
        PAN__c : empPan,
        Phone__c : empPhone,
        Skills_Picklist__c : empSkillsPL,
        empSkillsSpecifics : empSkillsSpecifics,
        UAN_No__c : empUan,
        Aadhar_No__c : empAadhar,
        Experienced__c : empExpereinced,
        Previous_Company__c : empPrevCompany
    };
    uploadedFiles = [];  
    file; fileContents; fileReader; content; fileName;
    @track expValues;

    activeTab = '1';
    get disableBackButton(){
        return Number(this.activeTab) == 1 ? true : false;
    }

    get disableNextButton(){
        return Number(this.activeTab) == 5 ? true : false;
    }

    goBack(){
        let activeTabValue = Number(this.activeTab) - 1;
        this.activeTab = activeTabValue;
    }
    
    goNext(){

        let activeTabValue = Number(this.activeTab) + 1;
        this.activeTab = activeTabValue;
    }

    handleActive(event) {
        this.activeTab = event.target.value;
    }

    handleNameChange(event) {
        this.employees.Name__c = event.target.value;      
    }

    handleAgeChange(event) {
        this.employees.Age__c = event.target.value;      
    }

    handleEmailChange(event) {
        this.employees.Email__c = event.target.value;      
    }

    handlePanChange(event) {
        this.employees.PAN__c = event.target.value;
    }

    handlePhoneChange(event) {
        this.employees.Phone__c = event.target.value;      
    }

    handleSkillsChange(event) {
        this.employees.Skills_Picklist__c = event.target.value;  
        this.value=event.target.value;
        if(!this.allValues.includes(this.value))
        this.allValues.push(this.value);
        this.modifyOptions();   
    }

    handleUanChange(event) {
        this.employees.UAN_No__c = event.target.value;
    }  

    handleAadharChange(event) {
        this.employees.Aadhar_No__c = event.target.value;
    }

    handleUploadChange(event) {

       this.uploadedFiles = event.target.files;  
       this.fileName = event.target.files[0].name;  
       this.file = this.uploadedFiles[0];
    }

    handlePreviousCompany(event) {
        this.employees.Previous_Company__c = event.target.value;
    }    

    handleDesignationChange(event) {
        this.employees.Designation__c = event.target.value;
    }
    
    handleYearOFExperienceChange(event) {
        this.employees.Experience__c = event.target.value;
    }

    handleExperienceChange(event) {
        this.employees.Experienced__c = event.target.checked;
        if(this.employees.Experienced__c == false){
            this.employees.Previous_Company__c = '';
            this.employees.Designation__c = '';
            this.employees.Experience__c = '';
        }
    }

    modifyOptions() {
        this.options=this.optionsMaster.filter(elem=>{
        if(!this.allValues.includes(elem.value))
            return elem;
        })
    }

    handleRemove(event) {

        this.value='';
        const valueRemoved=event.target.name;
        this.allValues.splice(this.allValues.indexOf(valueRemoved),1);
        this.modifyOptions();
    }

    handleClick() {      
        
        this.fileReader = new FileReader();  
        this.fileReader.onloadend = (() => {  
            this.fileContents = this.fileReader.result;
            let base64 = 'base64,';  
            this.content = this.fileContents.indexOf(base64) + base64.length; 
            this.fileContents = this.fileContents.substring(this.content);   
        });  
        this.fileReader.readAsDataURL(this.file); 

        employeeInsert({employeeRecords : this.employees, file : encodeURIComponent(this.fileContents), fileName: this.fileName})
        .then(result => {
                    
            console.log('Result ===>'+JSON.stringify(result)); 
            this.template.querySelector('c-toast-Calling').successMesage();
            this.template.queryselector('c-emp-Api-l-w-c').connectedCallback();
            window.location.reload();           
            
        }).catch(error => {
            
            console.log('Error ===>'+JSON.stringify(error));
            this.template.querySelector('c-toast-Calling').errorMessageForBlank();
        })
    }
}