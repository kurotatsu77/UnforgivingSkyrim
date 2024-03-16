Scriptname US_MCM extends SKI_ConfigBase

int Property version auto
bool Property AllowSuitAbadonPlug auto
int Property UragBaseReward = 500 Auto

int Property WeightBlackGoo		= 100 	auto
int Property WeightConcGoo		= 50 	auto
int Property WeightPureGoo 		= 50 	auto
int Property WeightCursedGoo 	= 20 	auto
int Property WeightExecutionGoo = 10 	auto
int Property WeightPlug 		= 30 	auto
int Property WeightShout 		= 50 	auto
int Property WeightBoundCunt 	= 40 	auto

US_UragGRQ_Script Property UragGRQ Auto

GlobalVariable Property AllowCreaturesPoison auto
GlobalVariable Property AllowAbadonShout auto
GlobalVariable Property AllowCreatureSex auto
GlobalVariable Property EventsSuspended auto

bool WeaponsRegistered
int AllowSuitAbadonPlug_T
int AllowCreaturesPoison_T
int AllowAbadonShout_T
int AllowCreatureSex_T
String _lastPage
int WeaponsRegistered_T
int ModVersion_T
int EventsSuspended_T
int SuspendEvents_T
int ResumeEvents_T

int UragBaseReward_S
int UragWeight1_S
int UragWeight2_S
int UragWeight3_S
int UragWeight4_S
int UragWeight5_S
int UragWeight6_S
int UragWeight7_S
int UragWeight8_S

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

	Pages = new String[3]
	Pages[0] = "General"
	Pages[1] = "Urag's Research"
	Pages[2] = "Debug"

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
				
		AddHeaderOption("Creatures poisoning")
		AllowCreaturesPoison_T = AddToggleOption("Creatures poison binds", CreaturesAllowed())

		AddHeaderOption("Abadon Shout")
		AllowAbadonShout_T = AddToggleOption("Allow Abadon Shout", ASAllowed())
		AllowCreatureSex_T = AddToggleOption("Allow creature sex", CreatureSexAllowed())
		
		;AddToggleOption("$dtr_mcm_powers_nippleCum",DTActor.npcs_chastitynipplecum[slot],OPTION_FLAG_DISABLED)
		;AddEmptyOption()   		
		;nullo = AddTextOption("$dtr_mcm_version", DTMain.getDisplayVersion(),OPTION_FLAG_DISABLED)		

	elseif (page == "Urag's Research")
		
		SetTitleText("Urag's Research")
		
		AddHeaderOption("Base reward")
		UragBaseReward_S = AddSliderOption("Base Reward:", UragBaseReward, "{0} gold")
		;AddEmptyOption()   		
		AddHeaderOption("Tests weights")
		UragWeight1_S = AddSliderOption("Black Goo:", WeightBlackGoo, "{0}")
		UragWeight2_S = AddSliderOption("Concentrated Black Goo:", WeightConcGoo, "{0}")
		UragWeight3_S = AddSliderOption("Purified Goo:", WeightPureGoo, "{0}")
		UragWeight4_S = AddSliderOption("Cursed Goo:", WeightCursedGoo, "{0}")
		UragWeight5_S = AddSliderOption("Execution Goo:", WeightExecutionGoo, "{0}")
		UragWeight6_S = AddSliderOption("Abadon Plug:", WeightPlug, "{0}")
		UragWeight7_S = AddSliderOption("Abadon Shout:", WeightShout, "{0}")
		UragWeight8_S = AddSliderOption("Bound Cunt:", WeightBoundCunt, "{0}")

	elseif (page == "Debug")
        ModVersion_T = AddTextOption("Mod version ", ModVersion(), OPTION_FLAG_DISABLED)	

		AddHeaderOption("Mod Events")
        If bEventsSuspended()
            EventsSuspended_T = AddTextOption("Mod events ", "Suspended", OPTION_FLAG_DISABLED)
        else
            EventsSuspended_T = AddTextOption("Mod events ", "Allowed", OPTION_FLAG_DISABLED)
        endif
        SuspendEvents_T = AddTextOption("Send DHLP-Suspend modevent", "SUSPEND")
        ResumeEvents_T = AddTextOption("Send DHLP-Resume modevent", "RESUME")

		AddHeaderOption("Abadon weapons")
		If WeaponsRegistered
			WeaponsRegistered_T = AddTextOption("", "Registered", OPTION_FLAG_DISABLED)
		elseif !UragGRQ.IsRunning()
			WeaponsRegistered_T = AddTextOption("", "Can't register", OPTION_FLAG_DISABLED)
		Else
			WeaponsRegistered_T = AddTextOption("Register Abadon Weapons", "REGISTER")
		EndIf


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

	elseif Menu == AllowCreaturesPoison_T
		if CreaturesAllowed()
			AllowCreaturesPoison.SetValueInt(0)
		else
			AllowCreaturesPoison.SetValueInt(1)
		endif
		SetToggleOptionValue(Menu, CreaturesAllowed())
		ForcePageReset()

	elseif Menu == AllowAbadonShout_T
		if ASAllowed()
			AllowAbadonShout.SetValueInt(0)
		else
			AllowAbadonShout.SetValueInt(1)
		endif
		SetToggleOptionValue(Menu, ASAllowed())
		ForcePageReset()

	elseif Menu == AllowCreatureSex_T
		if CreatureSexAllowed()
			AllowCreatureSex.SetValueInt(0)
		else
			AllowCreatureSex.SetValueInt(1)
		endif
		SetToggleOptionValue(Menu, CreatureSexAllowed())
		ForcePageReset()

	elseif Menu == WeaponsRegistered_T
		if  WeaponsRegistered == true
			;WeaponsRegistered = false
		else			
			WeaponsRegistered = true
			;register here
			UragGRQ.AddAbadonWeaponsToLL()
		endIf
		ForcePageReset()

	elseif Menu == SuspendEvents_T
        SendModEvent("DHLP-Suspend")
        Debug.Messagebox("Sending DHLP-Suspend modevent.")
		ForcePageReset()

	elseif Menu == ResumeEvents_T
        SendModEvent("DHLP-Resume")
        Debug.Messagebox("Sending DHLP-Resume modevent.")
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
	elseif Menu == UragWeight1_S
		SetSliderDialogStartValue(WeightBlackGoo)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)    
	elseif Menu == UragWeight2_S
		SetSliderDialogStartValue(WeightConcGoo)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)    
	elseif Menu == UragWeight3_S
		SetSliderDialogStartValue(WeightPureGoo)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)    
	elseif Menu == UragWeight4_S
		SetSliderDialogStartValue(WeightCursedGoo)
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)    
	elseif Menu == UragWeight5_S
		SetSliderDialogStartValue(WeightExecutionGoo)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)    
	elseif Menu == UragWeight6_S
		SetSliderDialogStartValue(WeightPlug)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)    
	elseif Menu == UragWeight7_S
		SetSliderDialogStartValue(WeightShout)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)    
	elseif Menu == UragWeight8_S
		SetSliderDialogStartValue(WeightBoundCunt)
		SetSliderDialogDefaultValue(40.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)    
	endIf	
endEvent

event OnOptionSliderAccept(int Menu, float value)
    if (Menu == UragBaseReward_S)
        UragBaseReward = UD_Native.Round(value)
		;if UragGRQ.IsRunning()
			UragGRQ.BaseReward = UragBaseReward
		;endif
        SetSliderOptionValue(UragBaseReward_S, UragBaseReward, "{0}")
	elseif (Menu == UragWeight1_S)
		WeightBlackGoo = UD_Native.Round(value)
		UragGRQ.WeightBlackGoo = WeightBlackGoo
		SetSliderOptionValue(UragWeight1_S, WeightBlackGoo, "{0}")
	elseif (Menu == UragWeight2_S)
		WeightConcGoo = UD_Native.Round(value)
		UragGRQ.WeightConcGoo = WeightConcGoo
		SetSliderOptionValue(UragWeight2_S, WeightConcGoo, "{0}")
	elseif (Menu == UragWeight3_S)
		WeightPureGoo = UD_Native.Round(value)
		UragGRQ.WeightPureGoo = WeightPureGoo
		SetSliderOptionValue(UragWeight3_S, WeightPureGoo, "{0}")
	elseif (Menu == UragWeight4_S)
		WeightCursedGoo = UD_Native.Round(value)
		UragGRQ.WeightCursedGoo = WeightCursedGoo
		SetSliderOptionValue(UragWeight4_S, WeightCursedGoo, "{0}")
	elseif (Menu == UragWeight5_S)
		WeightExecutionGoo = UD_Native.Round(value)
		UragGRQ.WeightExecutionGoo = WeightExecutionGoo
		SetSliderOptionValue(UragWeight5_S, WeightExecutionGoo, "{0}")
	elseif (Menu == UragWeight6_S)
		WeightPlug = UD_Native.Round(value)
		UragGRQ.WeightPlug = WeightPlug
		SetSliderOptionValue(UragWeight6_S, WeightPlug, "{0}")
	elseif (Menu == UragWeight7_S)
		WeightShout = UD_Native.Round(value)
		UragGRQ.WeightShout = WeightShout
		SetSliderOptionValue(UragWeight7_S, WeightShout, "{0}")
	elseif (Menu == UragWeight8_S)
		WeightBoundCunt = UD_Native.Round(value)
		UragGRQ.WeightBoundCunt = WeightBoundCunt
		SetSliderOptionValue(UragWeight8_S, WeightBoundCunt, "{0}")
	endif
endEvent

Event OnOptionHighlight(int option)
    if (_lastPage == "General")
        if(option == AllowSuitAbadonPlug_T)
			SetInfoText("Allow using of Abadon Plug in suit sets, Execution set always uses it no matter what this set to.")
		elseif(option == AllowCreaturesPoison_T)
			SetInfoText("Allow poison of falmers, chaurus and spiders to apply binding effect with small probability (3-12%).")
		elseif(option == AllowAbadonShout_T)
			SetInfoText("Allow Abadon Shout for NPCs. Warning: you need to be hit by the shout with this enabled to learn it.")
		elseif(option == AllowCreatureSex_T)
			SetInfoText("Allows creature sex, for example by male draugrs when they shout at human females.")
		endif
	elseif (_lastPage == "Urag's Research")
		if(option == UragBaseReward_S)
			SetInfoText("Sets base reward size for Urag. All rewards for various researches are multiplied by this value. Default: 500.")
		elseif(option == UragWeight1_S || UragWeight2_S || UragWeight3_S || UragWeight4_S || UragWeight5_S || UragWeight6_S || UragWeight7_S || UragWeight8_S)
			SetInfoText("Weight of particular test being chosen, set to 0 to block it from appearing.")
		endif
	elseif (_lastpage == "Debug")
        if (option == ModVersion_T)
            SetInfoText("This mod's current version.")
		elseif(option == EventsSuspended_T)
			SetInfoText("DHLP-Suspend status. When suspend flag is set - no mod initiated events will occur. Player initiated events will occur normally.")
		elseif(option == SuspendEvents_T)
			SetInfoText("Sends DHLP-Suspend event, thus suspending actions of all compatible mods, including this one.")
		elseif(option == ResumeEvents_T)
			SetInfoText("Sends DHLP-Resume event, thus resuming actions of all compatible mods, including this one.")
		elseif(option == WeaponsRegistered_T)
			SetInfoText("Injects Abadon Weapons into leveled lists to be available to use by NPCs. Normally done via Urag's quest and not needed to be used.")
        endif
    endif
EndEvent

bool Function CreaturesAllowed()
	if AllowCreaturesPoison.GetValueInt() == 0
		return false
	else
		return true
	endif
EndFunction

bool Function ASAllowed()
	if AllowAbadonShout.GetValueInt() == 0
		return false
	else
		return true
	endif
EndFunction

bool Function CreatureSexAllowed()
	if AllowCreatureSex.GetValueInt() == 0
		return false
	else
		return true
	endif
EndFunction

bool Function bEventsSuspended()
	if EventsSuspended.GetValueInt() == 0
		return false
	else
		return true
	endif
EndFunction

string Function ModVersion()
    string _locVersion = ""
	int _locVersion1 = UD_Native.Round(version/100)
	int _locVersion2 = UD_Native.Round((version - (_locVersion1*100))/10)
	int _locVersion3 = UD_Native.Round(version - (_locVersion1*100) - (_locVersion2*10))
	_locVersion = _locVersion1 + "." + _locVersion2 + "." + _locVersion3
    return _locVersion
EndFunction