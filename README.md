# Robot_Appium_Project

OS REQUIREMENTS: Windows 10 / Windows Server 2012 r2 64 bit architecture

NOTE:

• Wherever command prompt is used, please run it as administrator.

SOFTWARES TO INSTALL:

JRE/JDK Java SE Development Kit 8u181 http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html (64bit)

After installing, make sure the jdk bin is set in PATH in EnvironmentVariables. C:\Program Files\Java\jdk1.8.0_181 C:\Program Files\Java\jdk1.8.0_181\bin

image
If everything is set, then from command prompt, you should be able to see the version of installed jdk without any errors. Eg.,

java -version java version "1.8.0_181" Java(TM) SE Runtime Environment (build 1.8.0_181-b13) Java HotSpot(TM) 64-Bit Server VM (build 25.181-b13, mixed mode) 

Android studio 2.3.3 (pre-req: JRE/JDK) https://developer.android.com/studio/archive.html (64 bit, select bundle with sdk)

SDK is very important. Make sure you see the following after install. Open file explorer, %localappdata%/Android/Sdk/platform-tools/. You should see adb.exe (Fig. below)

image
If you don’t see this, Restart your computer, try installing android studio again and make sure as you install, you see sdk components selected.

image
Python 3.9.12 https://www.python.org/ftp/python/3.9.12/python-3.9.12.amd64.msi
As you install, make sure you select option "Add Python.exe to PATH" as “Will be installed on local hard drive”
 

Install node.js (>10.1.0) (pre-req: jre/jdk) For windows 64 bit : https://nodejs.org/dist/v10.8.0/node-v10.8.0-x64.msi
image
As you install, make sure all components are selected (ie., there is no cross mark × against any of the modules). It should be like below image

Let it install in the default location. After installation, open command prompt, type:

node –v
