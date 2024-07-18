*** Settings ***
Documentation  Below are the Perf test cases
Suite Setup  AppiumServerStart
Suite Teardown  Killing Appium Process
Test Setup   Wakeup device
Resource  ../Resources/common.robot





*** Keywords ***


*** Test Cases ***

Firmware-boot-time
  [Tags]  Tvh0
  Given Number of users signs in to their respective Devices  ${Ellie}
  When Ellie reboots the device
#  And Performance Data is collected for Ellie
  And reboot is repeated for 1 times for Ellie

Signin-Personal-Account
  [Tags]  Tvh1
  Given Number of users signs in to their respective Devices  ${Ellie}  ${Leo}  ${Elizabeth}
  Then Ellie sees that Sign in is successful
  And No action is taken for 30 seconds
  When Ellie signs out from the device
  Then Ellie sees that sign out was successful
  And No action is taken for 10 seconds
#  And Performance Data is collected for Ellie
  And Signin is repeated for 5 times for Ellie

Signin-Shared-Account
  [Tags]  Tvh2
  Given Number of users signs in to their respective Devices  ${Ellie}
  Then Ellie sees that Sign in is successful
  And No action is taken for 30 seconds
  When Ellie signs out from the device
  Then Ellie sees that sign out was successful
#  And Performance Data is collected for Ellie
  And Signin is repeated for 5 times for Ellie

P2P-Call-Outgoing
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

P2P-Call-PhoneNumber-Outgoing
  [Tags]  Tvh4
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
#  And Reset Performance Data
  When Ellie place outgoing call to Leo using 14084719849
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
  When P2P PhoneNumber Outgoing Call is repeated for 5 times for Ellie to Leo using 14084719849

P2P-Call-Incoming
  [Tags]  Tvh5
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
#  And Reset Performance Data
  When Leo place outgoing call to Ellie using plcm42
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
#  And Performance Data is collected for Ellie
  When P2P Call Incoming is repeated for 5 times for Ellie to Leo using displayname

P2P-Call-Phonenumber-Incoming
  [Tags]  Tvh6
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
#  And Reset Performance Data
  When Leo place outgoing call to Ellie using 14084759281
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
#  And Performance Data is collected for Ellie
  When P2P PhoneNumber Incoming call is repeated for 5 times for Ellie to Leo using displayname

P2P-Call-PSTN-Outgoing
  [Tags]  Tvh7
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
#  And Reset Performance Data
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
#  And Performance Data is collected for Ellie
  When P2P Call PSTN Outgoing is repeated for 5 times for Ellie to Peter using phonenumber

P2P-Call-PSTN-Incoming
  [Tags]  Tvh8
  Given Number of users signs up in to their respective Devices  ${Ellie}  ${Leo}
#  And Reset Performance Data
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
#  And Performance Data is collected for Peter
  When P2P Call PSTN Incoming is repeated for 5 times for Peter to Ellie using phonenumber

Meeting-Join
  [Tags]  Tvh9
  Given Number of users signs in to their respective Devices  ${Ellie}
#  And Reset Performance Data
  And No action is taken for 10 seconds
  When Ellie joins meeting named single_person_meeting
  And No action is taken for 30 seconds
  Then Ellie sees that join was successful
  And No action is taken for 2 minutes
  When Ellie hangs up
  And No action is taken for 30 seconds
  Then Ellie sees that call ended
#  And Performance Data is collected for Ellie
  When single_person_meeting Join is repeated for 5 times for Ellie

Meetings-To-Calls-Tab
  [Tags]  Tvh10
  Given Number of users signs in to their respective Devices  ${Ellie}
#  And Reset Performance Data
  When Ellie navigates to Meetings tab
  And No action is taken for 2 minutes
  When Ellie navigates to Calls tab
  And No action is taken for 2 minutes
#  Then Performance Data is collected for Ellie
  When Meetings to calls action is repeated for 5 times for Ellie

Calls-To-Meetings-Tab
  [Tags]  Tvh11
  Given Number of users signs in to their respective Devices  ${Ellie}
#  And Reset Performance Data
  When Ellie navigates to Calls tab
  And No action is taken for 2 minutes
  When Ellie navigates to Meetings tab
  And No action is taken for 2 minutes
#  Then Performance Data is collected for Ellie
  When calls to meetings action is repeated for 5 times for Ellie

Calls-To-VM-Tab
  [Tags]  Tvh12
  Given Number of users signs in to their respective Devices  ${Ellie}
#  And Reset Performance Data
  When Ellie navigates to Calls tab
  And No action is taken for 2 minutes
  When Ellie navigates to Voicemails tab
  And No action is taken for 2 minutes
#  Then Performance Data is collected for Ellie
  When calls to vm action is repeated for 5 times for Ellie

VM-To-Meetings-Tab
  [Tags]  Tvh13
  Given Number of users signs in to their respective Devices  ${Ellie}
#  And Reset Performance Data
  When Ellie navigates to Voicemails tab
  And No action is taken for 2 minutes
  When Ellie navigates to Meetings tab
  And No action is taken for 2 minutes
#  Then Performance Data is collected for Ellie
  When vm to meetings action is repeated for 5 times for Ellie

Scroll-Meetings
  [Tags]  Tvh14
  Given Number of users signs in to their respective Devices  ${Ellie}
#  And Reset Performance Data
  And No action is taken for 30 seconds
  When Ellie scrolls down through meetings
  And No action is taken for 30 seconds
#  And Performance Data is collected for Ellie
  When meeting items scroll is repeated for 5 times for Ellie

Scroll-CallLogIem
  [Tags]  Tvh15
  Given Number of users signs in to their respective Devices  ${Ellie}
#  And Reset Performance Data
  When Ellie scrolls down through CallLogIem
  And No action is taken for 30 seconds
#  And Performance Data is collected for Ellie
  When Call logs scroll is repeated for 5 times for Ellie

Scroll-VMItems
  [Tags]  Tvh16
  Given Number of users signs in to their respective Devices  ${Ellie}
#  And Reset Performance Data
  And No action is taken for 30 seconds
  When Ellie scrolls down through voicemails
  And No action is taken for 30 seconds
#  And Performance Data is collected for Ellie
  When VM items scroll is repeated for 5 times for Ellie

Open-Partner-Settings
  [Tags]  Tvh17
  Given Number of users signs in to their respective Devices  ${Ellie}
  And No action is taken for 30 seconds
  Then Ellie opens partner settings page
  And No action is taken for 10 seconds
  And Ellie comes out of partner settings page
#  Then Performance Data is collected for Ellie
  When Open Partner Settings is repeated for 5 times for Ellie

Add-Participant-In-Meeting
  [Tags]  Tvh18
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
  When Add Participant is repeated for 5 times for Ellie with Leo

P2P-Call-Add-PSTN
  [Tags]  Tvh19
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
  When Add User is repeated for 5 times for Ellie to Leo with Peter using phonenumber

P2P-Call-Escalate-Conference
  [Tags]  Tvh20
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
  When Add User is repeated for 5 times for Ellie to Leo with Elizabeth using displayname