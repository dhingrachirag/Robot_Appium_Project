*** Settings ***
Library  AppiumLibrary  run_on_failure=Log Source
Library  OperatingSystem
Resource  ../Variables/globalvariables.robot
Resource  Connection.Robot
Library  robot/libraries/Process.py
Library  JSONLibrary
Library  String
Library  Collections
Library  collections


*** Variables ***
${call rating}  com.microsoft.skype.teams.ipphone:id/TextView_CallRatingTextContent
${result}
${result2}
${result3}
${key}

*** Keywords ***
Number of users signs in to their respective Devices
  [Arguments]  ${caller}=a  ${callee}=b  ${callee1}=c  ${callee2}=d
  Log  ${caller},${callee} initiated sign in his/her account.
  ${result}  Set Variable  ${caller}
  Log  ${result}
  Set Global variable  ${result}  ${caller}
  ${result2}  Set Variable   ${callee}
  Log  ${result2}
  Set Global variable  ${result2}  ${callee}
  ${result3}  Set Variable   ${callee1}
  Log  ${result3}
  Set Global variable  ${result3}  ${callee1}
  Log  ${caller},${callee} initiated sign in his/her account.
  ${the file as string}=    Get File    ${users_json_path}
  ${parsed}=    Evaluate  json.loads("""${the file as string}""", object_pairs_hook=collections.OrderedDict)     json, collections
  ${properties}=  Set Variable  ${parsed["users"]}
  Log  ${properties}
  :FOR  ${key}    IN    @{properties}
  \  Continue For Loop If    $key != 'Ellie'
  \  ${sub dict}=    Get From Dictionary    ${properties}    ${key}
  \  Log  ${sub dict}
  \  Signin  ${sub dict}[ip]   ${sub dict}[username]   ${sub dict}[password]  ${sub dict}[Mode]
  \  Log  ${key} is successfully signed in.

Number of users signs up in to their respective Devices
  [Arguments]  ${caller}=a  ${callee}=b  ${callee1}=c  ${callee2}=d
  Log  ${caller},${callee} initiated sign in his/her account.
  ${result}  Set Variable  ${caller}
  Log  ${result}
  Set Global variable  ${result}  ${caller}
  ${result2}  Set Variable   ${callee}
  Log  ${result2}
  Set Global variable  ${result2}  ${callee}
  ${result3}  Set Variable   ${callee1}
  Log  ${result3}
  Set Global variable  ${result3}  ${callee1}
  Log  ${caller},${callee} initiated sign in his/her account.
  ${the file as string}=    Get File    ${users_json_path}
  ${parsed}=    Evaluate  json.loads("""${the file as string}""", object_pairs_hook=collections.OrderedDict)     json, collections
  ${properties}=  Set Variable  ${parsed["users"]}
  Log  ${properties}
  :FOR    ${key}    IN    @{properties}
  \  Run Keyword If  '${key}' == '${Elizabeth}'  Exit For Loop
  \  ${sub dict}=    Get From Dictionary    ${properties}    ${key}
  \  Log  ${sub dict}
  \  Signin  ${sub dict}[ip]   ${sub dict}[username]   ${sub dict}[password]  ${sub dict}[Mode]
  \  Log  ${key} is successfully signed in.

Number of users sign up in to their respective Devices
  [Arguments]  ${caller}=a  ${callee}=b  ${callee1}=c  ${callee2}=d
  Log  ${caller},${callee} initiated sign in his/her account.
  ${result}  Set Variable  ${caller}
  Log  ${result}
  Set Global variable  ${result}  ${caller}
  ${result2}  Set Variable   ${callee}
  Log  ${result2}
  Set Global variable  ${result2}  ${callee}
  ${result3}  Set Variable   ${callee1}
  Log  ${result3}
  Set Global variable  ${result3}  ${callee1}
  Log  ${caller},${callee} initiated sign in his/her account.
  ${the file as string}=    Get File    ${users_json_path}
  ${parsed}=    Evaluate  json.loads("""${the file as string}""", object_pairs_hook=collections.OrderedDict)     json, collections
  ${properties}=  Set Variable  ${parsed["users"]}
  Log  ${properties}
  :FOR    ${key}    IN    @{properties}
  \  ${sub dict}=    Get From Dictionary    ${properties}    ${key}
  \  Log  ${sub dict}
  \  Signin  ${sub dict}[ip]   ${sub dict}[username]   ${sub dict}[password]  ${sub dict}[Mode]
  \  Log  ${key} is successfully signed in.

Parsing Of Json
  ${the file as string}=    Get File    ${users_json_path}
  ${parsed}=    Evaluate  json.loads("""${the file as string}""")    json
  ${properties}=  Set Variable  ${parsed["users"]}
  Log  ${properties}
  :FOR    ${key}    IN    @{properties}
  \  ${sub dict}=    Get From Dictionary    ${properties}    ${key}
  \  Log  ${sub dict}

Killing Appium Process
  ${out}  Terminate Process  ${true}
  Log  ${out}


Clearing Buffer Stream Before Running Any Appium Process
  ${Buffer}  Run And Return Rc And Output  ${Buffer_Stream}
  Log  ${Buffer}
  ${Buffer1}  Run And Return Rc And Output  ${Buffer_Stream1}
  Log  ${Buffer1}

Devices Availability And Connecting
  [Documentation]  This method will check whether we have devices connected in Pool or if not connect the devices and give us the results.
  ${the file as string}=    Get File    ${users_json_path}
  ${parsed}=    Evaluate  json.loads("""${the file as string}""")    json
  ${properties}=  Set Variable  ${parsed["users"]}
  Log  ${properties}
  :FOR  ${key}    IN    @{properties}
  \  ${sub dict}=    Get From Dictionary    ${properties}    ${key}
  \  Log  ${sub dict}
  \  Connection Check
  \  Device check  ${sub dict}[ip]
  \  Log  ${key} device is connected

Device Check
  [Arguments]  ${device_udid}
  ${marf1}  Run And Return Rc And Output  adb connect ${device_udid}
  Log  ${marf1}

Connection Check
  ${marf1}  Run And Return Rc And Output  adb devices
  Log  ${marf1}
  ${the file as string}=    Get File    ${users_json_path}
  ${parsed}=    Evaluate  json.loads("""${the file as string}""")    json
  ${properties}=  Set Variable  ${parsed["users"]}
  Log  ${properties}
  :FOR  ${key}    IN    @{properties}
  \  ${sub dict}=    Get From Dictionary    ${properties}    ${key}
  \  Log  ${sub dict}[ip]


AppiumServerStart
  [Documentation]  It will start appium session in background and check the reachability for the devices.
  Device_Connection_Status
  Devices Availability And Connecting
  Terminate All Processes  kill=${True}
  Clearing Buffer Stream Before Running Any Appium Process
  ${marf4}  Start Process  ${appium_start}  shell=${True}  stdout=C:\\stream\\appium.txt  stderr=C:\\stream\\appiumerr.txt
  Log  ${marf4}
  ${marf5}  Is Process Running
  Log  ${marf5}
  Should Be Equal  ${marf5}  ${True}
  Sleep  10s

Device_Connection_Status
  ${loss_percent}  Run And Return Rc And Output  ${Ping_Ellie}
  Log  ${loss_percent}
  Should Not Contain  ${loss_percent}  Request timed out
  Sleep  5s
  ${loss_percent1}  Run And Return Rc And Output  ${Ping_Leo}
  Log  ${loss_percent1}
  Should Not Contain  ${loss_percent1}   Request timed out
  Sleep  10s

Check_Connection_after_open_application
    ${out}  Get Network Connection Status
    Log  ${out}

Clearing the cache of the devices
  [Arguments]  ${device_udid}
  ${marf1}  Run And Return Rc And Output  adb -s ${device_udid} shell pm clear ${Teams_Package}
  Log  ${marf1}
  Sleep  10s
  ${marf2}  Run And Return Rc And Output  adb -s ${device_udid} shell pm clear ${CompanyPortal_Package}
  Log  ${marf2}
  Sleep  10s

Root Device
  [Arguments]  ${device_udid}
  ${marf1}  Run And Return Rc And Output  adb -s ${device_udid} root
  Log  ${marf1}
  Sleep  10s

Wakeup Device
  ${marf1}  Run And Return Rc And Output  adb shell input keyevent KEYCODE_WAKEUP
  Log  ${marf1}
  Sleep  5s

Input Keycode Enter
  [Arguments]  ${device_udid}
  ${out3}  Run And Return Rc And Output  adb -s ${device_udid} shell input keyevent KEYCODE_ENTER
  Log  ${out3}

Text Input
  [Arguments]  ${text}
#  Wait Until Element Is Visible  i0116
#  Wait Until Element Is Visible  xpath=//android.widget.EditText
  Wait Until Element Is Visible  xpath=(//*[@class="android.widget.EditText"])
  Input Text  xpath=(//*[@class="android.widget.EditText"])  ${text}
  Sleep  10s

Password Input
  [Arguments]  ${password}
  Wait Until Element Is Visible  xpath=//android.widget.EditText
  Sleep  2s
  Input Text  xpath=//android.widget.EditText  ${password}
  Sleep  10s

Common Signin
  [Arguments]  ${udid}  ${user_account}  ${password}  ${mode}
  ${out1}  Log Source
  ...  loglevel='DEBUG'
  Log  ${out1}
  ${out}  Get Appium SessionId
  Log  ${out}
  Sleep  10s
  Launch Application
  Click Button  Sign in
  Sleep  10s
  Text Input  ${user_account}
  Page Should Contain Text  Next
  Sleep  40s
  ${out2}  get element location  xpath=//android.widget.Button
  Log  ${out2}
  Input Keycode Enter  ${udid}
  Password Input  ${password}
#  Wait Until Element Is Visible  xpath=//android.widget.EditText
#  Input Text  xpath=//android.widget.EditText  ${password}
#  Sleep  10s
  Input Keycode Enter  ${udid}
  Sleep  10s
  Run Keyword And Ignore Error  Click Button  Sign in
  Wait Until Element Is Visible
  ...  locator=com.microsoft.skype.teams.ipphone:id/action_last_button
  ...  timeout=60s
  Click Element  com.microsoft.skype.teams.ipphone:id/action_last_button
  Sleep  10s
  Mode Test  ${mode}

Personal operation
  Wait Until Keyword Succeeds  1m  5s  Click Text  Personal  ${true}
  Sleep  10s
  Run Keyword And Ignore Error  Click Element  android:id/button1
  Sleep  10s

Shared Operation
  Wait Until Keyword Succeeds  1m  5s  Click Text  Shared  ${true}
  Sleep  10s
  Run Keyword And Ignore Error  Click Element  android:id/button1
  Sleep  10s

Mode Test
  [Arguments]  ${mode}
  ${result}  Set Variable  ${mode}
  Log  ${result}
  Run Keyword If  '${result}'=='Shared'  Shared operation
  ...              ELSE  Personal Operation

Error Messge for invalid users
  Log  Number of users are insufficient, Hence exiting the calls operation...

Caller Initiated Sign in
  Switch Application  1
  Sleep  10s

Callee Initated Sign in
  Switch Application  2
#  Sleep  5s

callee1 Initated call
  Switch Application  3
  Sleep  10s

Input Display Name
  [Arguments]  ${callee_name}
  Input Text  com.microsoft.skype.teams.ipphone:id/search_src_text  "${callee_name}"
  Sleep  10s

Reboot Device
  [Arguments]  ${device_udid}
  ${marf1}  Run And Return Rc And Output  adb -s ${device_udid} reboot
  Log  ${marf1}
  Sleep  10s

Rebooting the device
  ${the file as string}=    Get File    ${users_json_path}
  ${parsed}=    Evaluate  json.loads("""${the file as string}""", object_pairs_hook=collections.OrderedDict)     json, collections
  ${properties}=  Set Variable  ${parsed["users"]}
  Log  ${properties}
  :FOR    ${key}    IN    @{properties}
  \  ${sub dict}=    Get From Dictionary    ${properties}    ${key}
  \  Log  ${sub dict}
  \  Reboot Device   ${sub dict}[ip]
  \  Log  ${key} is successfully signed in.

${caller} reboots the device
  Rebooting the device

Signin
  [Arguments]  ${udid}  ${user_account}  ${password}  ${mode}
  Root Device  ${udid}
  Clearing the cache of the devices  ${udid}
  Sleep  10s
  Initiating the connection of the users  ${udid}
  Check_Connection_after_open_application
  Common Signin  ${udid}  ${user_account}  ${password}  ${mode}

${caller} sees that Sign in is successful
  Page Should Contain Element  com.microsoft.skype.teams.ipphone:id/action_bar_search_action
  Sleep  30s

${caller} signs out from the device
  Wait Until Page Contains  Open Hamburger menu
  ${log}  Get Element Location  Open Hamburger menu
  Log  ${log}
  Sleep  20s
  Swipe By Percent  1  50  80  90
  Sleep  10s
  Click Element  com.microsoft.skype.teams.ipphone:id/more_settings_button
  Sleep  10s
  Click Element  com.microsoft.skype.teams.ipphone:id/settings_item_sign_out
  Sleep  10s
  Click Element  android:id/button1
  Sleep  20s

${caller} sees that sign out was successful
  Page Should Not Contain Element   com.microsoft.skype.teams.ipphone:id/action_bar_search_action
  Sleep  5s

${caller} receives the call from ${callee}
  Run keyword if  "And ${result}"== "${caller}"  Caller Initiated Sign in
  ...  ELSE  Callee Initated Sign in
  ${out}  Click Element  com.microsoft.skype.teams.ipphone:id/accept_incoming_call
  Log  ${out}
  Log  ${callee} accepted call request from ${caller}
  Sleep  15s

${caller} receive the call from ${callee}
  Run keyword if  "And ${result}"== "${caller}"  Caller Initiated Sign in
  ...  ELSE  callee1 initated call
  ${out}  Click Element  com.microsoft.skype.teams.ipphone:id/accept_incoming_call
  Log  ${out}
  Log  ${callee} accepted call request from ${caller}
  Sleep  15s

Call is connected between ${caller} and ${callee}
  ${out}  Get Source
  Log  ${out}
  Sleep  5s
  Page Should Contain Element  com.microsoft.skype.teams.ipphone:id/call_end_button
  Sleep  5s

call will connect between ${caller} and ${callee}
  Run keyword if  "Then ${result2}"== "${caller}"  Callee Initated Sign in
  ...  ELSE  callee1 initated call
  ${out}  Get Source
  Log  ${out}
  Sleep  5s
  Page Should Contain Element  com.microsoft.skype.teams.ipphone:id/call_end_button
  Sleep  5s

call will connects between ${caller} and ${callee}
  Run keyword if  "Then ${result}"== "${caller}"  Caller Initiated Sign in
  ...  ELSE  Callee Initated Sign in
  ${out}  Get Source
  Log  ${out}
  Page Should Contain Element  com.microsoft.skype.teams.ipphone:id/call_end_button
  Sleep  5s

${caller} hangs up on ${callee}
  Run keyword if  "When ${result}"== "${caller}"  Caller Initiated Sign in
  ...  ELSE  Callee Initated Sign in
  Log  "${caller}" ending the call request
  Click Element  com.microsoft.skype.teams.ipphone:id/call_end_button
  Sleep  10s
  ${out}  Run Keyword And Return Status  Call Rating
  Run Keyword If  ${out}  Close Call Rating
  ...  ELSE   Log Proceed
  Sleep  10s

${caller} hangs up the phone on ${callee}
  Run keyword if  "When ${result}"== "${caller}"  Callee Initated Sign in
  ...  ELSE  Caller Initiated Sign in
  Log  "${caller}" ending the call request
  Click Element  com.microsoft.skype.teams.ipphone:id/call_end_button
  Sleep  10s
  ${out}  Run Keyword And Return Status  Call Rating
  Run Keyword If  ${out}  Close Call Rating
  ...  ELSE   Log Proceed
  Sleep  10s

${caller} is hang up on ${callee}
  Run keyword if  "And ${result2}"== "${caller}"  Callee Initated Sign in
  ...  ELSE  callee1 initated call
  Log  "${caller}" ending the call request
  Click Element  com.microsoft.skype.teams.ipphone:id/call_end_button
  Sleep  10s
  ${out}  Run Keyword And Return Status  Call Rating
  Run Keyword If  ${out}  Close Call Rating
  ...  ELSE   Log Proceed
  Sleep  10s

${caller} is hang up the phone on ${callee}
  Run keyword if  "And ${result2}"== "${caller}"  callee1 initated call
  ...  ELSE  Caller Initiated Sign in
  Log  "${caller}" ending the call request
  Click Element  com.microsoft.skype.teams.ipphone:id/call_end_button
  Sleep  10s
  ${out}  Run Keyword And Return Status  Call Rating
  Run Keyword If  ${out}  Close Call Rating
  ...  ELSE   Log Proceed
  Sleep  10s

Close Call Rating
    Click Element  com.microsoft.skype.teams.ipphone:id/ImageView_CloseCallRating
    Sleep  5s

Call Rating
  ${out}  Get Source
  Log  ${out}
  Should Contain  ${out}  ${call rating}

Log Proceed
  Log  When Call Rating is not required

Call is ended between ${caller} and ${callee}
  Page Should Contain Element  com.microsoft.skype.teams.ipphone:id/toolbar

${caller} mutes the call
  ${result}  Set variable  "${caller}"
  Log  ${result}
  ${callee}  Set variable
  Log  ${callee}
  Run keyword if  ${result}=="${caller}"  Callee Initated Sign in
  ...  ELSE  Caller Initiated Sign in
  Log  ${caller} muting the call request
  Click Element  com.microsoft.skype.teams.ipphone:id/call_control_mute
  Sleep  10s

${caller} will mute the call
  ${result}  Set variable  "${caller}"
  Log  ${result}
  ${callee}  Set variable
  Log  ${callee}
  Run keyword if  ${result}=="${caller}"  Caller Initiated Sign in
  ...  ELSE  Callee Initated Sign in
  Log  ${caller} muting the call request
  Click Element  com.microsoft.skype.teams.ipphone:id/call_control_mute
  Sleep  10s

${caller} mutes the phone call
  Sleep  5s
  Click Element  com.microsoft.skype.teams.ipphone:id/call_control_mute
  Sleep  5s
  Click Element  com.microsoft.skype.teams.ipphone:id/call_control_mute

${caller} sees that the call is muted
  Page Should Contain Element  com.microsoft.skype.teams.ipphone:id/call_control_mute
  Sleep  5s

${caller} unmutes the call
  Switch Application  1
  Log  ${caller} unmuting the call request
  Click Element  com.microsoft.skype.teams.ipphone:id/call_control_mute
  Sleep  10s

${caller} will unmute the call
  Switch Application  2
  Log  ${caller} unmuting the call request
  Click Element  com.microsoft.skype.teams.ipphone:id/call_control_mute
  Sleep  10s

${caller} unmutes the phone call
  Sleep  5s
  Click Element  com.microsoft.skype.teams.ipphone:id/call_control_mute

${caller} sees that the call is not muted
  Page Should Contain Element  com.microsoft.skype.teams.ipphone:id/call_control_mute
  Sleep  5s

${caller} holds the call
#  Switch Application  2
  Run keyword if  "And ${result}"== "${caller}"  Callee Initated Sign in
  ...  ELSE  Caller Initiated Sign in
  Log  ${caller} holds the call
  Click Element  com.microsoft.skype.teams.ipphone:id/call_more_options
  Sleep  5s
  Wait Until Keyword Succeeds  1m  5s  Click Text  Place call on hold  ${true}
  Sleep  10s

${caller} will hold the call
  Run keyword if  "And ${result}"== "${caller}"  Caller Initiated Sign in
  ...  ELSE  Callee Initated Sign in
  Log  ${caller} holds the call
  Click Element  com.microsoft.skype.teams.ipphone:id/call_more_options
  Sleep  5s
  Wait Until Keyword Succeeds  1m  5s  Click Text  Place call on hold  ${true}
  Sleep  10s

${caller} holds the phone call
  Click Element  com.microsoft.skype.teams.ipphone:id/call_more_options
  Sleep  5s
  Wait Until Keyword Succeeds  1m  5s  Click Text  Place call on hold  ${true}
  Sleep  10s

"${caller}" holds the call
  Log  ${caller} holds the call
  Click Element  com.microsoft.skype.teams.ipphone:id/call_more_options
  Sleep  5s
  Wait Until Keyword Succeeds  1m  5s  Click Text  Place call on hold  ${true}
  Sleep  10s

${caller} sees that the call is on hold
  Page Should Contain Element  com.microsoft.skype.teams.ipphone:id/call_more_options
  Sleep  5s

${callee} sees that the the call is held by ${caller}
  Switch Application  2
  Page Should Contain Text  Call on hold
  Sleep  5s

${callee} sees that the call is held by ${caller}
  Switch Application  1
  Page Should Contain Text  Call on hold
  Sleep  5s

${callee} sees that the phone call is on hold
  Page Should Contain Element  com.microsoft.skype.teams.ipphone:id/call_unhold_button

${caller} resumes the call
  Switch Application  1
  Log  ${caller} resumes the call
  Click Element  com.microsoft.skype.teams.ipphone:id/call_unhold_button
  Sleep  5s

${caller} resumes the phone call
  Click Element  com.microsoft.skype.teams.ipphone:id/call_unhold_button
  Sleep  5s

${caller} resume the call
  Switch Application  2
  Log  ${caller} resumes the call
  Click Element  com.microsoft.skype.teams.ipphone:id/call_unhold_button
  Sleep  5s

${caller} sees that the call is resumed
  Log  ${caller} sees that call is resumed
  Page Should Contain Element  com.microsoft.skype.teams.ipphone:id/showRoster
  Sleep  5s

${caller} sees that the phone call is resumed
  Page Should Contain Element  com.microsoft.skype.teams.ipphone:id/toolbar
  Sleep  5s

${callee} sees that the ${caller} has resumed the call
  Switch Application  2
  Page Should Contain Element  com.microsoft.skype.teams.ipphone:id/showRoster
  Sleep  5s

${callee} sees that the ${caller} has resumed the phone call
  Switch Application  1
  Page Should Contain Element  com.microsoft.skype.teams.ipphone:id/showRoster
  Sleep  5s

${transferor} blind transfers the call with ${transferee} to ${transfertarget} using ${callee_name}
  Run keyword if  "When ${result}"== "${transferor}"  Caller Initiated Sign in
  ...  ELSE IF  "When ${result2}"== "${transferor}"  Callee Initated Sign in
  ...  ELSE IF  "When ${result3}"== "${transferor}"  callee1 initated call
  Log  ${transferor} blind transfers the call
  Click Element  com.microsoft.skype.teams.ipphone:id/call_more_options
  Sleep  5s
  Wait Until Keyword Succeeds  1m  5s  Click Text  Transfer  ${true}
  Sleep  5s
  Wait Until Keyword Succeeds  1m  5s  Click Text  Transfer now  ${true}
  Sleep  5s
  Wait Until Element Is Visible  com.microsoft.skype.teams.ipphone:id/search_contact_box
  Sleep  5s
  Input Text  com.microsoft.skype.teams.ipphone:id/search_contact_box  ${callee_name}
  Sleep  5s
  Click Element  com.microsoft.skype.teams.ipphone:id/search_result_item_container

${transferor} consults with ${transferee} to transfer call with ${transfertarget} using ${callee_name}
  Run keyword if  "When ${result}"== "${transferor}"  Caller Initiated Sign in
  ...  ELSE IF  "When ${result2}"== "${transferor}"  Callee Initated Sign in
  ...  ELSE IF  "When ${result3}"== "${transferor}"  callee1 initated call
  Log  ${transferor} consults ${transferee} the call
  Click Element  com.microsoft.skype.teams.ipphone:id/call_more_options
  Sleep  5s
  Wait Until Keyword Succeeds  1m  5s  Click Text  Transfer  ${true}
  Sleep  5s
  Wait Until Keyword Succeeds  1m  5s  Click Text  Consult first  ${true}
  Sleep  5s
  Click Element  com.microsoft.skype.teams.ipphone:id/search_contact_box
  Sleep  5s
  Input Text  com.microsoft.skype.teams.ipphone:id/search_contact_box  ${callee_name}
  Sleep  5s
  Click Element  com.microsoft.skype.teams.ipphone:id/search_result_item_container

${transferor} completes consultation with ${transfertarget} to accept call from ${transferee} using ${callee_name}
  Run keyword if  "When ${result}"== "${transferor}"  Caller Initiated Sign in
  ...  ELSE IF  "When ${result2}"== "${transferor}"  Callee Initated Sign in
  ...  ELSE IF  "When ${result3}"== "${transferor}"  callee1 initated call
  Log  ${transferor} completes consultation with ${transfertarget}
  Click Element  com.microsoft.skype.teams.ipphone:id/transfer_button
  Sleep  5s
  Click Element  android:id/button1
  Sleep  10s

${transferor} sees that call is ended
  Log  "${transferor}" sees that call is ended
  Page Should Contain Element  com.microsoft.skype.teams.ipphone:id/toolbar

Adding Participant to Conference through caller
  [Arguments]  ${callees}  ${callee_name}  ${caller}
  Switch Application  1
  Log  ${caller} is adding ${callee_name} to the conference.
  Click Element  com.microsoft.skype.teams.ipphone:id/showRoster
  Sleep  10s
  Click Element  com.microsoft.skype.teams.ipphone:id/add_member_to_meeting
  Sleep  10s
  Wait Until Element Is Visible  com.microsoft.skype.teams.ipphone:id/search_contact_box
  Input Text  com.microsoft.skype.teams.ipphone:id/search_contact_box  ${callees}
  Sleep  10s
  Click Element  com.microsoft.skype.teams.ipphone:id/search_result_item_container
  Sleep  10s
  Click Element  com.microsoft.skype.teams.ipphone:id/save_contacts
  Sleep  10s
  ${marf1}  Get Element Location  Back
  Log  ${marf1}


Adding Participant to Conference through callee
  [Arguments]  ${callee}  ${callee_name}  ${callees}
  Switch Application  2
  Log  ${callee} is adding ${callee_name} to the conference.
  Click Element  com.microsoft.skype.teams.ipphone:id/showRoster
  Sleep  10s
  Click Element  com.microsoft.skype.teams.ipphone:id/add_member_to_meeting
  Sleep  10s
  Wait Until Element Is Visible  com.microsoft.skype.teams.ipphone:id/search_contact_box
  Input Text  com.microsoft.skype.teams.ipphone:id/search_contact_box  ${callees}
  Sleep  10s
  Click Element  com.microsoft.skype.teams.ipphone:id/search_result_item_container
  Sleep  10s
  Click Element  com.microsoft.skype.teams.ipphone:id/save_contacts
  Sleep  10s
  ${marf1}  Get Element Location  Back
  Log  ${marf1}

"${caller}" joins meeting named "${single_person_meeting}"
  Switch Application  1
  Click Element  com.microsoft.skype.teams.ipphone:id/meeting_list_item_name
  SLeep  10s
  Click Element  com.microsoft.skype.teams.ipphone:id/meeting_list_item_join_button
  Sleep  30s

"${caller}" adds "${callee} to the conversation using display name
  Click Element  com.microsoft.skype.teams.ipphone:id/showRoster
  Sleep  10s
  Click Element  com.microsoft.skype.teams.ipphone:id/see_more_text
  Sleep  5s
  Click A Point
  ...  x=0.0
  ...  y=491.0
  Sleep  10s
  Wait Until Keyword Succeeds  1m  5s  Click Text  Call into the meeting  ${true}
  Sleep  20s
  ${marf1}  Get Element Location  Back
  Log  ${marf1}

"${caller}" sees that join was succcessful
  Page Should Contain Element  com.microsoft.skype.teams.ipphone:id/search_container
  Sleep  5s

"${caller}" hangs up
  Click Element  com.microsoft.skype.teams.ipphone:id/call_end_button
  Sleep  10s

"${caller}" joins meeting named "${single_person_meeting}" in Personal mode
  Switch Application  1
  Wait Until Keyword Succeeds  1m  5s  Click Text  Meetings  ${true}
  Sleep  5s
  Click Element  com.microsoft.skype.teams.ipphone:id/meeting_name
  SLeep  10s
  Click Element  com.microsoft.skype.teams.ipphone:id/join_button
  Sleep  30s

"${caller}" adds "${callee}" to the conversation by searching and adding "${callee_name}"
  Click Element  com.microsoft.skype.teams.ipphone:id/showRoster
  Sleep  10s
  Click Element  com.microsoft.skype.teams.ipphone:id/add_member_to_meeting
  Sleep  5s
  Click Element  com.microsoft.skype.teams.ipphone:id/search_contact_box
  Input Text  com.microsoft.skype.teams.ipphone:id/search_contact_box  ${callee_name}
  Hide Keyboard
  Sleep  5s
  Click Element  com.microsoft.skype.teams.ipphone:id/search_result_item_container
  Sleep  10s
  Click Element  com.microsoft.skype.teams.ipphone:id/save_contacts
  Sleep  10s

No action is taken for 10 seconds
  Sleep  10s

No action is taken for 5 seconds
  Sleep  5s

No action is taken for 30 seconds
  Sleep  30s

No action is taken for 2 minutes
  Sleep  60s

${caller} places an outgoing call to ${callee} using ${callee_name}
  Run keyword if  "When ${result}"== "${caller}"  Caller Initiated Sign in
  ...  ELSE  Callee Initated Sign in
  Log  ${caller} initiated call request to ${callee}
  Sleep  5s
  Click Element  com.microsoft.skype.teams.ipphone:id/action_bar_search_action
  Sleep  10s
  Input Text  com.microsoft.skype.teams.ipphone:id/search_src_text  ${callee_name}
  Wait Until Keyword Succeeds  1m  5s  Click Element  com.microsoft.skype.teams.ipphone:id/search_result_item_container
  Sleep  10s
  Log  ${caller} placing call to ${callee}
  Sleep  10s
  Click Element  xpath=//android.widget.ImageView[@content-desc='Make an audio call']
  Sleep  5s

${caller} place outgoing call to ${callee} using ${callee_name}
  Run keyword if  "When ${result}"== "${caller}"  Caller Initiated Sign in
  ...  ELSE  Callee Initated Sign in
  Log  ${caller} initiated call request to ${callee}
  Sleep  5s
  Click Element  com.microsoft.skype.teams.ipphone:id/action_bar_search_action
  Sleep  10s
  Input Text  com.microsoft.skype.teams.ipphone:id/search_src_text  ${callee_name}
  Wait Until Keyword Succeeds  1m  5s  Click Element  com.microsoft.skype.teams.ipphone:id/search_result_item_container
  Sleep  10s
  Log  ${caller} placing call to ${callee}
  Sleep  5s

${caller} place an outgoing call to ${callee} using ${callee_name}
  Run keyword if  "When ${result}"== "${caller}"  Caller Initiated Sign in
  ...  ELSE  callee1 initated call
  Log  ${caller} initiated call request to ${callee}
  Click Element  com.microsoft.skype.teams.ipphone:id/action_bar_search_action
  Sleep  10s
  Input Text  com.microsoft.skype.teams.ipphone:id/search_src_text  ${callee_name}
  Wait Until Keyword Succeeds  1m  5s  Click Element  com.microsoft.skype.teams.ipphone:id/search_result_item_container
  Sleep  10s
  Log  ${caller} placing call to ${callee}
  Click A Point
  ...  x=484.0
  ...  y=239.0
  Sleep  10s

Number of users sign in to their respective Devices
  [Arguments]  ${caller}=a  ${callee}=b  ${callee1}=c  ${callee2}=d
  Log  ${caller},${callee} initiated sign in his/her account.
  ${result}  Set Variable  ${caller}
  Log  ${result}
  Set Global variable  ${result}  ${caller}
  ${result2}  Set Variable   ${callee}
  Log  ${result2}
  Set Global variable  ${result2}  ${callee}
  ${result3}  Set Variable   ${callee1}
  Log  ${result3}
  Set Global variable  ${result3}  ${callee1}
  Log  ${caller},${callee} initiated sign in his/her account.
  ${the file as string}=    Get File    ${users_json_path}
  ${parsed}=    Evaluate  json.loads("""${the file as string}""", object_pairs_hook=collections.OrderedDict)     json, collections
  ${properties}=  Set Variable  ${parsed["users"]}
  Log  ${properties}
  :FOR    ${key}    IN    @{properties}
  \  ${sub dict}=    Get From Dictionary    ${properties}    ${key}
  \  Log  ${sub dict}
  \  common signin1  ${sub dict}[ip]   ${sub dict}[username]   ${sub dict}[password]  ${sub dict}[Mode]
  \  Log  ${key} is successfully signed in.


Common Signin1
  [Arguments]  ${udid}  ${user_account}  ${password}  ${mode}
  ${out1}  Log Source
  ...  loglevel='DEBUG'
  Log  ${out1}
  ${out}  Get Appium SessionId
  Log  ${out}
  Sleep  10s
  Launch Application
  Click Button  Sign in
  Sleep  10s
  Text Input  ${user_account}
  Page Should Contain Text  Next
  Sleep  40s
  ${out2}  get element location  idSIButton9
  Log  ${out2}
  Input Keycode Enter  ${udid}
  Wait Until Element Is Visible  i0118
  Input Text  i0118  ${password}
  Sleep  10s
  Input Keycode Enter  ${udid}
  Sleep  10s
  Run Keyword And Ignore Error  Click Button  Sign in
  Sleep  10s
  Mode Test  ${mode}

Multiple sign in
  Killing Appium Process
  Sleep  10s
  ${marf4}  Start Process  ${appium_start}  shell=${True}  stdout=C:\\stream\\appium.txt  stderr=C:\\stream\\appiumerr.txt
  Log  ${marf4}
  ${marf5}  Is Process Running
  Log  ${marf5}
  Should Be Equal  ${marf5}  ${True}
  Sleep  10s
  Number of users sign in to their respective Devices
  Ellie signs out from the device

Multiple P2P Call Outgoing
  Ellie place a outgoing call to Leo using plcm 43
  Sleep  5s
  Leo receives the call from Ellie
  No action is taken for 10 seconds
  call is connected between Ellie and Leo
  Ellie mutes the call
  Ellie sees that the call is muted
  Leo mutes the call
  Leo sees that the call is muted
  No action is taken for 2 minutes
  Ellie hang up on Leo
  call is ended between Ellie and Leo

${caller} place a outgoing call to ${callee} using ${callee_name}
  Run keyword if  "When ${result}"== "${caller}"  Callee Initated Sign in
  ...  ELSE  Caller Initiated Sign in
  Log  ${caller} initiated call request to ${callee}
  Log  ${caller} placing call to ${callee}
  Click A Point
  ...  x=484.0
  ...  y=239.0
  Sleep  10s

${caller} places outgoing call to ${callee} using ${callee_name}
  Run keyword if  "When ${result}"== "${caller}"  Callee Initated Sign in
  ...  ELSE  Caller Initiated Sign in
  Log  ${caller} initiated call request to ${callee}
  Log  ${caller} placing call to ${callee}
  Click A Point
  ...  x=484.0
  ...  y=239.0
  Sleep  10s

${caller} makes an outgoing call to ${callee} using ${callee_name}
  Run keyword if  "When ${result}"== "${caller}"  Caller Initiated Sign in
  ...  ELSE  Callee Initated Sign in
  Log  ${caller} initiated call request to ${callee}
  Log  ${caller} placing call to ${callee}
  Click A Point
  ...  x=484.0
  ...  y=239.0
  Sleep  10s

${caller} joins meeting named single_person_meeting
  Click A Point
  ...  x=428.0
  ...  y=542.0
  Sleep  5s
  Click Element  com.microsoft.skype.teams.ipphone:id/join_button
  Sleep  5s


${caller} joins the meeting named single_person_meeting
  Run keyword if  "And ${result}"== "${caller}"  Callee Initated Sign in
  ...  ELSE  Caller Initiated Sign in
  Click A Point
  ...  x=428.0
  ...  y=542.0
  Sleep  5s
  Click Element  com.microsoft.skype.teams.ipphone:id/join_button
  Sleep  5s

${caller} sees that join was successful
  Page Should Contain Element  com.microsoft.skype.teams.ipphone:id/toolbar
  Sleep  10s

${caller} hangs up
  Click Element  com.microsoft.skype.teams.ipphone:id/call_end_button
  Sleep  5s

${caller} hang up
  Run keyword if  "And ${result}"== "${caller}"  Caller Initiated Sign in
  ...  ELSE  Callee Initated Sign in
  Click Element  com.microsoft.skype.teams.ipphone:id/call_end_button
  Sleep  5s

${caller} will hangs up the call
  Run keyword if  "And ${result}"== "${caller}"  Caller Initiated Sign in
  ...  ELSE  callee1 Initated call
  Click Element  com.microsoft.skype.teams.ipphone:id/call_end_button
  Sleep  5s

${caller} sees that call ended
  Page Should Contain Element  com.microsoft.skype.teams.ipphone:id/toolbar

${caller} navigates to Meetings tab
  Click A Point
  ...  x=428.0
  ...  y=542.0
  Sleep  5s

${caller} navigates to Calls tab
  Click A Point
  ...  x=260.0
  ...  y=542.0
  Sleep  5s

${caller} navigates to Voicemails tab
  Click A Point
  ...  x=596.0
  ...  y=542.0
  Sleep  5s

${caller} opens partner settings page
  Wait Until Page Contains  Open Hamburger menu
  ${log}  Get Element Location  Open Hamburger menu
  Log  ${log}
  Sleep  20s
  Swipe By Percent  1  50  40  50
  Sleep  10s
  Click Element  com.microsoft.skype.teams.ipphone:id/more_settings_container
  Sleep  5s
  Click Element  com.microsoft.skype.teams.ipphone:id/settings_partner_settings_layout
  Sleep  5s

${caller} comes out of partner settings page
  Click Element  com.yealink.setting.t58cp:id/tv_back
  Sleep  5s
  Wait Until Element Is Visible  xpath=(//*[@class="android.widget.ImageButton"])
  Click Element  xpath=(//*[@class="android.widget.ImageButton"])
  Sleep  10s

${caller} scrolls down through meetings
  Click A Point
  ...  x=428.0
  ...  y=542.0
  Sleep  5s
  Swipe  0.1  0.4  5  5.5

${caller} scrolls down through CallLogIem
  Click A Point
  ...  x=260.0
  ...  y=542.0
  Sleep  5s
  Swipe  0.1  0.4  5  5.5

${caller} scrolls down through voicemails
  Click A Point
  ...  x=596.0
  ...  y=542.0
  Sleep  5s
  Swipe  0.1  0.4  5  5.5

${caller} adds ${callee} to the conversation using ${callee_name}
  Click Element  com.microsoft.skype.teams.ipphone:id/showRoster
  Sleep  5s
  Click Element  com.microsoft.skype.teams.ipphone:id/add_member_to_meeting
  Sleep  10s
  Input Text  com.microsoft.skype.teams.ipphone:id/search_contact_box  ${callee_name}
  Wait Until Keyword Succeeds  1m  5s  Click Element  com.microsoft.skype.teams.ipphone:id/search_result_item_container
  Sleep  10s
  Click Element  com.microsoft.skype.teams.ipphone:id/save_contacts
  Sleep  5s
  Run keyword if  "And ${result}"== "${caller}"  Caller Initiated Sign in
  ...  ELSE  Callee Initated Sign in
  ${out}  Click Element  com.microsoft.skype.teams.ipphone:id/call_phone
  Log  ${out}
  Log  ${callee} accepted call request from ${caller}
  Sleep  15s

${caller} will add ${callee} to the conversation using ${callee_name}
  Sleep  10s
    Run keyword if  "And ${result}"== "${caller}"  Callee Initated Sign in
  ...  ELSE  Caller Initiated Sign in
  Sleep  5s
  Click Element  com.microsoft.skype.teams.ipphone:id/showRoster
  Sleep  5s
  Click Element  com.microsoft.skype.teams.ipphone:id/add_member_to_meeting
  Sleep  10s
  Input Text  com.microsoft.skype.teams.ipphone:id/search_contact_box  ${callee_name}
  Wait Until Keyword Succeeds  1m  5s  Click Element  com.microsoft.skype.teams.ipphone:id/search_result_item_container
  Sleep  10s
  Click Element  com.microsoft.skype.teams.ipphone:id/save_contacts
  Sleep  10s
    Run keyword if  "And ${result}"== "${caller}"  Caller Initiated Sign in
  ...  ELSE  callee1 Initated call
    ${out}  Click Element  com.microsoft.skype.teams.ipphone:id/call_phone
  Log  ${out}
  Log  ${callee} accepted call request from ${caller}
  Sleep  15s


Multiple P2P PhoneNumber Outgoing
  Ellie places outgoing call to Leo using 14084719849
  Leo receives the call from Ellie
  No action is taken for 10 seconds
  call is connected between Ellie and Leo
  Ellie mutes the call
  Ellie sees that the call is muted
  Leo mutes the call
  Leo sees that the call is muted
  No action is taken for 2 minutes
  Ellie hang up on Leo
  call is ended between Ellie and Leo

${caller} hang up on ${callee}
  Run keyword if  "When ${result}"== "${caller}"  Caller Initiated Sign in
  ...  ELSE  Callee Initated Sign in
  Log  "${caller}" ending the call request
  Click Element  com.microsoft.skype.teams.ipphone:id/call_end_button
  Sleep  10s

${caller} pick up the call from ${callee}
  Run keyword if  "And ${result}"== "${caller}"  Callee Initated Sign in
  ...  ELSE  Caller Initiated Sign in
  ${out}  Click Element  com.microsoft.skype.teams.ipphone:id/call_phone
  Log  ${out}
  Log  ${callee} accepted call request from ${caller}
  Sleep  15s

${caller} makes a outgoing call to ${callee} using ${callee_name}
  Run keyword if  "When ${result}"== "${caller}"  Caller Initiated Sign in
  ...  ELSE  Callee Initated Sign in
  Log  ${caller} initiated call request to ${callee}
  Click Element  com.microsoft.skype.teams.ipphone:id/search_result_item_container
  Log  ${caller} placing call to ${callee}
  Click A Point
  ...  x=484.0
  ...  y=239.0
  Sleep  10s

Multiple P2P Call Incoming
  Leo makes an outgoing call to Ellie using plcm42
  Ellie pick up the call from Leo
  No action is taken for 10 seconds
  call is connected between Leo and Ellie
  Leo mutes the call
  Leo sees that the call is muted
  Ellie mutes the call
  Ellie sees that the call is muted
  No action is taken for 2 minutes
  Leo hang up on Ellie
  call is ended between Leo and Ellie

Multiple P2P PhoneNumber Incoming
  Leo makes a outgoing call to Ellie using 14084759281
  Ellie pick up the call from Leo
  No action is taken for 10 seconds
  call is connected between Leo and Ellie
  Leo mutes the call
  Leo sees that the call is muted
  Ellie mutes the call
  Ellie sees that the call is muted
  No action is taken for 2 minutes
  Leo hang up on Ellie
  call is ended between Leo and Ellie

Multiple P2P Call PSTN Outgoing
  Ellie places outgoing call to Peter using 14352337723
  Peter receives the call from Ellie
  No action is taken for 10 seconds
  call is connected between Ellie and Peter
  Ellie mutes the call
  Ellie sees that the call is muted
  Peter mutes the call
  Peter sees that the call is muted
  No action is taken for 2 minutes
  Ellie hang up on Peter
  call is ended between Ellie and Peter

Multiple P2P Call PSTN Incoming
  Peter makes a outgoing call to Ellie using +14084712361
  Ellie pick up the call from Peter
  No action is taken for 10 seconds
  call is connected between Peter and Ellie
  Peter mutes the call
  Peter sees that the call is muted
  Ellie mutes the call
  Ellie sees that the call is muted
  No action is taken for 2 minutes
  Peter hang up on Ellie
  call is ended between Peter and Ellie

Multiple single_person_meeting
  Sleep  10s
  Ellie joins meeting named single_person_meeting
  No action is taken for 30 seconds
  Ellie sees that join was successful
  No action is taken for 30 seconds
  Ellie hangs up
  No action is taken for 30 seconds
  Ellie sees that call ended

Multiple Meetings to calls Tab
  Ellie navigates to Meetings tab
  No action is taken for 2 minutes
  Ellie navigates to Calls tab
  No action is taken for 2 minutes

Multiple call to Meetings Tab
  Ellie navigates to Calls tab
  No action is taken for 2 minutes
  Ellie navigates to Meetings tab
  No action is taken for 2 minutes

Multiple call to VM Tab
  Ellie navigates to Calls tab
  No action is taken for 2 minutes
  Ellie navigates to Voicemails tab
  No action is taken for 2 minutes

Multiple vm to meetings Tab
  Ellie navigates to Voicemails tab
  No action is taken for 2 minutes
  Ellie navigates to Meetings tab
  No action is taken for 2 minutes

Multiple Open Partner Settings
  Sleep  5s
  Ellie opens partner settings page
  No action is taken for 10 seconds
  Ellie comes out of partner settings page

Multiple Meeting items scroll
  Sleep  5s
  Ellie scrolls down through meetings
  No action is taken for 30 seconds

Multiple Call logs scroll
  Sleep  5s
  Ellie scrolls down through CallLogIem
  No action is taken for 30 seconds

Multiple VM items scroll
  Sleep  5s
  Ellie scrolls down through voicemails
  No action is taken for 30 seconds

Multiple Add Participant
  Sleep  10s
  Ellie joins the meeting named single_person_meeting
  No action is taken for 30 seconds
  Ellie sees that join was successful
  Ellie adds Leo to the conversation using plcm38
  No action is taken for 10 seconds
  call is connected between Ellie and Leo
  Leo mutes the call
  Leo sees that the call is muted
  Leo hangs up
  No action is taken for 10 seconds
  Leo sees that call is ended

Multiple Add User
  Ellie places outgoing call to Leo using plcm 43
  Leo receives the call from Ellie
  No action is taken for 10 seconds
  call is connected between Ellie and Leo
  Ellie will add Elizabeth to the conversation using plcm 44
  No action is taken for 30 seconds
  call is connected between Ellie,Leo and Elizabeth
  Leo hang up
  Elizabeth will hangs up the call

Multiple Reboot
  Ellie reboots the device

Multiple Shared account Signin
  Killing Appium Process
  Sleep  10s
  ${marf4}  Start Process  ${appium_start}  shell=${True}  stdout=C:\\stream\\appium.txt  stderr=C:\\stream\\appiumerr.txt
  Log  ${marf4}
  ${marf5}  Is Process Running
  Log  ${marf5}
  Should Be Equal  ${marf5}  ${True}
  Sleep  10s
  Number of users sign in to their respective Devices
  Ellie signs out from the device

Signin is repeated for ${number} times for ${caller}
  :FOR    ${index}    IN RANGE   5
  \    Multiple sign in

P2P Call is repeated for ${number} for ${caller} to ${callee} using ${callee_name}
  :FOR    ${index}    IN RANGE   5
  \    Multiple P2P Call Outgoing

P2P PhoneNumber Outgoing Call is repeated for ${number} for ${caller} to ${callee} using ${callee_name}
  :FOR    ${index}    IN RANGE   5
  \    Multiple P2P PhoneNumber Outgoing

P2P Call Incoming is repeated for ${number} for ${caller} to ${callee} using ${callee_name}
  :FOR    ${index}    IN RANGE   5
  \    Multiple P2P Call Incoming

P2P PhoneNumber Incoming Call is repeated for ${number} for ${caller} to ${callee} using ${callee_name}
  :FOR    ${index}    IN RANGE   5
  \    Multiple P2P PhoneNumber Incoming

P2P Call PSTN Outgoing is repeated for ${number} for ${caller} to ${callee} using ${callee_name}
  :FOR    ${index}    IN RANGE   5
  \    Multiple P2P Call PSTN Outgoing

P2P Call PSTN Incoming is repeated for ${number} for ${caller} to ${callee} using ${callee_name}
  :FOR    ${index}    IN RANGE   5
  \    Multiple P2P Call PSTN Incoming

single_person_meeting Join is repeated for ${number} times for ${caller}
  :FOR    ${index}    IN RANGE   5
  \    Multiple single_person_meeting

Meetings to calls action is repeated for ${number} times for ${caller}
  :FOR    ${index}    IN RANGE   5
  \    Multiple Meetings to calls Tab

calls to meetings action is repeated for ${number} times for ${caller}
  :FOR    ${index}    IN RANGE   5
  \    Multiple call to Meetings Tab

calls to vm action is repeated for ${number} times for ${caller}
  :FOR    ${index}    IN RANGE   5
  \    Multiple call to VM Tab

vm to meetings action is repeated for ${number} times for ${caller}
  :FOR    ${index}    IN RANGE   5
  \    Multiple vm to meetings Tab

Open Partner Settings is repeated for ${number} times for ${caller}
  :FOR    ${index}    IN RANGE   5
  \    Multiple Open Partner Settings

Meeting items scroll is repeated for ${number} times for ${caller}
  :FOR    ${index}    IN RANGE   5
  \    Multiple Meeting items scroll

Call logs scroll is repeated for ${number} times for ${caller}
  :FOR    ${index}    IN RANGE   5
  \    Multiple Call logs scroll

VM items scroll is repeated for ${number} times for ${caller}
  :FOR    ${index}    IN RANGE   5
  \    Multiple VM items scroll

Add Participant is repeated for ${number} times for ${caller} with ${callee}
  :FOR    ${index}    IN RANGE   5
  \    Multiple Add Participant

Add User is repeated for ${number} times for ${caller} to ${callee} with ${callee1} using ${callee_name}
  :FOR    ${index}    IN RANGE   5
  \    Multiple Add User

Reboot is repeated for ${number} times for ${caller}
  :FOR    ${index}    IN RANGE   1
  \    Multiple Reboot

Shared account Signin is repeated for ${number} times for ${caller}
  :FOR    ${index}    IN RANGE   5
  \    Multiple Shared account Signin


