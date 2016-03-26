#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%

hModule := DllCall("LoadLibrary", "Str", "LogitechLed.dll", "Ptr")	; Must load library on memory
DllCall("LogitechLed\LogiLedInit")
Sleep,200	; Needs some initialization time according to Docs
DllCall("LogitechLed\LogiLedSaveCurrentLighting")	; Don't destroy current set up
DllCall("LogitechLed\LogiLedSetLighting","Int",0,"Int",0,"Int",0)  ;Turn off keys

Loop,10
{
	DllCall("LogitechLed\LogiLedSetLightingForKeyWithScanCode","Int",0x01d+A_Index,"Int",0,"Int",100,"Int",0)
	Sleep,100
	DllCall("LogitechLed\LogiLedSetLightingForKeyWithScanCode","Int",0x01d+A_Index,"Int",0,"Int",30,"Int",0)
}

DllCall("LogitechLed\LogiLedRestoreLighting")

DllCall("FreeLibrary", "Ptr", hModule) 
