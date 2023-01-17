Scriptname US_libs extends Quest conditional
{Unforgiving Skyrim extension libraries}

;import UDCustomDeviceMain
import UnforgivingDevicesMain
UnforgivingDevicesMain Property UDmain auto
UDCustomDeviceMain Property UDCDmain auto
zadlibs Property libs auto
;UD_AbadonQuest_script Property AbadonQuest auto
;Quest Property USlibsQuest auto

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
    if !GActorIsPlayer(akActor) 
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
    if !GActorIsPlayer(akActor) 
        akActor.setAV("Aggression", 1)
	    akActor.EvaluatePackage()
    endif
    akActor.StopCombatAlarm()
    akActor.StopCombat()
    ;stopping combat twice, just to be sure
EndFunction

; Play scene of akWhippee being whipped by akWhipper, based on script by vkj, works only on player for now! Maybe rework it later.
Function USWhip(Actor akWhippee, Actor akWhipper)
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

    UDCDmain.DisableActor(akWhippee)
    if GActorIsPlayer(akWhippee)
        Game.SetPlayerAIDriven()
    endif

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
	akWhipper.PlayIdle(IdleDef)

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

    UDCDmain.EnableActor(akWhippee)
    if GActorIsPlayer(akWhippee)
        Game.SetPlayerAIDriven(false)
    endif
EndFunction

; Makes target kneel for KneelTime seconds
Function USKneel(Actor akKneeler, int KneelTime = 3)
    UDCDmain.DisableActor(akKneeler)
    if GActorIsPlayer(akKneeler)
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
    if GActorIsPlayer(akKneeler)
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
    string mes = "Will mess up " + GetActorName(MessedTarget)
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
    string mes = "Will buff " + GetActorName(MasoTarget)
    ;UDCDmain.Print("Will buff up " + GetActorName(MasoTarget))
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