:: Description: Small Bat program to switch Git profiles
:: Created by: Layne Hutchings
:: Created on: 03/30/2023
:: Version: v1.0

@ECHO off
SETlocal enabledelayedexpansion

:: SET the path to .gitConfig
SET pathToConfig=C:\Path\to\.gitconfig

:: Set names here
SET names[0]=YourNameHere
SET emails[0]=YourEmailHere
@REM SET names[1]=YourNameHere
@REM SET emails[1]=YourEmailHere

:: Length of the names array
SET /A len=1

:: To iterate the element of array
:lengthLoop 

:: It will check if the element is defined or not
IF defined names[%len%] ( 
    SET /A "len+=1"
    GOTO :lengthLoop 
)

:: Removes extra count from loop
SET /A "len-=1" 

:: Start of main loop
:loopStart

:: Prompt for input
ECHO Enter the number for the profile you would like to switch to:

:: Loops over and prints the avaiable names
FOR /l %%n in (0,1,%len%) do ( 
   ECHO %%n.^) !names[%%n]!
)

:: Main input 
SET /p choice=">> "

:: Choice validation variable
SET choiceIsValid=true

:: Checking if the input was valid
IF %choice% LSS 0 SET choiceIsValid=false
IF %choice% GTR %len% SET choiceIsValid=false
IF %choice% EQU e EXIT /b 0

:: Checks if the users choice is in range/valid
:: NOTE! Please look at what the contents of your gitconfig file are
:: You may have to include it here as this will rewrite the whole file.
IF "%choiceIsValid%" == "true" (
   
    ECHO [user]>>%pathToConfig%
    ECHO 	name = !names[%choice%]!>>%pathToConfig%
    ECHO 	email = !emails[%choice%]!>>%pathToConfig%

    ECHO You have changed to !names[%choice%]!.
)ELSE (
    ECHO Out of range, choose from 0 to %len%.
    ECHO ------------------
    GOTO :loopStart
)

:: END