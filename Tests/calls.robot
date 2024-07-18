*** Settings ***
Documentation  To Test if the user can place/receive calls
Suite Setup  AppiumServerStart
Suite Teardown  Killing Appium Process
Resource  ../Resources/common.robot
Resource  ../Resources/DataManager.robot


*** Variables ***


*** Test Cases ***
P2P-Call-Outgoing
  [Documentation]  Placing Call
  [Tags]  Calls1
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
  When Ellie places an outgoing call to Leo using plcm 43
  And Leo receives the call from Ellie
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Ellie hangs up the phone on Leo
  Then call is ended between Ellie and Leo

P2P-Call-Incoming
  [Documentation]  Incoming Call
  [Tags]  Calls2
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
  When Leo places an outgoing call to Ellie using plcm42
  And Ellie receives the call from Leo
  And No action is taken for 10 seconds
  Then call is connected between Leo and Ellie
  When Leo hangs up on Ellie
  Then call is ended between Leo and Ellie

P2P-Call-PSTN-Outgoing
  [Tags]  Tvh3
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
  When Ellie place outgoing call to Peter using 14352337723
  And Peter receives the call from Ellie
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Peter
  When Ellie mutes the call
  Then Ellie sees that the call is muted
  When Peter mutes the call
  Then Peter sees that the call is muted
  And No action is taken for 2 minutes
  When Ellie hangs up on Peter
  Then call is ended between Ellie and Peter

P2P-Call-PSTN-Incoming
  [Tags]  Tvh4
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
  When Peter place outgoing call to Ellie using +14084712361
  And Ellie receives the call from Peter
  And No action is taken for 10 seconds
  Then call is connected between Peter and Ellie
  When Peter mutes the call
  Then Peter sees that the call is muted
  When Ellie mutes the call
  Then Ellie sees that the call is muted
  And No action is taken for 2 minutes
  When Peter hangs up on Ellie
  Then call is ended between Peter and Ellie

P2P-Call-Add-PSTN
  [Tags]  Tvh5
  Given Number of users sign up in to their respective Devices  ${Ellie}  ${Leo}
  When Ellie places an outgoing call to Leo using plcm 43
  And Leo receives the call from Ellie
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Ellie will add Peter to the conversation using 18185736427
  And No action is taken for 30 seconds
  Then call is connected between Ellie,Leo and Peter
  When Leo hang up
  And Peter will hangs up the call

P2P-Call-Escalate-Conference
  [Tags]  Tvh6
  Given Number of users sign up in to their respective Devices  ${Ellie}  ${Leo}
  When Ellie places an outgoing call to Leo using plcm 43
  And Leo receives the call from Ellie
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Ellie will add Elizabeth to the conversation using plcm 44
  And No action is taken for 30 seconds
  Then call is connected between Ellie,Leo and Elizabeth
  When Leo hang up
  And Elizabeth will hangs up the call

Conference-Join
  [Tags]  Tvh7
  Given Number of users signs in to their respective Devices  ${Ellie}
  And No action is taken for 10 seconds
  When Ellie joins meeting named single_person_meeting
  And No action is taken for 30 seconds
  Then Ellie sees that join was successful
  And No action is taken for 2 minutes
  When Ellie hangs up
  And No action is taken for 30 seconds
  Then Ellie sees that call ended

Conference-Join-Add-Participant
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
  And No action is taken for 30 seconds
  When Ellie joins the meeting named single_person_meeting
  And No action is taken for 30 seconds
  Then Ellie sees that join was successful
  When Ellie adds Leo to the conversation using plcm38
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Leo mutes the call
  Then Leo sees that the call is muted
  When Leo hangs up
  And No action is taken for 10 seconds
  Then Leo sees that call is ended