Scriptname US_AbadonShout_ME_Script extends activemagiceffect  
{Abadon Shout Magic Effect script}

import UnforgivingDevicesMain
UnforgivingDevicesMain Property UDmain auto
UD_libs Property UDlibs auto
UDCustomDeviceMain Property UDCDmain auto
zadlibs Property libs auto
UD_AbadonQuest_script Property AbadonQuest auto

;import US_libs
US_libs Property USlibs auto
;Quest Property USlibsQuest auto

Ingredient Property ASSeed auto

Weapon Property WeaponCane Auto
zbfSlaveActions property zazActions auto
Faction Property HavingSexFaction Auto 
Keyword Property KwZbfYoke auto
Idle Property WhippedIdle auto
Idle Property WhippedRewardIdle auto
Idle Property IdleDef  Auto 

Sound Property dd_sound_moan Auto

GlobalVariable Property AllowCreatureSex auto

int _ASResult = 0
;result of the shout
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

int loc_magn

Event OnEffectStart(Actor akTarget, Actor akCaster)
    loc_magn = UD_Native.iRange(UD_Native.Round(GetMagnitude()),1,3)
    AS_Main(akTarget, akCaster)
    USlibs.ASHook(akTarget, akCaster, loc_magn, _ASResult)
EndEvent

Function AS_Main(Actor akTarget, Actor akCaster)
    ;UDCDmain.Print("Sending event DHLP-Suspend")
    ;SendModEvent("DHLP-Suspend") ; works
    USlibs.DHLPSuspend() ; works!
    ;UDmain.DHLPSuspend() ; works
    ;Utility.Wait(1)
    ;this is enraging... DHLP-Suspend is sent properly, but DHLP-Resume not! Why?!
    Actorbase loc_actorbasetarget = akTarget.GetLeveledActorBase()
    Actorbase loc_actorbasecaster = akCaster.GetLeveledActorBase()
    ;bool CasterHuman = loc_actorbasetarget.IsPlayable()
    bool CasterHuman = UDmain.ActorIsValidForUD(akCaster)
    ;bool TargetHuman = loc_actorbasetarget.IsPlayable()
    bool TargetHuman = UDmain.ActorIsValidForUD(akTarget)
    bool CasterFemale = loc_actorbasecaster.GetSex() == 1
    bool TargetFemale = loc_actorbasetarget.GetSex() == 1
    ;add here draugrs later
    ;UDCDmain.Print("Target is " + loc_TargetIsHuman + "H " + loc_TargetIsFemale + "F")
    bool TargetFree = !akTarget.wornhaskeyword(libs.zad_deviousheavybondage)
    bool CasterFree = !akCaster.wornhaskeyword(libs.zad_deviousheavybondage)
    
    if TargetHuman && TargetFemale && CasterHuman && CasterFemale 
    ;if UDmain.ActorIsValidForUD(akTarget) && loc_actorbasetarget.GetSex() == 1 && UDmain.ActorIsValidForUD(akCaster) && loc_actorbasecaster.GetSex() == 1 
    ; ActorIsValidForUD was failing when checked against guards and bandits, probably because of using GetLeveledActorBase 
    ;both females, check arousal and then call lock restraints on target or caster with check for bondage, bound targets get messed up instead
        if ASReverse(akTarget, akCaster)
            _ASResult = 10
            UDmain.Print(UD_Native.GetActorName(akCaster) + " got too distracted and her shout got reflected back to her!")
            if CasterFree
                ASBindTarget(akCaster,loc_magn)
            else
                UDCDmain.DisableActor(akCaster)
                if !UDCDmain.UDmain.UDRRM.LockAnyRandomRestrain(akCaster, UD_Native.Round(Math.Pow(3, (loc_magn - 1))))
                    _ASResult = 15
                    UDmain.Print(UD_Native.GetActorName(akCaster) + " is all wrapped up in restraints!")
                endif
                UDCDmain.EnableActor(akCaster)
                USlibs.MessUp(akCaster,loc_magn)
            endif
        else
            _ASResult = 4
            if TargetFree
                ASBindTarget(akTarget,loc_magn)
            else
                UDCDmain.DisableActor(akTarget)
                if !UDCDmain.UDmain.UDRRM.LockAnyRandomRestrain(akTarget, UD_Native.Round(Math.Pow(3, (loc_magn - 1))))
                    _ASResult = 5
                    UDmain.Print(UD_Native.GetActorName(akTarget) + " is all wrapped up in restraints!")
                endif
                UDCDmain.EnableActor(akCaster)
                USlibs.MessUp(akTarget,loc_magn)
            endif            
        endif

    elseif TargetHuman && TargetFemale && !CasterHuman && CasterFemale
    ;female creature shouts at human female
    UDmain.Print(UD_Native.GetActorName(akCaster) + " laughs as restraints appear on " + UD_Native.GetActorName(akTarget) + "!")
        _ASResult = 4
        if TargetFree
            ASBindTarget(akTarget,loc_magn)
        else
            UDCDmain.DisableActor(akTarget)
            if !UDCDmain.UDmain.UDRRM.LockAnyRandomRestrain(akTarget, UD_Native.Round(Math.Pow(3, (loc_magn - 1))))
                _ASResult = 5
                UDmain.Print(UD_Native.GetActorName(akTarget) + " is all wrapped up in restraints!")
            endif
            UDCDmain.EnableActor(akCaster)
        endif
        USlibs.MessUp(akTarget,loc_magn)

    elseif !TargetHuman && TargetFemale && CasterHuman && CasterFemale
    ;human female shouts at female creature
        if ASReverse(akTarget, akCaster)    
            _ASResult = 10
            UDmain.Print(UD_Native.GetActorName(akCaster) + " got too distracted and her shout got reflected back to her!")
            if CasterFree
                ASBindTarget(akCaster,loc_magn)
            else
                UDCDmain.DisableActor(akCaster)
                if !UDCDmain.UDmain.UDRRM.LockAnyRandomRestrain(akCaster, UD_Native.Round(Math.Pow(3, (loc_magn - 1))))
                    _ASResult = 15
                    UDmain.Print(UD_Native.GetActorName(akCaster) + " is all wrapped up in restraints!")
                endif
                UDCDmain.EnableActor(akCaster)
                USlibs.MessUp(akCaster,loc_magn)
            endif
        else
            USlibs.MessUp(akTarget,loc_magn)
        endif

    elseif !TargetFemale && CasterHuman && CasterFemale && CasterFree
    ;bind unbound woman caster and start SL scene with non-female target
        USlibs.USCalm(akCaster)
        USlibs.USCalm(akTarget)
        ASBindTarget(akCaster,loc_magn)
        ;Utility.Wait(3) ; replace this with better function to make sure all bondage is done before rape
        ASPerformRapeOrWhip(akTarget,akCaster,loc_magn)
        USlibs.USUnCalm(akCaster)
        USlibs.USUnCalm(akTarget)
    
    elseif !TargetFemale && CasterHuman && CasterFemale && !CasterFree
    ;Mess up or rape bound female caster for shouting at male target after adding restraints to her. What's the best percentage for each outcome?
        USlibs.USCalm(akCaster)
        USlibs.USCalm(akTarget)
        UDCDmain.DisableActor(akCaster)
        UDCDmain.UDmain.UDRRM.LockAnyRandomRestrain(akCaster, UD_Native.Round(Math.Pow(3, (loc_magn - 1))))
        UDCDmain.EnableActor(akCaster)
        if Utility.RandomInt(0,100) < 33
            _ASResult = 1
            USlibs.Messup(akCaster,loc_magn)
        else
            ;Utility.Wait(3) ; replace this with better function to make sure all bondage is done before rape
            ASPerformRapeOrWhip(akTarget,akCaster,loc_magn)
        endif
        USlibs.USUnCalm(akCaster)
        USlibs.USUnCalm(akTarget)
    
    elseif TargetHuman && TargetFemale && !CasterFemale
        ;bind target and start SL scene with non-female caster
        USlibs.USCalm(akCaster)
        USlibs.USCalm(akTarget)
        if TargetFree
            ASBindTarget(akTarget,loc_magn)
        else 
            UDCDmain.DisableActor(akTarget)
            if !UDCDmain.UDmain.UDRRM.LockAnyRandomRestrain(akTarget, UD_Native.Round(Math.Pow(3, (loc_magn - 1))))
                _ASResult = 5
                UDmain.Print(UD_Native.GetActorName(akTarget) + " is all wrapped up in restraints!")
            endif
            UDCDmain.EnableActor(akTarget)
        endif
        ;Utility.Wait(3) ; replace this with better function to make sure all bondage is done before rape
        if !CasterHuman && AllowCreatureSex.GetValueInt() == 0
            USlibs.MessUp(akTarget, loc_magn) ; if it's creature and creature sex disabled - simply add debuffs
        else
            ASPerformRapeOrWhip(akCaster,akTarget,loc_magn)
		endif
        USlibs.USUnCalm(akCaster)
        USlibs.USUnCalm(akTarget)
    else
        USlibs.MessUp(akTarget,loc_magn) ;unsupported target, mess them up, works for male on male too
    endif
	
    ;Utility.Wait(1)
    ;UDCDmain.Print("Sending event DHLP-Resume")
    ;SendModEvent("DHLP-Resume") ; not working, really weird
    USlibs.DHLPResume() ; works!
    ;UDmain.DHLPResume() ; works
    ;Utility.Wait(1)
    ;UDCDmain.Print("Abadon shout event ended.")
EndFunction

;Check arousal of them both and decide if it should be reversed, in which case return true. 
;At 100 arousal difference chance of reverse is 95%, i.e. aroused caster most likely would bind herself instead of completely unaroused target.
;If target's arousal higher than caster's - reversal chance is 5%. Maybe add MCM setting for it later, although sticking with 5% is essentially 1 on 1d20 throw, might be the best.
bool Function ASReverse(Actor loc_target, Actor loc_caster)
    int ReversalChance = UD_Native.Round(UDCDmain.UDmain.UDOM.getArousal(loc_caster) - UDCDmain.UDmain.UDOM.getArousal(loc_target))
    ; Reversal chance is 5-95%
    if ReversalChance < 5 
        if UD_Native.IsPlayer(loc_caster)
            ReversalChance = USlibs.AbadonShoutMinReversal
        else
            ReversalChance = 5
        endif
    endif
    if ReversalChance > 95
        if UD_Native.IsPlayer(loc_target)
            ReversalChance = 100 - USlibs.AbadonShoutMinReversal
        else
            ReversalChance = 95
        endif
    endif
    if Utility.randomInt(0,100) < ReversalChance
        return true
    else
        return false
    endif
EndFunction

;Check for magnitude from 1 to 3 and bind accordingly, 1 - hands only, 2 - hands+gag+blindfold, 3 - full Abadon suit
Function ASBindTarget(Actor TargetToBind, int BindStrength = 1)
    ;UDCDmain.Print("Will bind " + UD_Native.GetActorName(TargetToBind))
    libs.strip(TargetToBind,false)
    if BindStrength == 1 ;bind hands only
        UDCDmain.DisableActor(TargetToBind)
        UDCDmain.UDmain.UDRRM.LockRandomRestrain(TargetToBind,false,0x00000010)
        UDCDmain.EnableActor(TargetToBind)
    elseif BindStrength == 2 ;bind hands plus gag and blindfold
        UDCDmain.DisableActor(TargetToBind)
        UDCDmain.UDmain.UDRRM.LockRandomRestrain(TargetToBind,false,0x00000010)
        UDCDmain.UDmain.UDRRM.LockRandomRestrain(TargetToBind,false,0x00000200)
        UDCDmain.UDmain.UDRRM.LockRandomRestrain(TargetToBind,false,0x00000400)
        UDCDmain.EnableActor(TargetToBind)
    else ;lock random suit or wrap up fully in random restraints (it's a bit longer, so only 25%)
        if Utility.randomInt(0,100) < 75 
            AbadonQuest.AbadonEquipSuit(TargetToBind,0)    
        else
            UDCDmain.DisableActor(TargetToBind)
            UDCDmain.UDmain.UDRRM.LockAllSuitableRestrains(TargetToBind,abForce = false)
            UDCDmain.EnableActor(TargetToBind)
        endif
    endif
EndFunction

; If rapist is not aroused enough - whip victim, else perform rape
Function ASPerformRapeOrWhip(Actor akRapist, Actor akVictim, int magn)
    int RapistArousal = 50
    ;RapistArousal = UDCDmain.UDmain.UDOM.getArousal(akRapist) ; this returns exposure value, not summed arousal
    RapistArousal = libs.Aroused.GetActorArousal(akRapist)
    ;UDCDmain.Print(UD_Native.GetActorName(akRapist) + "s arousal is " + RapistArousal)
    if RapistArousal < 25 && UD_Native.IsPlayer(akVictim)
        USlibs.USWhip(akVictim, akRapist)
        libs.UpdateExposure(akRapist, 30, true)
        libs.UpdateExposure(akVictim, 30, true)
        USlibs.MessUp(akVictim,1)
        USlibs.MasoBuff(akVictim,1)
        _ASResult = 3
    Else
        ASPerformRape(akRapist, akVictim, magn)
        _ASResult = 2
    endif
EndFunction

;Strip belt if present and possible (not quest item), perform rape anim, add Ancient Seed depending on magnitude, apply exhaustion effects and maybe defeated anim
Function ASPerformRape(Actor akRapist, Actor akVictim, int MagnitudePower)
    ;UDCDmain.Print(UD_Native.GetActorName(akRapist) + " will rape " + UD_Native.GetActorName(akVictim))
    Actor[] AS_SLActors = new Actor[2]
    sslBaseAnimation[] AS_SLAnim    
    AS_SLActors[0] = akVictim
    AS_SLActors[1] = akRapist
    int AS_RapeResult = 0
    
    ; calm down both victim and rapist
    akRapist.StopCombatAlarm()
    akRapist.StopCombat()		
    akVictim.StopCombatAlarm()
    akVictim.StopCombat()		

    ;akRapist.SetLookAt(akVictim) ; turn rapist to face victim
    ; adding small delay to ensure all full outfit equips finished, maybe redundant
    ;if MagnitudePower == 3
    ;    Utility.Wait(5)
    ;endif
    ;if akRapist.GetDistance(akVictim) > 250 ; rapist is a bit too far, teleport him to victim
    ;    akRapist.moveto(akVictim)
    ;endif
    ;Utility.Wait(1)
    akRapist.SetLookAt(akVictim) ; turn rapist to face victim
    
    if akVictim.wornhaskeyword(libs.zad_DeviousBelt) ; strip belt
        ;UDCDmain.Print("Attempting to strip the belt")
        Armor loc_belt = libs.getWornDevice(akVictim,libs.zad_DeviousBelt) 
        string loc_belt_name = loc_belt.GetName()
        bool ASBeltIsStripped = false
        if libs.UnlockDevice(akVictim, deviceInventory = loc_belt, zad_DeviousDevice = libs.zad_DeviousBelt, destroydevice = true, genericonly = true)
            ASBeltIsStripped = true
        endif
        Utility.Wait(1) ; giving time to strip
        ; if after stripping belt still some belt detected - it's harness, they are not stripped by belt keywords! DD bug?
        if akVictim.wornhaskeyword(libs.zad_DeviousHarness) && akVictim.wornhaskeyword(libs.zad_DeviousBelt)
            loc_belt = libs.getWornDevice(akVictim,libs.zad_DeviousHarness) 
            if libs.UnlockDevice(akVictim, deviceInventory = loc_belt, zad_DeviousDevice = libs.zad_DeviousHarness, destroydevice = true, genericonly = true)
                ASBeltIsStripped = true
                loc_belt_name = loc_belt.GetName()
            endif
        endif    
        if ASBeltIsStripped
            UDmain.Print("Somehow " + UD_Native.GetActorName(akRapist) + " tears " + loc_belt_name + " to pieces like it's made of paper!")
        endif    
        ;akVictim.removeitem(loc_belt, 1, true) ;strangely despite using destroydevice still somehow inventory item stays... DD bug?
        Armor loc_plug
        string loc_plug_name
        if akVictim.wornhaskeyword(libs.zad_DeviousPlugVaginal)
            loc_plug = libs.getWornDevice(akVictim,libs.zad_DeviousPlugVaginal) 
            if libs.UnlockDevice(akVictim, deviceInventory = loc_plug, zad_DeviousDevice = libs.zad_DeviousPlugVaginal, destroydevice = true, genericonly = true)
                loc_plug_name = loc_plug.GetName()
                UDmain.Print(UD_Native.GetActorName(akRapist) + " pulls out " + loc_plug_name)
            endif
        endif    
        if akVictim.wornhaskeyword(libs.zad_DeviousPlugAnal)
            loc_plug = libs.getWornDevice(akVictim,libs.zad_DeviousPlugAnal) 
            if libs.UnlockDevice(akVictim, deviceInventory = loc_plug, zad_DeviousDevice = libs.zad_DeviousPlugAnal, destroydevice = true, genericonly = true)
                loc_plug_name = loc_plug.GetName()
                UDmain.Print(UD_Native.GetActorName(akRapist) + " pulls out " + loc_plug_name)
            endif
        endif    
    endif

    Utility.Wait(1)
    
    if !akVictim.wornhaskeyword(libs.zad_DeviousBelt)
        AS_SLAnim = libs.SelectValidDDAnimations(AS_SLActors, 2, true, "MF")
	    If AS_SLAnim.Length == 0
    		;UDCDmain.Print("No anims were found for aggressive vaginal by DD")
            ; A bit of randomness for the sake of variety
            if Utility.randomInt(1,2) == 1
                AS_SLAnim = libs.SexLab.GetAnimationsByTag(2, "Aggressive", "MF", RequireAll=true)
            else
                AS_SLAnim = libs.SelectValidDDAnimations(AS_SLActors, 2, false, "MF")
            endif
        EndIf
        AS_RapeResult = 1
    endif
    If AS_SLAnim.Length == 0
        AS_SLAnim = libs.SelectValidDDAnimations(AS_SLActors, 2, true, "Spanking,Spank")
	    If AS_SLAnim.Length == 0
    		;UDCDmain.Print("No anims were found for aggressive spanking by DD")
            ; DD really tries hard to replace anims, so this produces not very predictable results. So lets use random and pray to RNG gods...
            ;if Utility.randomInt(1,2) == 1
            ;    AS_SLAnim = libs.SelectValidDDAnimations(AS_SLActors, 2, false, "Spanking")
    	    ;else
                AS_SLAnim = libs.SexLab.GetAnimationsByTag(2, "Spanking,Spank", RequireAll=false) 
            ;endif
        EndIf
        AS_RapeResult = 2
    endif
    If AS_SLAnim.Length > 0
        ;UDCDmain.Print("Number of anims found is " + AS_SLAnim.Length)
        ;UDCDmain.Print("Starting animation for " + UD_Native.GetActorName(AS_SLActors[1]) + " to rape " + UD_Native.GetActorName(AS_SLActors[0]))
        libs.SexLab.StartSex(Positions = AS_SLActors, Anims = AS_SLAnim, Victim = akVictim)
    elseif UD_Native.IsPlayer(akVictim)
        UDmain.Print(UD_Native.GetActorName(akRapist) + " can't use " + UD_Native.GetActorName(akVictim) + " and gets angry!")
        AS_RapeResult = 3
        ;here add whipping scene if no way to have sex or spank victim
        USlibs.USWhip(akVictim, akRapist)
    EndIf					
    
    while libs.IsAnimating(akVictim)
        Utility.Wait(1)
    endwhile
    
    ;Utility.Wait(3)
    
    ;UDCDmain.Print("Scene result is " + AS_RapeResult)
    if AS_RapeResult == 1
        akVictim.additem(ASSeed, MagnitudePower*2)
        ;light exhaustion and orgasm effects here
        ;USlibs.USKneel(akVictim, MagnitudePower)
        USlibs.MessUp(akVictim, MagnitudePower - 1)
        USlibs.MasoBuff(akVictim, MagnitudePower + 1)
    elseif AS_RapeResult == 2
        akVictim.additem(ASSeed, MagnitudePower)
        ;moderate exhaustion effects here
        ;USlibs.USKneel(akVictim, MagnitudePower * 2)
        USlibs.MessUp(akVictim, MagnitudePower)
        USlibs.MasoBuff(akVictim, MagnitudePower)
    elseif AS_RapeResult == 3
        ;get nothing but severe exhaustion effects
        libs.UpdateExposure(akRapist, 30, true)
        libs.UpdateExposure(akVictim, 30, true)
        ;USlibs.USKneel(akVictim, MagnitudePower * 3)
        USlibs.MessUp(akVictim, MagnitudePower + 1)
        USlibs.MasoBuff(akVictim, MagnitudePower - 1)
    endif
EndFunction
