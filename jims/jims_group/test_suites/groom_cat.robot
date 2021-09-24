*** Settings ***
Library     SeleniumLibrary
Resource    ../pages/services.robot
Test Setup    Open Jims Customer Booking Page
Test Teardown    Close All Browsers

*** Test Cases ***
Verify User Can Book a "Groom my Cat" Service
    Click Dog Wash Button
    Tick Checkbox    Cat Grooming
    Click Next Button
    Enter Contact Details
    Click Complete Button
    Verify That Service Booking is Successful