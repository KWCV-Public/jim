*** Settings ***
Library    SeleniumLibrary
Library    ScreenCapLibrary
Library    DateTime
Library    String
Library    Collections

*** Variables ***
${op_br}    [
${cl_br}    ]
${period}   .

*** Keywords ***
Launch Page in Chrome
    [Arguments]    ${url}
    Open Browser    ${url}    gc
    Maximize Browser Window
    
Get Text From Active Element
    [Arguments]     ${element}
    @{web_elements}    Get WebElements    ${element}
    FOR    ${web_element}    IN    @{web_elements}
        ${active_element_text}    Get Text    ${web_element}
        Exit For Loop If    '${active_element_text}' != '${EMPTY}'
    END    
    [Return]    ${active_element_text}
    
Get Active Element
    [Arguments]    ${element}
    @{web_elements}    Get WebElements    ${element}
    FOR    ${web_element}    IN    @{web_elements}
        ${active_element_text}    Get Text    ${web_element}
        Exit For Loop If    '${active_element_text}' != '${EMPTY}'
    END    
    [Return]    ${web_element}
    
Get All Active Elements
    [Arguments]    ${element}
    @{all_elements}    Create List
    @{web_elements}    Get WebElements    ${element}
    FOR    ${web_element}    IN    @{web_elements}
        ${active_element_text}    Get Text    ${web_element}
        ${is_not_empty}    Run Keyword And Return Status    Should Not Be Empty    ${active_element_text}
        Run Keyword If    ${is_not_empty}    Append To List    ${all_elements}    ${web_element}
    END    
    [Return]    @{all_elements}
    
Get All Active Images
    [Arguments]    ${element}
    @{all_elements}    Create List
    @{web_elements}    Get WebElements    ${element}
    FOR    ${web_element}    IN    @{web_elements}
        #${active_element_text}    Get Text    ${web_element}
        ${is_not_empty}    Run Keyword And Return Status    Element Should be Visible    ${web_element}
        Run Keyword If    ${is_not_empty}    Append To List    ${all_elements}    ${web_element}
    END    
    [Return]    @{all_elements}
    
Generate Random Number
    [Arguments]    ${min}   ${max}
    ${max_length}    Get Length    ${max}
    FOR    ${i}    IN RANGE    1    9999
        ${random_number}    Generate Random String    ${max_length}    [NUMBERS]
        ${random_number}    Convert To Integer    ${random_number}
        Exit For Loop If    ${random_number} <= ${max} and ${random_number} >= ${min}
    END
    [Return]    ${random_number}
    
Convert Date To Py Format
    [Arguments]    ${date_to_convert}
    @{date_arr}    Split String    ${date_to_convert}    ${SPACE}
    ${month}    Set Variable If    "${date_arr[0]}" == "January"    01
    ...    "${date_arr[0]}" == "February"    02
    ...    "${date_arr[0]}" == "March"    03
    ...    "${date_arr[0]}" == "April"    04
    ...    "${date_arr[0]}" == "May"    05
    ...    "${date_arr[0]}" == "June"    06
    ...    "${date_arr[0]}" == "July"    07
    ...    "${date_arr[0]}" == "August"    08
    ...    "${date_arr[0]}" == "September"    09
    ...    "${date_arr[0]}" == "October"    10
    ...    "${date_arr[0]}" == "November"    11
    ...    "${date_arr[0]}" == "December"    12
    ${day}    Remove String    ${date_arr[1]}    ,    ${SPACE}
    ${year}    Set Variable    ${date_arr[2]}
    [Return]    ${month}.${day}.${year}
    
Scroll And Wait Element Into View
    [Arguments]    ${element}    ${repeat}=1
    #Run Keyword And Return Status    Scroll Element Into View    ${element}
    #Wait Until Element Is Visible    ${element}    5
    #Capture Page Screenshot
    Set Test Variable    ${in}    1
    FOR    ${in}    IN RANGE    ${repeat}
        Run Keyword And Return Status    Scroll Element Into View    ${element}
        Wait Until Element Is Visible    ${element}    5
        ${is_displayed}    Run Keyword and Return Status    Element Should be Visible    ${element}  
        Capture Page Screenshot
        #Exit for Loop If    ${is_displayed}
    END

Click Element And Wait For Element To Display
    [Arguments]    ${element_to_click}    ${element_to_wait}    ${wait}=10
    Click Element    ${element_to_click}
    Wait Until Element Is Visible    ${element_to_wait}    ${wait}
    
Click Element And Wait For Element To Hide
    [Arguments]    ${element_to_click}    ${element_to_wait}    ${wait}=5
    Click Element    ${element_to_click}
    Wait Until Element Is Not Visible    ${element_to_wait}    ${wait}
    
Remove Line Breaks
    [Arguments]    ${string}
    ${new_string}    Replace String   ${string}    \n    ${SPACE}
    [Return]    ${new_string}

Search For Element Containing Text
    [Arguments]    ${search_element}    ${search_text}
    @{elements}    Get WebElements     ${search_element}
    FOR    ${element}    IN    @{elements}
        ${element_text}    Get Text    ${element}
        Exit For Loop If    "${element_text}" == "${search_text}"
    END
    Scroll ELement Into View    ${element}
    [Return]     ${element}
    
Get Max Array Length Value
    [Arguments]    ${array}
    ${max}    Get Length    ${array}
    ${max}    Evaluate    ${max} - 1
    ${max}    Convert To String    ${max}
    [Return]    ${max}

Enter Text And Wait To Complete
    [Arguments]    ${element}     ${input}
    Input Text    ${element}    ${input}
    Wait Until Element Contains     ${element}     ${input}    5
