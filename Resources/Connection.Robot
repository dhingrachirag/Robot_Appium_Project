*** Settings ***
Library  AppiumLibrary  run_on_failure=Log Source
Library  OperatingSystem
Resource  ../Variables/globalvariables.robot


*** Variables ***


*** Keywords ***
Initiating the connection of the users
  [Documentation]  This Method is use to establish connection for any user.Kindly look arguments and establish connection accordingly.
  [Arguments]  ${udid}
  Log Variables
  ${out}  Open Application
    ...  ${REMOTE_URL}
    ...  alias=Myapp1
    ...  platformName=android
    ...  appActivity=${activity}
    ...  noReset=True
    ...  fullReset=False
    ...  platformVersion=${version}
    ...  deviceName=Android
    ...  udid=${udid}
    ...  automationName=appium
    ...  appPackage=${Teams_Package}
    ...  app=C:\\Microsoft-Teams-2018121201.apk
    ...  log-level error=debug
    ...  Log=C:\\Development\\Robot_Scripts\\Sakurai\\results\\appium.log
    ...  newCommandTimeout=90000
    ...  autoLaunch=true
    Log  ${out}
    Reset Application

