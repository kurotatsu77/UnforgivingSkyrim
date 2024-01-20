Scriptname US_libs extends Quest conditional
{Unforgiving Skyrim extension libraries}

;import UDCustomDeviceMain
import UnforgivingDevicesMain

;UnforgivingDevicesMain Property UDmain auto
UnforgivingDevicesMain  _udmain
Quest                   _udquest ;kept for possible future optimization
UnforgivingDevicesMain Property UDmain hidden ;main function
    UnforgivingDevicesMain Function get()
        if !_udmain
            _udquest = Game.getFormFromFile(0x00005901,"UnforgivingDevices.esp") as Quest
            _udmain = _udquest as UnforgivingDevicesMain
        endif
        return _udmain
    EndFunction
    Function set(UnforgivingDevicesMain akForm)
        _udmain = akForm
    EndFunction
EndProperty

;UDCustomDeviceMain Property UDCDmain auto
UD_libs Property UDlibs Hidden;device/keyword library
    UD_libs Function get()
        return UDmain.UDlibs
    EndFunction
EndProperty
UDCustomDeviceMain _udcdmain
UDCustomDeviceMain Property UDCDmain Hidden
    UDCustomDeviceMain Function get()
        if !_udcdmain
            _udcdmain = UDmain.UDCDmain
        endif
        return _udcdmain
    EndFunction
EndProperty

zadlibs Property libs auto
;UD_AbadonQuest_script Property AbadonQuest auto
;Quest Property USlibsQuest auto

Armor Property AbadonBoxbinder auto
Armor Property AbadonBoxbinderOutfit auto
Armor Property AbadonHeavyBlindfold auto
Armor Property AbadonHeavyGag auto
Armor Property AbadonHeavyCollar auto
Armor Property AbadonSlaveHarness auto
Armor Property AbadonStraitJacketCatsuit auto

;Bound Cunt items
Armor Property BoundCuntBoxbinder auto
Armor Property BoundCuntCorset auto
Armor Property BoundCuntBoots auto
Armor Property BoundCuntBlindfold auto
Armor Property BoundCuntFaceMask auto
Armor Property BoundCuntHood auto
Armor Property BoundCuntCollar auto

Weapon Property WeaponCane Auto
zbfSlaveActions property zazActions auto
Faction Property HavingSexFaction Auto 
Keyword Property KwZbfYoke auto
Idle Property WhippedIdle auto
Idle Property WhippedRewardIdle auto
Idle Property IdleDef  Auto 

Sound Property dd_sound_moan Auto

Spell Property ASExhaustion1 auto
Spell Property ASExhaustion2 auto
Spell Property ASExhaustion3 auto
Spell Property ASMasoBuff1 auto
Spell Property ASMasoBuff2 auto
Spell Property ASMasoBuff3 auto

Quest Property MQ104 Auto
Quest Property ASQuest Auto
Shout Property AbadonShout Auto
WordOfPower Property AbadonShoutWord1 Auto
WordOfPower Property AbadonShoutWord2 Auto
WordOfPower Property AbadonShoutWord3 Auto
Message Property US_ASQ_MSG_1_1 Auto
Message Property US_ASQ_MSG_1_2 Auto
Message Property US_ASQ_MSG_2_1 Auto
Message Property US_ASQ_MSG_2_2 Auto
Message Property US_ASQ_MSG_3_1 Auto
Message Property US_ASQ_MSG_3_2 Auto
Message Property US_AS_MSG_Reversal_1 Auto
Message Property US_AS_MSG_Reversal_2 Auto

int AbadonShoutUnderstanding = 0
int Property AbadonShoutMinReversal = 5 Auto

Event OnInit()
    UDmain.CLog("US_libs got Init event.")
    RegisterForSingleUpdate(2.0)
EndEvent

Event OnUpdate()
    UDmain.CLog("US_libs got Update event.")
    OnGameReload()
EndEvent

Function OnGameReload()
    UDmain.CLog("US_libs got onGameReload call event.")
    RegisterForModEvent("DHLP-Suspend", "USEventDetect")
    RegisterForModEvent("DHLP-Resume", "USEventDetect")
EndFunction

Event USEventDetect(string eventName, string strArg, float numArg, Form sender)
    UDmain.CLog("Event " + eventName + " with arguments " + strArg + " detected.")
    ;UDCDmain.Print("Event " + eventName + " with arguments " + strArg + " detected.")
EndEvent

; Sends event DHLP-Suspend
Function DHLPSuspend() 
    SendModEvent("DHLP-Suspend")
    if UDmain.TraceAllowed()
        UDmain.Log("Sending event DHLP-Suspend")
    endif
    UDmain.CLog("Sending event DHLP-Suspend")
    ;UDCDmain.Print("Sending event DHLP-Suspend")    
EndFunction

; Sends event DHLP-Resume
Function DHLPResume() 
    SendModEvent("DHLP-Resume")
    if UDmain.TraceAllowed()
        UDmain.Log("Sending event DHLP-Resume")
    endif
    UDmain.CLog("Sending event DHLP-Resume")
    ;UDCDmain.Print("Sending event DHLP-Resume")
EndFunction

; Calms actor and place them into HavingSexFaction
Function USCalm(Actor akActor)
    akActor.StopCombatAlarm()
    akActor.StopCombat()		
    akActor.AddToFaction(HavingSexFaction)
    if !UD_Native.IsPlayer(akActor) 
        akActor.setAV("Aggression", 0)
	    akActor.EvaluatePackage()
    endif
    akActor.StopCombatAlarm()
    akActor.StopCombat()
    ;stopping combat twice, just to be sure
EndFunction

; Calms actor and removes them from HavingSexFaction. Stopping combat seems like a good measure
Function USUnCalm(Actor akActor)
    akActor.StopCombatAlarm()
    akActor.StopCombat()		
    akActor.RemoveFromFaction(HavingSexFaction)
    if !UD_Native.IsPlayer(akActor) 
        akActor.setAV("Aggression", 1)
	    akActor.EvaluatePackage()
    endif
    akActor.StopCombatAlarm()
    akActor.StopCombat()
    ;stopping combat twice, just to be sure
EndFunction

; Play scene of akWhippee being whipped by akWhipper, based on script by vkj, works only on player for now! Maybe rework it later.
Function USWhip(Actor akWhippee, Actor akWhipper, Scene akNextScene = None)
    Int loc_isPlayer = UD_Native.IsPlayer(akWhippee) as Int
    Float whippingDuration = 10
    whippingDuration = Utility.RandomInt(10,30)
    String caneModel = WeaponCane.GetModelPath()
	;WeaponCane.SetModelPath("some path here")
	float caneSpeed = WeaponCane.GetSpeed()
	float WhipSpeed = 100
    WeaponCane.SetSpeed(caneSpeed * WhipSpeed / 100.0)
	int caneDamage = WeaponCane.GetBaseDamage()
	WeaponCane.SetBaseDamage(1)
	WeaponCane.SetCritDamage(0); Being cautious; it should be zero anyway.
    float zazDialogType = zazActions.zbfSlaveDialogueType.GetValue()
	zazActions.zbfSlaveDialogueType.SetValue(-1); suppress whipping dialog
    
    UDCDmain.DisableActor(akWhippee, loc_isPlayer)

    akWhippee.AddToFaction(HavingSexFaction)
	akWhipper.AddToFaction(HavingSexFaction)
    
    if !akWhippee.WornHasKeyword(libs.zad_DeviousHeavyBondage)
		akWhippee.PlayIdle(WhippedRewardIdle)
	else
		if akWhippee.WornHasKeyword(libs.zad_DeviousYoke) || akWhippee.WornHasKeyword(KwZbfYoke); Alternate kneel for in a yoke
            Debug.SendAnimationEvent(akWhippee, "ZapYokePose06")
        elseif akWhippee.WornHasKeyword(libs.zad_DeviousHeavyBondage); Alternate kneel for when hands are bound
            Debug.SendAnimationEvent(akWhippee, "ZapArmbPose06")
        elseif !akWhippee.WornHasKeyword(libs.zad_DeviousYokeBB); Breast Yoke has no kneeling animation for now
            akWhippee.PlayIdle(WhippedIdle)
        endif
	endif

	float angleZ = akWhippee.GetAngleZ()
    akWhipper.MoveTo(akWhippee, 80.0 * Math.Sin(angleZ), 80.0 * Math.Cos(angleZ), 0.0, false)
;	akWhipper.PlayIdle(IdleDef)

    ;unequip spells
    Spell aSpell = akWhipper.GetEquippedSpell(0)
	if aSpell != none
		akWhipper.UnequipSpell(aSpell, 0)
	endif
	aSpell = akWhipper.GetEquippedSpell(1)
	if aSpell != none
		akWhipper.UnequipSpell(aSpell, 1)
	endif
	
	; Ensure that player health is at least a minimal level, so whipping doesn't end too quickly
    float health = akWhippee.GetActorValue("Health")
	if health < 70.0
		akWhippee.RestoreActorValue("Health", (70.0 - health))
	endif
	
	Scene zazScene = zazActions.WhipScene
    
    ActorBase PlayerBase = akWhippee.GetBaseObject() as ActorBase
	bool wasEssential = akWhippee.IsEssential()
	PlayerBase.SetEssential(true)
	zazActions.WhipPlayer(akWhipper, afMinHealth=20.0)
	Utility.Wait(4)
	zazActions.SetWhipTimeOut(whippingDuration)
    
    While zazActions.WhipScene.IsPlaying()
        If Utility.RandomInt() < 50
		    dd_sound_moan.Play(akWhippee)
	    EndIf    
        Utility.Wait(0.5)
    endwhile

    PlayerBase.SetEssential(wasEssential)
	zazActions.WhipScene = zazScene

    akWhipper.UnequipItem(WeaponCane)
	akWhipper.RemoveItem(WeaponCane, 1)
	WeaponCane.SetModelPath(caneModel)
	WeaponCane.SetSpeed(caneSpeed)
	WeaponCane.SetBaseDamage(caneDamage)
	zazActions.zbfSlaveDialogueType.SetValue(zazDialogType)
    
    ;akWhippee.PlayIdle(IdleDef)
	akWhippee.RemoveFromFaction(HavingSexFaction)
	akWhipper.RemoveFromFaction(HavingSexFaction)
    
    UDCDmain.EnableActor(akWhippee, loc_isPlayer)
    Debug.SendAnimationEvent(akWhippee, "IdleForceDefaultState")
    
    If akNextScene != None
        akNextScene.ForceStart()
    Else
;        UDCDmain.EnableActor(akWhippee, loc_isPlayer)
    EndIf
EndFunction

; Makes target kneel for KneelTime seconds
Function USKneel(Actor akKneeler, int KneelTime = 3)
    UDCDmain.DisableActor(akKneeler)
    if UD_Native.IsPlayer(akKneeler)
        Game.SetPlayerAIDriven()
    endif

    If akKneeler.WornHasKeyword(libs.zad_DeviousHeavyBondage)
		If akKneeler.WornHasKeyword(libs.zad_DeviousArmbinder)
			Debug.SendAnimationEvent(akKneeler, "ft_bleedout_transin_armbinder")
		ElseIf akKneeler.WornHasKeyword(libs.zad_DeviousYoke)
			Debug.SendAnimationEvent(akKneeler, "ft_bleedout_transin_yoke")
		ElseIf akKneeler.WornHasKeyword(libs.zad_DeviousYokeBB)
			Debug.SendAnimationEvent(akKneeler, "ft_bleedout_transin_bbyoke")
		ElseIf akKneeler.WornHasKeyword(libs.zad_DeviousArmbinderElbow)
			Debug.SendAnimationEvent(akKneeler, "ft_bleedout_transin_elbowbinder")
		ElseIf akKneeler.WornHasKeyword(libs.zad_DeviousCuffsFront)
			Debug.SendAnimationEvent(akKneeler, "ft_bleedout_transin_frontcuffs")
		EndIf
	Else
		Debug.SendAnimationEvent(akKneeler, "BleedOutStart")
	EndIf
    
    ;akKneeler.PlayIdle(WhippedRewardIdle) ; until i figure out why SendAnimationEvent doesn't works...
    Utility.Wait(KneelTime)

    UDCDmain.EnableActor(akKneeler)
    if UD_Native.IsPlayer(akKneeler)
        Game.SetPlayerAIDriven(false)
    endif

    Debug.SendAnimationEvent(akKneeler, "BleedoutStop")
    Debug.SendAnimationEvent(akKneeler, "IdleForceDefaultState")
    Debug.SendAnimationEvent(akKneeler, "IdleStop_Loose")
    akKneeler.PlayIdle(IdleDef)
    ;akKneeler.PlayIdle(IdleStop_Loose)
EndFunction

;Do nasty things to the target, maybe stagger, add weakness to magic, drain stamina and magicka?
Function MessUp(Actor MessedTarget, int MessMagnitude)
    ;USlibs.USKneel(MessedTarget, 10)
    string mes = "Will mess up " + UD_Native.GetActorName(MessedTarget)
    if MessMagnitude < 2
        ASExhaustion1.Cast(MessedTarget,MessedTarget)
        mes = mes + " at power 1"
    elseif MessMagnitude == 2
        ASExhaustion2.Cast(MessedTarget,MessedTarget)
        mes = mes + " at power 2"
    else
        ASExhaustion3.Cast(MessedTarget,MessedTarget)
        mes = mes + " at power 3"
    endif
    ;UDCDmain.Print(mes)
EndFunction

;Reward masochist with buffs
Function MasoBuff(Actor MasoTarget, int BuffMagnitude)
    string mes = "Will buff " + UD_Native.GetActorName(MasoTarget)
    ;UDCDmain.Print("Will buff up " + UD_Native.GetActorName(MasoTarget))
    ;USlibs.USKneel(MasoTarget, 10)
    if BuffMagnitude < 2
        ASMasoBuff1.Cast(MasoTarget,MasoTarget)
        mes = mes + " at power 1"
    elseif BuffMagnitude == 2
        ASMasoBuff2.Cast(MasoTarget,MasoTarget)
        mes = mes + " at power 2"
    else
        ASMasoBuff3.Cast(MasoTarget,MasoTarget)
        mes = mes + " at power 3"
    endif
    ;UDCDmain.Print(mes)
EndFunction

Function ASHook(Actor akTarget, Actor akCaster, int aiMagnitude, int aiResult)
;aiResult is result of the shout
;0 - default result, target got simply messed up
;1 - caster messed up
;2 - got raped
;3 - got whipped
;4 - target bound
;5 - target got all bound
;6 - caster got bound
;7 - caster got all bound
;10 - shout got reversed
;15 - shout got reversed and caster got all bound

    if !MQ104.IsCompleted() && !ASQuest.IsRunning() && !ASQuest.IsCompleted() ;starting the Abadon Shout learning quest at pre-MQ014 stage, depending on who got hit 
        if akTarget == Game.GetPlayer()
            ASQuest.Start()
            ASQuest.SetStage(50)
            ASQuest.SetObjectiveDisplayed(50)
        else
            ASQuest.Start()
            ASQuest.SetStage(51)
            ASQuest.SetObjectiveDisplayed(50)
        endif
    elseif MQ104.IsCompleted() && !ASQuest.IsRunning() && !ASQuest.IsCompleted() ;starting the Abadon Shout learning quest if it not running and not complete yet
        ;UDCDmain.Print("Starting Abadon Shout Quest")
        ASQuest.Start()
        ASQuest.SetStage(100)
        ASQuest.SetObjectiveDisplayed(100)
    elseif ASQuest.IsRunning() && !ASQuest.IsCompleted()
        int ASQStage = ASQuest.GetCurrentStageID()
        int loc_random = Utility.RandomInt(1,100)
        int loc_choice
        if  (ASQStage == 50 || ASQStage == 51) && MQ104.IsCompleted() ; catching event of finishing MQ104 is a bit tricky, so we just wait to witness another use of Abadon Shout 
            ASQuest.SetObjectiveCompleted(50)
            ASQuest.SetStage(100)
            ASQuest.SetObjectiveDisplayed(100)
        elseif  ASQStage == 100 && akTarget == Game.GetPlayer(); Learning first Abadon Shout word
            if loc_random < 50
                loc_choice = US_ASQ_MSG_1_1.Show()
            else
                loc_choice = US_ASQ_MSG_1_2.Show()
            endif
            if loc_choice == 0
                AbadonShoutUnderstanding -= 20
            elseif loc_choice == 1
                AbadonShoutUnderstanding += 10
            else
                AbadonShoutUnderstanding += 30
            endif
            if AbadonShoutUnderstanding < 0
                AbadonShoutUnderstanding = 0
            elseif AbadonShoutUnderstanding > 99
                AbadonShoutUnderstanding = 0
                debug.messagebox("Now you finally have full understanding, it makes perfect sense for Master to bind woman's hands before using her, bound sex is great!")
                Game.GetPlayer().AddShout(AbadonShout)
                Game.TeachWord(AbadonShoutWord1)
                Game.UnlockWord(AbadonShoutWord1)
                ASQuest.SetObjectiveCompleted(100)
                ASQuest.SetStage(200)
                ASQuest.SetObjectiveDisplayed(200)
            endif
        elseif  ASQStage == 200 ; Learning second Abadon Shout word
            if akTarget == Game.GetPlayer() && aiMagnitude > 1
                if loc_random < 50
                    loc_choice = US_ASQ_MSG_2_1.Show()
                else
                    loc_choice = US_ASQ_MSG_2_2.Show()
                endif
                if loc_choice == 0
                    AbadonShoutUnderstanding -= 10
                elseif loc_choice == 1
                    AbadonShoutUnderstanding += 10
                else
                    AbadonShoutUnderstanding += 20
                endif
            elseif akTarget == Game.GetPlayer() && aiMagnitude == 1
                UDmain.Print("This Shout was too weak to learn anything from it")
            elseif akCaster == Game.GetPlayer()
                if aiResult == 10
                    AbadonShoutUnderstanding += 10
                    UDmain.Print("You reflect on the reflected Shout, it works!")
                elseif aiResult == 15
                    AbadonShoutUnderstanding += 20
                    UDmain.Print("You reflect on the reflected Shout, tight bondage helps tremendously!")
                else
                    AbadonShoutUnderstanding += 5
                    UDmain.Print("Your understanding of the Abadon Shout increases slightly")
                endif
            endif
            if AbadonShoutUnderstanding < 0
                AbadonShoutUnderstanding = 0
            elseif AbadonShoutUnderstanding > 99
                AbadonShoutUnderstanding = 0
                debug.messagebox("Second Word understanding is now clear to you - only through true helplessness of being bound, gagged and blindfolded woman can achieve a true masochist's delight.")
                Game.TeachWord(AbadonShoutWord2)
                Game.UnlockWord(AbadonShoutWord2)
                ASQuest.SetObjectiveCompleted(200)
                ASQuest.SetStage(300)
                ASQuest.SetObjectiveDisplayed(300)
            endif
        elseif  ASQStage == 300 ; Learning third Abadon Shout word
            if akTarget == Game.GetPlayer() && aiMagnitude > 2
                if loc_random < 50
                    loc_choice = US_ASQ_MSG_3_1.Show()
                else
                    loc_choice = US_ASQ_MSG_3_2.Show()
                endif
                if loc_choice == 0
                    AbadonShoutUnderstanding -= 5
                elseif loc_choice == 1
                    AbadonShoutUnderstanding += 5
                elseif loc_choice == 2
                    AbadonShoutUnderstanding += 10
                else
                    AbadonShoutUnderstanding += 20
                endif
            elseif akTarget == Game.GetPlayer() && aiMagnitude < 3
                UDmain.Print("This Shout was too weak to learn anything from it")
            elseif akCaster == Game.GetPlayer() && aiMagnitude == 2
                if aiResult == 10
                    AbadonShoutUnderstanding += 10
                    UDmain.Print("You reflect on the reflected Shout, it works!")
                elseif aiResult == 15
                    AbadonShoutUnderstanding += 20
                    UDmain.Print("You reflect on the reflected Shout, tight bondage helps tremendously!")
                else
                    AbadonShoutUnderstanding += 5
                    UDmain.Print("Your understanding of the Abadon Shout increases slightly")
                endif
            elseif akCaster == Game.GetPlayer() && aiMagnitude == 1
                UDmain.Print("This Shout was too weak to learn anything from it")
            endif
            if AbadonShoutUnderstanding < 0
                AbadonShoutUnderstanding = 0
            elseif AbadonShoutUnderstanding > 99
                AbadonShoutUnderstanding = 0
                debug.messagebox("It's very obvious now to you. Women are slaves to Master's whims, to be wrapped in restraints and used. Master does not needs permission from slave meat. Being reduced to bound playtoy without any rights feels wonderful!")
                Game.TeachWord(AbadonShoutWord3)
                Game.UnlockWord(AbadonShoutWord3)
                ASQuest.SetObjectiveCompleted(300)
                ASQuest.SetStage(1000)
                ASQuest.CompleteQuest()
                ;ASQuest.Stop() ;  no need for this, better allow it to remain in the completed quests
            endif
        endif
    else
        if akCaster == Game.GetPlayer()
            if aiResult > 9
                int loc_random = Utility.RandomInt(1,100)
                int loc_choice
                if loc_random < 50
                    loc_choice = US_AS_MSG_Reversal_1.Show()
                else
                    loc_choice = US_AS_MSG_Reversal_2.Show()
                endif
                if loc_choice == 0
                    AbadonShoutMinReversal = AbadonShoutMinReversal - (5 * UD_Native.Round((aiResult/5) - 1) * aiMagnitude) ; -5 ... -30
                elseif loc_choice == 1
                    ;AbadonShoutMinReversal = AbadonShoutMinReversal + (5 * UD_Native.Round((aiResult/5) - 1) * aiMagnitude) ; no change
                else
                    AbadonShoutMinReversal = AbadonShoutMinReversal + (5 * UD_Native.Round((aiResult/5) - 1) * aiMagnitude)  ; +5 ... +30
                endif
                if AbadonShoutMinReversal < 5
                    AbadonShoutMinReversal = 5
                endif
                if AbadonShoutMinReversal > 95
                    AbadonShoutMinReversal = 95
                endif
                UDmain.Print("You feel like you will be bound with at least " + AbadonShoutMinReversal + "% probability.")
            endif
        endif
    endif
EndFunction