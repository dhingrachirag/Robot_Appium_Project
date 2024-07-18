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
ADB Logcat Command
  [Arguments]  ${device_udid}
  Create File  C:\\Users\\I6350\\file.txt
  ${marf1}  Start Process  adb -s ${device_udid} logcat >C:\\Users\\I6350\\file.txt  shell=${True}
  Log  ${marf1}


ADB Logcat
  ${the file as string}=    Get File    ${users_json_path}
  ${parsed}=    Evaluate  json.loads("""${the file as string}""", object_pairs_hook=collections.OrderedDict)     json, collections
  ${properties}=  Set Variable  ${parsed["users"]}
  Log  ${properties}
  :FOR    ${key}    IN    @{properties}
  \  Run Keyword If  '${key}' == '${Elizabeth}'  Exit For Loop
  \  ${sub dict}=    Get From Dictionary    ${properties}    ${key}
  \  Log  ${sub dict}
  \  ADB Logcat Command   ${sub dict}[ip]
  \  Log  ${key} is successfully signed in.

ADB Clear Logcat logs
  ${the file as string}=    Get File    ${users_json_path}
  ${parsed}=    Evaluate  json.loads("""${the file as string}""", object_pairs_hook=collections.OrderedDict)     json, collections
  ${properties}=  Set Variable  ${parsed["users"]}
  Log  ${properties}
  :FOR    ${key}    IN    @{properties}
  \  Run Keyword If  '${key}' == '${Elizabeth}'  Exit For Loop
  \  ${sub dict}=    Get From Dictionary    ${properties}    ${key}
  \  Log  ${sub dict}
  \  ADB Logcat Clear   ${sub dict}[ip]
  \  Log  ${key} is successfully signed in.

ADB Logcat Clear
  [Arguments]  ${device_udid}
  ${marf2}  Run And Return Rc And Output  adb -s ${device_udid} logcat -c >File.txt
  Log  ${marf2}

User started the operation
  ADB Logcat

Clear the logs
  ADB Clear Logcat logs

Read txt file
  [Arguments]
  ${TextFileContent}=    Get File    C:\\Users\\I6350\\file.txt
  Log    ${TextFileContent}
  should contain  ${TextFileContent}  com.microsoft.skype.teams.ipphone.APP_INCALL_STATE (1:Talking)

User check for the intent
  Read txt file


