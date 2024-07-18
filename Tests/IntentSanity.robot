*** Settings ***
Documentation  Below are the SharedPerf Test cases
Suite Setup  AppiumServerStart
Suite Teardown  Killing Appium Process
Test Setup   Wakeup device
Resource  ../Resources/Intent_common.robot
Resource  ../Resources/common.robot
Library  OperatingSystem

*** Test Cases ***

TeamsApp-User-Receive
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
  Then user started the operation
  When Ellie places an outgoing call to Leo using Plcm 43
  And Leo receives the call from Ellie
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Ellie hangs up the phone on Leo
  Then call is ended between Ellie and Leo
  And user check for the intent
  Then clear the logs
  terminate process