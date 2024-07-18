*** Settings ***
Library  ../Customlibs/csv.py





*** Keywords ***
Get Csv Data
  [Arguments]  ${filepath}
  ${Data} =  Read Csv  ${filepath}
  [Return]  ${Data}










