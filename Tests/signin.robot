*** Settings ***
Documentation  Signin Scenarios
Suite Setup  AppiumServerStart
Suite Teardown  Killing Appium Process
Library  ../Customlibs/test.py
Resource  ../Resources/common.robot
Resource  ../Resources/DataManager.robot


*** Test Cases ***

Sanity_Check
  [Documentation]  Sanity_Check
  [Tags]  sanity check
  Given Number of users signs in to their respective Devices  ${Ellie}

Sign-in Personal mode
  [Documentation]  Personal Sign-in
  [Tags]  Personal
  Given Number of users signs in to their respective Devices  ${Ellie}
  Then Ellie sees that Sign in is successful
  When Ellie signs out from the device
  Then Ellie sees that sign out was successful

Sign-in Shared mode
  [Documentation]  Shared Sign-in
  [Tags]  Shared
  Given Number of users signs in to their respective Devices  ${Ellie}
  Then Ellie sees that Sign in is successful
  When Ellie signs out from the device
  Then Ellie sees that sign out was successful