*** Settings ***
Library    SeleniumLibrary
Resource    ../../resources/common.robot

*** Variables ***
${main_url}    https://cb.jims.net/\
${button_dog_wash}   (//button[contains(text(),'Dog Wash')])[3]
${div_checkbox_container}     //div[@class='col-md-10 mainContainer subServicesContainer']
${checkbox_text}  //label[@class='form-check-label' and contains(text(),'
${button_next}    (//button[@class='btn btn-primary waves-light w-100'])[4]
${div_contact_detail_card}    //div[@class='container-fluid md-form contact-detail card']
${input_address}    //input[@placeholder='Enter your address']
${input_firstname}    //input[@id='firstName']
${input_lastname}    //input[@id='lastName']
${input_phonenumber}    //input[@id='phoneNumber']
${input_email}    //input[@id='emailAddress']
${button_complete}     (//button[contains(text(),'Complete')])[1]
${success_element}    //span[contains(text(), 'Booking Success')]



*** Keywords ***
Open Jims Customer Booking Page
    Open Browser    ${main_url}    gc
    Maximize Browser Window
    Capture Page Screenshot
    
Click Dog Wash Button
     Scroll And Wait Element Into View     ${button_dog_wash}
     Click Button    ${button_dog_wash}
     Wait Until Element is Visible     ${div_checkbox_container}    10
     Capture Page Screenshot
     
Tick Checkbox
    [Arguments]    @{selections}
    FOR    ${selection}    IN    @{selections}
        ${current_checkbox}    Determine Checkbox Element     ${selection}
        Click Element     ${current_checkbox}
    END
    Capture Page Screenshot

Determine Checkbox Element
    [Arguments]    ${text}
    ${element}    Set Variable    ${checkbox_text}${text}')${cl_br}
    ${return_element}    Get Active Element     ${element}
    [Return]     ${return_element}
    
Click Next Button
    Click Button    ${button_next}
    Wait Until Element Is Visible    ${div_contact_detail_card}     10  
    Capture Page Screenshot
    
Enter Contact Details
    [Arguments]     ${address}=Test Address     ${firstname}=Test FName    ${lastname}=Test LName    ${phone}=0212345678    ${email}=test@email.com
    Input Text    ${input_address}    ${address}   
    Input Text    ${input_firstname}    ${firstname}
    Input Text    ${input_lastname}    ${lastname}
    Input Text    ${input_phonenumber}    ${phone}
    Input Text    ${input_email}     ${email}
    Capture Page Screenshot
    
Click Complete Button
    Scroll Element Into View    ${button_complete}
    #Click Button    ${button_complete}
    #Wait Until Element Is Visible    ${success_element}   20
    Capture Page Screenshot
    
Verify That Service Booking is Successful
    ELement Should Be Visible     ${success_element}
    Capture Page Screenshot
    

    
