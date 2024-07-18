*** Settings ***
Library  AppiumLibrary  run_on_failure=Log Source
Library  OperatingSystem


*** Variables ***
${REMOTE_URL}  http://127.0.0.1:4723/wd/hub
${Teams_Package}  com.microsoft.skype.teams.ipphone
${Ping_Ellie}  Ping  10.50.10.105
${Ping_Leo}  Ping  10.50.10.167
${adb_devices_check}  adb devices
${CompanyPortal_Package}  com.microsoft.windowsintune.companyportal
${activity}  com.microsoft.skype.teams.Launcher
${version}  5.1.1
${appium_start}  appium
${Buffer_Stream}  cat /dev/null > C:\\stream\\appium.txt
${Buffer_Stream1}  cat /dev/null > C:\\stream\\appiumerr.txt
${display name}  plcm41
${users_csv_path}  C:\\Sakurai_Robot\\Data\\users.csv
${users_json_path}  C:\\Sakurai_Robot\\Data\\config.json
${properties_json_path}  C:\\Sakurai_Robot\\Data\\t-est.json
${Ellie}  Ellie
${Leo}  Leo
${Elizabeth}  Elizabeth
${Mark}  Mark
