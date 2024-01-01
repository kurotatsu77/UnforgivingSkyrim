Scriptname US_GRQ_Enchanting_Quest_script extends Quest  

;import UnforgivingDevicesMain
;UD_libs Property UDlibs auto
;UnforgivingDevicesMain Property UDmain auto
US_libs Property USlibs auto

US_GooResearch_Script Property GRQ auto

MiscObject Property Gold  Auto

Function LockBoundCuntCollar(Actor akActor)
    Actor loc_Player = Game.GetPlayer()
    if loc_Player.wornhaskeyword(USlibs.UDmain.libs.zad_DeviousCollar) 
        UnlockCollar(akActor)
    endif
    USlibs.UDmain.libs.LockDevice(loc_Player,USlibs.BoundCuntCollar)
EndFunction

Function LockBoundCuntBoxbinder(Actor akActor)
    Actor loc_Player = Game.GetPlayer()
    if loc_Player.wornhaskeyword(USlibs.UDmain.libs.zad_DeviousSuit) 
        RemoveRestraint(akActor, USlibs.UDmain.libs.zad_DeviousSuit)
    endif

    if loc_Player.wornhaskeyword(USlibs.UDmain.libs.zad_DeviousHeavyBondage) 
        RemoveRestraint(akActor, USlibs.UDmain.libs.zad_DeviousHeavyBondage)
    endif
    USlibs.UDmain.libs.LockDevice(loc_Player,USlibs.BoundCuntBoxbinder)
EndFunction

Function LockBoundCuntOutfit(Actor akActor)
    Actor loc_Player = Game.GetPlayer()

;boxbinder
    if loc_Player.wornhaskeyword(USlibs.UDmain.libs.zad_DeviousSuit) 
        RemoveRestraint(akActor, USlibs.UDmain.libs.zad_DeviousSuit)
    endif

    if loc_Player.wornhaskeyword(USlibs.UDmain.libs.zad_DeviousHeavyBondage) 
        RemoveRestraint(akActor, USlibs.UDmain.libs.zad_DeviousHeavyBondage)
    endif
    USlibs.UDmain.libs.LockDevice(loc_Player,USlibs.BoundCuntBoxbinder)

;corset
    if loc_Player.wornhaskeyword(USlibs.UDmain.libs.zad_DeviousCorset) 
        RemoveRestraint(akActor, USlibs.UDmain.libs.zad_DeviousCorset, USlibs.UDmain.libs.zad_DeviousHarness)
    endif
    USlibs.UDmain.libs.LockDevice(loc_Player,USlibs.BoundCuntCorset)

;hood and blindfold
    if loc_Player.wornhaskeyword(USlibs.UDmain.libs.zad_DeviousHood) 
        RemoveRestraint(akActor, USlibs.UDmain.libs.zad_DeviousHood)
    endif
    if loc_Player.wornhaskeyword(USlibs.UDmain.libs.zad_DeviousGag) 
        RemoveRestraint(akActor, USlibs.UDmain.libs.zad_DeviousGag)
    endif
    if loc_Player.wornhaskeyword(USlibs.UDmain.libs.zad_DeviousBlindfold) 
        RemoveRestraint(akActor, USlibs.UDmain.libs.zad_DeviousBlindfold)
    endif
    USlibs.UDmain.libs.LockDevice(loc_Player,USlibs.BoundCuntHood)
    USlibs.UDmain.libs.LockDevice(loc_Player,USlibs.BoundCuntBlindfold)

;boots
    if loc_Player.wornhaskeyword(USlibs.UDmain.libs.zad_DeviousBoots) 
        RemoveRestraint(akActor, USlibs.UDmain.libs.zad_DeviousBoots)
    endif
    USlibs.UDmain.libs.LockDevice(loc_Player,USlibs.BoundCuntBoots)
EndFunction

bool Function UnlockCollar(Actor akActor)
    Actor loc_Player = Game.GetPlayer()
    if loc_Player.wornhaskeyword(USlibs.UDmain.libs.zad_DeviousCollar) ; strip collar
        RemoveRestraint(akActor, USlibs.UDmain.libs.zad_DeviousCollar, USlibs.UDmain.libs.zad_DeviousHarness)
    endif

    if !loc_Player.wornhaskeyword(USlibs.UDmain.libs.zad_DeviousCollar)
        return true
    else
        return false
    endif
EndFunction

;returns true when no more belt and plugs worn
bool Function UnlockBeltPlugs(Actor akActor)
    Actor loc_Player = Game.GetPlayer()
    
    RemoveRestraint(akActor, USlibs.UDmain.libs.zad_DeviousBelt, USlibs.UDmain.libs.zad_DeviousHarness)
    
    if loc_Player.wornhaskeyword(USlibs.UDmain.libs.zad_DeviousPlugVaginal)
        if !RemoveRestraint(akActor, USlibs.UDmain.libs.zad_DeviousPlugVaginal)
            USlibs.UDmain.Print(USlibs.GetActorName(akActor) + " fails to pull out vaginal plug")
        endif
    endif
    if loc_Player.wornhaskeyword(USlibs.UDmain.libs.zad_DeviousPlugAnal)
        if !RemoveRestraint(akActor, USlibs.UDmain.libs.zad_DeviousPlugAnal)
            USlibs.UDmain.Print(USlibs.GetActorName(akActor) + " fails to pull out anal plug")
        endif
    endif
    if !loc_Player.wornhaskeyword(USlibs.UDmain.libs.zad_DeviousBelt) && !loc_Player.wornhaskeyword(USlibs.UDmain.libs.zad_DeviousPlugVaginal) && !loc_Player.wornhaskeyword(USlibs.UDmain.libs.zad_DeviousPlugAnal)
        return true
    else
        return false
    endif
EndFunction

bool Function RemoveRestraint(Actor akRemover, keyword kwFirst, keyword kwSecond = none)
    Actor loc_player = Game.GetPlayer()
    if loc_player.wornhaskeyword(kwFirst) 
        Armor loc_restraint = USlibs.UDmain.libs.getWornDevice(loc_player, kwFirst) 
        string loc_restraint_name = loc_restraint.GetName()
        bool loc_IsStripped = false
        if USlibs.UDmain.libs.UnlockDevice(loc_player, deviceInventory = loc_restraint, zad_DeviousDevice = kwFirst, destroydevice = false, genericonly = true)
            loc_IsStripped = true
        endif
        Utility.Wait(1) ; giving time to strip
        if !(kwSecond == none) && loc_player.wornhaskeyword(kwFirst) && loc_player.wornhaskeyword(kwSecond)
            loc_restraint = USlibs.UDmain.libs.getWornDevice(loc_player, kwSecond) 
            if USlibs.UDmain.libs.UnlockDevice(loc_player, deviceInventory = loc_restraint, zad_DeviousDevice = kwSecond, destroydevice = false, genericonly = true)
                loc_IsStripped = true
                loc_restraint_name = loc_restraint.GetName()
            endif
        endif    
        if loc_IsStripped
            USlibs.UDmain.Print(USlibs.GetActorName(akRemover) + " removes " + loc_restraint_name)
        endif
        return loc_IsStripped
    endif
EndFunction

Function StartSex(Actor akActor)
    USlibs.DHLPSuspend()
    Actor[] US_SLActors = new Actor[2]
    sslBaseAnimation[] US_SLAnim    
    US_SLActors[0] = Game.GetPlayer()
    US_SLActors[1] = akActor
    
    US_SLAnim = USlibs.UDmain.libs.SelectValidDDAnimations(US_SLActors, 2, true, "MF")
    If US_SLAnim.Length == 0
        ;UDCDmain.Print("No anims were found for aggressive vaginal by DD")
        ; A bit of randomness for the sake of variety
        if Utility.randomInt(1,2) == 1
            US_SLAnim = USlibs.UDmain.libs.SexLab.GetAnimationsByTag(2, "Aggressive", "MF", RequireAll=true)
        else
            US_SLAnim = USlibs.UDmain.libs.SelectValidDDAnimations(US_SLActors, 2, true, "MF")
        endif
    EndIf
    
    If US_SLAnim.Length > 0
        ;UDCDmain.Print("Number of anims found is " + AS_SLAnim.Length)
        ;UDCDmain.Print("Starting animation for " + GetActorName(AS_SLActors[1]) + " to rape " + GetActorName(AS_SLActors[0]))
        USlibs.UDmain.libs.SexLab.StartSex(Positions = US_SLActors, Anims = US_SLAnim, Victim = US_SLActors[0])
    endif
    USlibs.DHLPResume()
EndFunction

Function LockRandomGag(Actor akActor)
    Actor loc_Player = Game.GetPlayer()
    Armor loc_restraint = USlibs.UDCDmain.UDmain.UDRRM.LockRandomRestrain(loc_Player,false,0x00000200)
    if loc_restraint
        string loc_restraint_name = loc_restraint.GetName()
        USlibs.UDmain.Print(USlibs.GetActorName(akActor) + " locks " + loc_restraint_name + " on " + USlibs.GetActorName(loc_Player))
    endif
EndFunction

Function LockRandomArmRestraint(Actor akActor)
    Actor loc_Player = Game.GetPlayer()
    Armor loc_restraint = USlibs.UDCDmain.UDmain.UDRRM.LockRandomRestrain(loc_Player,false,0x00000010)
    if loc_restraint
        string loc_restraint_name = loc_restraint.GetName()
        USlibs.UDmain.Print(USlibs.GetActorName(akActor) + " locks " + loc_restraint_name + " on " + USlibs.GetActorName(loc_Player))
    endif
EndFunction