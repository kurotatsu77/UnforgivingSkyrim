Scriptname US_MCM extends SKI_ConfigBase

int Property version auto
bool Property AllowSuitAbadonPlug auto
int Property UragBaseReward = 500 Auto

US_UragGRQ_Script Property UragGRQ Auto

bool WeaponsRegistered
int AllowSuitAbadonPlug_T
String _lastPage
int WeaponsRegistered_T
int UragBaseReward_S

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
		AllowSuitAbadonPlug_T = AddToggleOption("Abadon Plug in suits", AllowSuitAbadonPlug)
		
		AddHeaderOption("Urag's research")
		UragBaseReward_S = AddSliderOption("Base Reward:", UragBaseReward, "{0} x")
		
		AddHeaderOption("Abadon weapons")
		;If WeaponsRegistered
		;	WeaponsRegistered_T = AddTextOption("", "Registered", OPTION_FLAG_DISABLED)
		;elseif !UragGRQ.IsRunning()
		;	WeaponsRegistered_T = AddTextOption("", "Can't register", OPTION_FLAG_DISABLED)
		;Else
			WeaponsRegistered_T = AddTextOption("Register Abadon Weapons", "REGISTER")
		;EndIf
		;AddToggleOption("$dtr_mcm_powers_nippleCum",DTActor.npcs_chastitynipplecum[slot],OPTION_FLAG_DISABLED)
		;AddEmptyOption()   		
		;nullo = AddTextOption("$dtr_mcm_version", DTMain.getDisplayVersion(),OPTION_FLAG_DISABLED)		
	endIf
EndEvent

Event OnOptionSelect(Int Menu)
	if Menu == AllowSuitAbadonPlug_T
		if  AllowSuitAbadonPlug == true
			AllowSuitAbadonPlug = false
		else			
			AllowSuitAbadonPlug = true	
		endIf
		SetToggleOptionValue(Menu, AllowSuitAbadonPlug)
		ForcePageReset()
		return
	elseif Menu == WeaponsRegistered_T
		if  WeaponsRegistered == true
			;WeaponsRegistered = false
		else			
			WeaponsRegistered = true
			;register here
			UragGRQ.AddAbadonWeaponsToLL()
		endIf
		ForcePageReset()
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

event OnOptionSliderOpen(int Menu)
	if Menu == UragBaseReward_S
		SetSliderDialogStartValue(UragBaseReward)
        SetSliderDialogDefaultValue(500.0)
        SetSliderDialogRange(1.0, 10000.0)
        SetSliderDialogInterval(1)    
	endIf	
endEvent

event OnOptionSliderAccept(int Menu, float value)
    if (Menu == UragBaseReward_S)
        UragBaseReward = Round(value)
		;if UragGRQ.IsRunning()
			UragGRQ.BaseReward = UragBaseReward
		;endif
        SetSliderOptionValue(UragBaseReward_S, UragBaseReward, "{1}")
	endif
endEvent

Event OnOptionHighlight(int option)
    if (_lastPage == "General")
        if(option == AllowSuitAbadonPlug_T)
			SetInfoText("Allow using of Abadon Plug in suit sets, Execution set always uses it no matter what this set to.")
		elseif(option == WeaponsRegistered_T)
			SetInfoText("Injects Abadon Weapons into leveled lists to be available to use by NPCs. Normally done via Urag's quest and not needed to be used.")
		elseif(option == UragBaseReward_S)
			SetInfoText("Sets base reward size for Urag. All rewards for various researches are multiplied by this value. Default: 500.")
		endif
    endif
EndEvent

int Function Round(float value) global
    return Math.floor(value + 0.5)
EndFunction