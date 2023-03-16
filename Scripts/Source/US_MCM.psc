Scriptname US_MCM extends SKI_ConfigBase

int Property version auto
bool Property AllowSuitAbadonPlug auto

int AllowSuitAbadonPlugMenu
String _lastPage

Event OnGameReload()
	parent.OnGameReload()
	Return
EndEvent

Event OnVersionUpdate(Int ver)
	OnConfigInit()
	Return
EndEvent

Int Function GetVersion()
	OnConfigInit()
	Return (version) as int
EndFunction

Event OnConfigClose()
	;
endEvent

Event OnConfigInit()
	ModName = "Unforgiving Skyrim"

	Pages = new String[1]
	Pages[0] = "General"

	;Return
EndEvent

Event OnPageReset(string page)
	OnConfigInit()
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)	
	_lastPage = page
	if (page == "")
		LoadCustomContent("UnforgivingSkyrim/MCM.dds", 176, 23)
		return
	else
		UnloadCustomContent()
	endIf

	if (page == "General" || page == "")
		SetTitleText("General")
				
		AddHeaderOption("Suit sets")		
		AllowSuitAbadonPlugMenu = AddToggleOption("Abadon Plug in suits", AllowSuitAbadonPlug)
				
		;AddToggleOption("$dtr_mcm_powers_nippleCum",DTActor.npcs_chastitynipplecum[slot],OPTION_FLAG_DISABLED)
		;AddEmptyOption()   		
		;nullo = AddTextOption("$dtr_mcm_version", DTMain.getDisplayVersion(),OPTION_FLAG_DISABLED)		
	endIf
EndEvent

Event OnOptionSelect(Int Menu)
	if Menu == AllowSuitAbadonPlugMenu
		if  AllowSuitAbadonPlug == true
			AllowSuitAbadonPlug = false
		else			
			AllowSuitAbadonPlug = true	
		endIf
		SetToggleOptionValue(Menu, AllowSuitAbadonPlug)
		ForcePageReset()
		return
	endIf	
endEvent

event OnOptionMenuOpen(int Menu)
;	if (Menu == deviceColorIndex)
;		SetMenuDialogStartIndex(DTConfig.deviceColorIndex as int)
;		SetMenuDialogDefaultIndex(0)
;		SetMenuDialogOptions(deviceType)
;	endIf
endEvent

event OnOptionMenuAccept(int Menu, int a_index)
;	if (Menu == deviceColorIndex)
;		DTConfig.deviceColorIndex = a_index as int
;		SetMenuOptionValue(Menu, deviceType[DTConfig.deviceColorIndex as int])
;	endIf
EndEvent

Event OnOptionHighlight(int option)
    if (_lastPage == "General")
        if(option == AllowSuitAbadonPlugMenu)
			SetInfoText("Allow using of Abadon Plug in suit sets, Execution set always uses it no matter what this set to.")
		endif
    endif
EndEvent