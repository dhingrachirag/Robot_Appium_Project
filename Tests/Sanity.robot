*** Settings ***
Documentation  Below are the Sanity test cases
Suite Setup  AppiumServerStart
Suite Teardown  Killing Appium Process
Test Setup   Wakeup device
Resource  ../Resources/common.robot


*** Variables ***


*** Test Cases ***
Signin-Personal-Account
  [Tags]  Tvh1
  Given Number of users signs in to their respective Devices  ${Ellie}
  Then Ellie sees that Sign in is successful
  When Ellie signs out from the device
  Then Ellie sees that sign out was successful

Signin-Shared-Account
  [Tags]  Tvh2
  Given Number of users signs in to their respective Devices  ${Leo}
  Then Leo sees that Sign in is successful
  When Leo signs out from the device
  Then Leo sees that sign out was successful

P2P-Call-Outgoing
  [Documentation]  Placing Call using displayname
  [Tags]  Outgoing_Displayname
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
  When Ellie places an outgoing call to Leo using plcm 43
  And Leo receives the call from Ellie
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Ellie hangs up the phone on Leo
  Then call is ended between Ellie and Leo

P2P-Call-PhoneNumber-Outgoing
  [Documentation]  Placing Call using Phonenumber
  [Tags]  Outgoing_Phonenumber
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
  When Ellie place outgoing call to Leo using 14084719849
  And Leo receives the call from Ellie
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Ellie hangs up the phone on Leo
  Then call is ended between Ellie and Leo

P2P-Call-Incoming
  [Documentation]  Incoming Call using Displayname
  [Tags]  Incoming_DisplayName
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
  When Leo places an outgoing call to Ellie using plcm42
  And Ellie receives the call from Leo
  And No action is taken for 10 seconds
  Then call is connected between Leo and Ellie
  When Leo hangs up on Ellie
  Then call is ended between Leo and Ellie

P2P-Call-Phonenumber-Incoming
  [Documentation]  Incoming Call using Phonenumber
  [Tags]  Incoming_Phonenumber
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
  When Leo place outgoing call to Ellie using 14084759281
  And Ellie receives the call from Leo
  And No action is taken for 10 seconds
  Then call is connected between Leo and Ellie
  When Leo hangs up on Ellie
  Then call is ended between Leo and Ellie

P2P-Call-Outgoing-Caller-Hold
  [Documentation]  Caller Hold
  [Tags]  Outgoing_Caller_Hold
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
  When Ellie places an outgoing call to Leo using plcm 43
  And Leo receives the call from Ellie
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Ellie holds the call
  Then Ellie sees that the call is on hold
  And Leo sees that the the call is held by Ellie
  When Ellie resumes the call
  Then Ellie sees that the call is resumed
  And Leo sees that the Ellie has resumed the call
  And call is connected between Ellie and Leo
  When Ellie hangs up the phone on Leo
  Then call is ended between Ellie and Leo

P2P-Call-Outgoing-Callee-Hold
  [Documentation]  Callee Hold
  [Tags]  Outgoing_Callee_Hold
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
  When Ellie places an outgoing call to Leo using plcm 43
  And Leo receives the call from Ellie
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Leo will hold the call
  Then Leo sees that the call is on hold
  And Ellie sees that the call is held by Leo
  When Leo resume the call
  Then Leo sees that the call is resumed
  And Ellie sees that the Leo has resumed the phone call
  And call is connected between Ellie and Leo
  When Ellie hangs up the phone on Leo
  Then call is ended between Ellie and Leo

P2P-Call-Incoming-Caller-Hold
  [Documentation]  Caller Hold
  [Tags]  Incoming_Caller_Hold
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
  When Leo places an outgoing call to Ellie using plcm42
  And Ellie receives the call from Leo
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Leo will hold the call
  Then Leo sees that the call is on hold
  And Ellie sees that the call is held by Leo
  When Leo resume the call
  Then Leo sees that the call is resumed
  And Ellie sees that the Leo has resumed the phone call
  And call is connected between Ellie and Leo
  When Leo hangs up on Ellie
  Then call is ended between Ellie and Leo

P2P-Call-Incoming-Callee-Hold
  [Documentation]  Callee Hold
  [Tags]  Incoming_Callee_Hold
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
  When Leo places an outgoing call to Ellie using plcm42
  And Ellie receives the call from Leo
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Ellie holds the call
  Then Ellie sees that the call is on hold
  And Leo sees that the the call is held by Ellie
  When Ellie resumes the call
  Then Ellie sees that the call is resumed
  And Leo sees that the Ellie has resumed the call
  And call is connected between Ellie and Leo
  When Leo hangs up on Ellie
  Then call is ended between Ellie and Leo

P2P-Call-BlindTransfer-Transferor
  [Documentation]  Blind_Transfer
  [Tags]  Blind_Transfer_Transferor
  Given Number of users sign up in to their respective Devices  ${Ellie}  ${Leo}  ${Elizabeth}
  When Ellie places an outgoing call to Leo using plcm 43
  And Leo receives the call from Ellie
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Ellie blind transfers the call with Leo to Elizabeth using plcm 44
  And No action is taken for 10 seconds
  Then call is connected between Leo and Elizabeth
  When Leo hangs up on Elizabeth
  Then call is ended between Leo and Elizabeth

P2P-Call-BlindTransfer-Transferee
  [Documentation]  Blind_Transfer
  [Tags]  Blind_Transfer_Transferee
  Given Number of users sign up in to their respective Devices  ${Ellie}  ${Leo}  ${Elizabeth}
  When Ellie places an outgoing call to Leo using plcm 43
  And Leo receives the call from Ellie
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Leo blind transfers the call with Ellie to Elizabeth using plcm 44
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Elizabeth
  When Ellie hangs up on Elizabeth
  Then call is ended between Ellie and Elizabeth

P2P-Call-BlindTransfer-TransferTarget
  [Documentation]  Blind_Transfer
  [Tags]  Blind_Transfer_TransferTarget
  Given Number of users sign up in to their respective Devices  ${Ellie}  ${Leo}  ${Elizabeth}
  When Elizabeth place an outgoing call to Leo using plcm 43
  And Leo receives the call from Elizabeth
  And No action is taken for 10 seconds
  Then call is connected between Elizabeth and Leo
  When Elizabeth blind transfers the call with Leo to Ellie using plcm42
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Ellie hangs up on Leo
  Then call is ended between Ellie and Leo

P2P-Call-ConsultativeTransfer-Transferor
  [Documentation]  Consultative_Transfer
  [Tags]  Consultative_Transfer_Transferor
  Given Number of users sign up in to their respective Devices  ${Ellie}  ${Leo}  ${Elizabeth}
  When Ellie places an outgoing call to Leo using plcm 43
  And Leo receives the call from Ellie
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Ellie consults with Elizabeth to transfer call with Leo using plcm 44
  And Elizabeth receive the call from Ellie
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Elizabeth
  When Ellie completes consultation with Elizabeth to accept call from Leo using plcm 44
  And No action is taken for 10 seconds
  Then call will connect between Leo and Elizabeth
  When Leo hangs up on Elizabeth
  Then call is ended between Leo and Elizabeth

P2P-Call-ConsultativeTransfer-Transferee
  [Documentation]  Consultative_Transfer
  [Tags]  Consultative_Transfer_Transferee
  Given Number of users sign up in to their respective Devices  ${Ellie}  ${Leo}  ${Elizabeth}
  When Ellie places an outgoing call to Leo using plcm 43
  And Leo receives the call from Ellie
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Leo consults with Elizabeth to transfer call with Ellie using plcm 44
  And Elizabeth receive the call from Leo
  And No action is taken for 10 seconds
  Then call is connected between Leo and Elizabeth
  When Leo completes consultation with Elizabeth to accept call from Ellie using plcm 44
  And No action is taken for 10 seconds
  Then call will connect between Ellie and Elizabeth
  When Ellie is hang up the phone on Elizabeth
  Then call is ended between Ellie and Elizabeth

P2P-Call-ConsultativeTransfer-TransferTarget
  [Documentation]  Consultative_Transfer
  [Tags]  Consultative_Transfer_TransferTarget
  Given Number of users sign up in to their respective Devices  ${Ellie}  ${Leo}  ${Elizabeth}
  When Elizabeth place an outgoing call to Leo using plcm 43
  And Leo receives the call from Elizabeth
  And No action is taken for 10 seconds
  Then call is connected between Elizabeth and Leo
  When Elizabeth consults with Ellie to transfer call with Leo using plcm42
  And Ellie receive the call from Elizabeth
  And No action is taken for 10 seconds
  Then call is connected between Elizabeth and Ellie
  When Elizabeth completes consultation with Ellie to accept call from Leo using plcm42
  And No action is taken for 10 seconds
  Then call will connects between Leo and Ellie
  When Leo hangs up on Ellie
  Then call is ended between Leo and Ellie


P2P-Call-Outgoing-Caller-Mute
  [Documentation]  Caller Mute
  [Tags]  Mute1
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
  When Ellie places an outgoing call to Leo using plcm 43
  And Leo receives the call from Ellie
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Ellie mutes the call
  Then Ellie sees that the call is muted
  When Ellie unmutes the call
  Then Ellie sees that the call is not muted
  When Ellie holds the call
  And call is connected between Ellie and Leo
  When Ellie hangs up the phone on Leo
  Then call is ended between Ellie and Leo

P2P-Call-Outgoing-Callee-Mute
  [Documentation]  Callee Mute
  [Tags]  Mute2
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
  When Ellie places an outgoing call to Leo using plcm 43
  And No action is taken for 5 seconds
  And Leo receives the call from Ellie
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Leo will mute the call
  Then Leo sees that the call is muted
  When Leo will unmute the call
  Then Leo sees that the call is not muted
  When Ellie holds the call
  And call is connected between Ellie and Leo
  When Ellie hangs up the phone on Leo
  Then call is ended between Ellie and Leo

Join-Scheduled-Meeting
  [Tags]  join_meeting
  Given Number of users signs in to their respective Devices  ${Ellie}
  And No action is taken for 10 seconds
  When Ellie joins meeting named single_person_meeting
  And No action is taken for 30 seconds
  Then Ellie sees that join was successful
  And No action is taken for 2 minutes
  When Ellie hangs up
  And No action is taken for 30 seconds
  Then Ellie sees that call ended

Join-Scheduled-Meeting-Mute-and-Hold
  [Tags]  join_meeting-Mute-and-Hold
  Given Number of users signs in to their respective Devices  ${Ellie}
  And No action is taken for 10 seconds
  When Ellie joins meeting named single_person_meeting
  And No action is taken for 30 seconds
  Then Ellie sees that join was successful
  When Ellie mutes the phone call
  Then Ellie sees that the call is muted
  When Ellie unmutes the phone call
  Then Ellie sees that the call is not muted
  When Ellie holds the phone call
  Then Ellie sees that the phone call is on hold
  When Ellie resumes the phone call
  Then Ellie sees that the phone call is resumed
  When Ellie hangs up
  And No action is taken for 30 seconds
  Then Ellie sees that call ended