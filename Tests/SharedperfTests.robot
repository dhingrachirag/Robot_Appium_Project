*** Settings ***
Documentation  Below are the SharedPerf Test cases
Suite Setup  AppiumServerStart
Suite Teardown  Killing Appium Process
Test Setup   Wakeup device
Resource  ../Resources/common.robot

*** Keywords ***


*** Test Cases ***
Firmware-boot-time
  [Tags]  Tvh1
  Given Number of users signs in to their respective Devices  ${Ellie}
  When Ellie reboots the device
#  And Performance Data is collected for Ellie
  And reboot is repeated for 1 times for Ellie

SharedAcct-Sign-in
  [Tags]  Tvh2
  Given Number of users signs in to their respective devices  ${Ellie}
  And No action is taken for 30 seconds
  Then Ellie sees that sign in is successful
  And No action is taken for 2 minutes
  When Ellie signs out from the device
  Then Ellie sees that sign out was successful
#  And Performance Data is collected for Ellie
  And Shared account Signin is repeated for 5 times for Ellie

Shared-P2P-Outgoing-Call
  [Tags]  Tvh3
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
#  And Reset Performance Data
  When Ellie places an outgoing call to Leo using plcm 43
  And Leo receives the call from Ellie
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Ellie mutes the call
  Then Ellie sees that the call is muted
  When Leo mutes the call
  Then Leo sees that the call is muted
  And No action is taken for 2 minutes
  When Ellie hangs up on Leo
  Then call is ended between Ellie and Leo
#  And Performance Data is collected for Ellie
  When P2P Call is repeated for 5 times for Ellie to Leo using plcm 43

Shared-P2P-Incoming-Call
  [Tags]  Tvh4
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
#  And Reset Performance Data
  When Leo places an outgoing call to Ellie using plcm42
  And Ellie receives the call from Leo
  And No action is taken for 10 seconds
  Then call is connected between Leo and Ellie
  When Leo mutes the call
  Then Leo sees that the call is muted
  When Ellie mutes the call
  Then Ellie sees that the call is muted
  And No action is taken for 2 minutes
  When Leo hangs up on Ellie
  Then call is ended between Leo and Ellie
#  And Performance Data is collected for Leo
  When P2P Call Incoming is repeated for 5 times for Leo to Ellie using plcm42

Meeting-Join
  [Tags]  Tvh5
  Given Number of users signs in to their respective devices  ${Ellie}
  And No action is taken for 30 seconds
#  And Reset Performance Data
  When Ellie joins meeting named single_person_meeting
  And No action is taken for 30 seconds
  Then Ellie sees that join was successful
  And No action is taken for 2 minutes
  When Ellie hangs up
  And No action is taken for 30 seconds
  Then Ellie sees that call is ended
#  And Performance Data is collected for Ellie
  When single_person_meeting Join is repeated for 5 times for Ellie

Add-Participant-In-Meeting
  [Tags]  Tvh6
  Given Number of users signs up in to their respective Devices  ${Ellie}
  When Ellie joins the meeting named single_person_meeting
  And No action is taken for 30 seconds
  Then Ellie sees that join was successful
  When Ellie adds Leo to the conversation using plcm 43
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Leo mutes the call
  Then Leo sees that the call is muted
  When Leo hangs up
  And No action is taken for 10 seconds
  Then Leo sees that call is ended
  When Add Participant is repeated for 5 times for Ellie with Leo

P2P-Call-Escalate-Conference
  [Tags]  Tvh7
  Given Number of users sign up in to their respective Devices  ${Ellie}  ${Leo}  ${Elizabeth}
  When Ellie places an outgoing call to Leo using plcm 43
  And Leo receives the call from Ellie
  And No action is taken for 10 seconds
  Then call is connected between Ellie and Leo
  When Ellie will add Elizabeth to the conversation using plcm 44
  And No action is taken for 30 seconds
  Then call is connected between Ellie,Leo and Elizabeth
  When Leo hang up
  And Elizabeth will hangs up the call
  When Add User is repeated for 5 times for Ellie to Leo with Elizabeth using displayname