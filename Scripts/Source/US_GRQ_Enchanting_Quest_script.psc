Scriptname US_GRQ_Enchanting_Quest_script extends Quest  

import UnforgivingDevicesMain
;UD_libs Property UDlibs auto
UnforgivingDevicesMain Property UDmain auto
US_libs Property USlibs auto

Function LockBoundCuntCollar(Actor akActor)
    Actor US_Player = Game.GetPlayer()
    if US_Player.wornhaskeyword(UDmain.libs.zad_DeviousCollar) 
        UnlockCollar(akActor)
    endif
    UDmain.libs.LockDevice(US_Player,USlibs.BoundCuntCollar)
EndFunction

Function LockBoundCuntOutfit(Actor akActor)
    Actor US_Player = Game.GetPlayer()
;collar should be locked separately
;    if US_Player.wornhaskeyword(UDmain.libs.zad_DeviousCollar) 
;        UnlockCollar(akActor)
;    endif
;    UDmain.libs.LockDevice(US_Player,USlibs.BoundCuntCollar)
;boxbinder
    if US_Player.wornhaskeyword(UDmain.libs.zad_DeviousSuit) 
        Armor loc_suit = UDmain.libs.getWornDevice(US_Player,UDmain.libs.zad_DeviousSuit) 
        string loc_suit_name = loc_suit.GetName()
        bool loc_IsStripped = false
        if UDmain.libs.UnlockDevice(US_Player, deviceInventory = loc_suit, zad_DeviousDevice = UDmain.libs.zad_DeviousSuit, destroydevice = true, genericonly = true)
            loc_IsStripped = true
        endif
        Utility.Wait(1) ; giving time to strip
        if loc_IsStripped
            UDmain.Print(GetActorName(akActor) + " unlocks " + loc_suit_name + " with their key")
        endif
    endif
    if US_Player.wornhaskeyword(UDmain.libs.zad_DeviousHeavyBondage) 
        Armor loc_suit = UDmain.libs.getWornDevice(US_Player,UDmain.libs.zad_DeviousHeavyBondage) 
        string loc_suit_name = loc_suit.GetName()
        bool loc_IsStripped = false
        if UDmain.libs.UnlockDevice(US_Player, deviceInventory = loc_suit, zad_DeviousDevice = UDmain.libs.zad_DeviousHeavyBondage, destroydevice = true, genericonly = true)
            loc_IsStripped = true
        endif
        Utility.Wait(1) ; giving time to strip
        if loc_IsStripped
            UDmain.Print(GetActorName(akActor) + " unlocks " + loc_suit_name + " with their key")
        endif
    endif
    UDmain.libs.LockDevice(US_Player,USlibs.BoundCuntBoxbinder)
;corset
    if US_Player.wornhaskeyword(UDmain.libs.zad_DeviousCorset) 
        Armor loc_suit = UDmain.libs.getWornDevice(US_Player,UDmain.libs.zad_DeviousCorset) 
        string loc_suit_name = loc_suit.GetName()
        bool loc_IsStripped = false
        if UDmain.libs.UnlockDevice(US_Player, deviceInventory = loc_suit, zad_DeviousDevice = UDmain.libs.zad_DeviousCorset, destroydevice = true, genericonly = true)
            loc_IsStripped = true
        endif
        Utility.Wait(1) ; giving time to strip
        if loc_IsStripped
            UDmain.Print(GetActorName(akActor) + " unlocks " + loc_suit_name + " with their key")
        endif
    endif
    if US_Player.wornhaskeyword(UDmain.libs.zad_DeviousHarness) 
        Armor loc_suit = UDmain.libs.getWornDevice(US_Player,UDmain.libs.zad_DeviousHarness) 
        string loc_suit_name = loc_suit.GetName()
        bool loc_IsStripped = false
        if UDmain.libs.UnlockDevice(US_Player, deviceInventory = loc_suit, zad_DeviousDevice = UDmain.libs.zad_DeviousHarness, destroydevice = true, genericonly = true)
            loc_IsStripped = true
        endif
        Utility.Wait(1) ; giving time to strip
        if loc_IsStripped
            UDmain.Print(GetActorName(akActor) + " unlocks " + loc_suit_name + " with their key")
        endif
    endif
    UDmain.libs.LockDevice(US_Player,USlibs.BoundCuntCorset)
;hood and blindfold
    if US_Player.wornhaskeyword(UDmain.libs.zad_DeviousHood) 
        Armor loc_suit = UDmain.libs.getWornDevice(US_Player,UDmain.libs.zad_DeviousHood) 
        string loc_suit_name = loc_suit.GetName()
        bool loc_IsStripped = false
        if UDmain.libs.UnlockDevice(US_Player, deviceInventory = loc_suit, zad_DeviousDevice = UDmain.libs.zad_DeviousHood, destroydevice = true, genericonly = true)
            loc_IsStripped = true
        endif
        Utility.Wait(1) ; giving time to strip
        if loc_IsStripped
            UDmain.Print(GetActorName(akActor) + " unlocks " + loc_suit_name + " with their key")
        endif
    endif
    if US_Player.wornhaskeyword(UDmain.libs.zad_DeviousGag) 
        Armor loc_suit = UDmain.libs.getWornDevice(US_Player,UDmain.libs.zad_DeviousGag) 
        string loc_suit_name = loc_suit.GetName()
        bool loc_IsStripped = false
        if UDmain.libs.UnlockDevice(US_Player, deviceInventory = loc_suit, zad_DeviousDevice = UDmain.libs.zad_DeviousGag, destroydevice = true, genericonly = true)
            loc_IsStripped = true
        endif
        Utility.Wait(1) ; giving time to strip
        if loc_IsStripped
            UDmain.Print(GetActorName(akActor) + " unlocks " + loc_suit_name + " with their key")
        endif
    endif
    if US_Player.wornhaskeyword(UDmain.libs.zad_DeviousBlindfold) 
        Armor loc_suit = UDmain.libs.getWornDevice(US_Player,UDmain.libs.zad_DeviousBlindfold) 
        string loc_suit_name = loc_suit.GetName()
        bool loc_IsStripped = false
        if UDmain.libs.UnlockDevice(US_Player, deviceInventory = loc_suit, zad_DeviousDevice = UDmain.libs.zad_DeviousBlindfold, destroydevice = true, genericonly = true)
            loc_IsStripped = true
        endif
        Utility.Wait(1) ; giving time to strip
        if loc_IsStripped
            UDmain.Print(GetActorName(akActor) + " unlocks " + loc_suit_name + " with their key")
        endif
    endif
    UDmain.libs.LockDevice(US_Player,USlibs.BoundCuntHood)
    UDmain.libs.LockDevice(US_Player,USlibs.BoundCuntBlindfold)
;boots
    if US_Player.wornhaskeyword(UDmain.libs.zad_DeviousBoots) 
        Armor loc_suit = UDmain.libs.getWornDevice(US_Player,UDmain.libs.zad_DeviousBoots) 
        string loc_suit_name = loc_suit.GetName()
        bool loc_IsStripped = false
        if UDmain.libs.UnlockDevice(US_Player, deviceInventory = loc_suit, zad_DeviousDevice = UDmain.libs.zad_DeviousBoots, destroydevice = true, genericonly = true)
            loc_IsStripped = true
        endif
        Utility.Wait(1) ; giving time to strip
        if loc_IsStripped
            UDmain.Print(GetActorName(akActor) + " unlocks " + loc_suit_name + " with their key")
        endif
    endif
    UDmain.libs.LockDevice(US_Player,USlibs.BoundCuntBoots)
EndFunction

bool Function UnlockCollar(Actor akActor)
    Actor US_Player = Game.GetPlayer()
    if US_Player.wornhaskeyword(UDmain.libs.zad_DeviousCollar) ; strip collar
        ;UDCDmain.Print("Attempting to strip the belt")
        Armor loc_collar = UDmain.libs.getWornDevice(US_Player,UDmain.libs.zad_DeviousCollar) 
        string loc_collar_name = loc_collar.GetName()
        bool USCollarIsStripped = false
        if UDmain.libs.UnlockDevice(US_Player, deviceInventory = loc_collar, zad_DeviousDevice = UDmain.libs.zad_DeviousCollar, destroydevice = true, genericonly = true)
            USCollarIsStripped = true
        endif
        Utility.Wait(1) ; giving time to strip
        ; if after stripping collar still some collar detected - it's harness, they are not stripped by collar keywords! DD bug?
        if US_Player.wornhaskeyword(UDmain.libs.zad_DeviousHarness) && US_Player.wornhaskeyword(UDmain.libs.zad_DeviousCollar)
            loc_collar = UDmain.libs.getWornDevice(US_Player,UDmain.libs.zad_DeviousHarness) 
            if UDmain.libs.UnlockDevice(US_Player, deviceInventory = loc_collar, zad_DeviousDevice = UDmain.libs.zad_DeviousHarness, destroydevice = true, genericonly = true)
                USCollarIsStripped = true
                loc_collar_name = loc_collar.GetName()
            endif
        endif    
        if USCollarIsStripped
            UDmain.Print(GetActorName(akActor) + " unlocks " + loc_collar_name + " with their key")
        endif
    endif

    if !US_Player.wornhaskeyword(UDmain.libs.zad_DeviousCollar)
        return true
    else
        return false
    endif
EndFunction

;returns true when no more belt and plugs worn
bool Function UnlockBeltPlugs(Actor akActor)
    Actor US_Player = Game.GetPlayer()
    if US_Player.wornhaskeyword(UDmain.libs.zad_DeviousBelt) ; strip belt
        ;UDCDmain.Print("Attempting to strip the belt")
        Armor loc_belt = UDmain.libs.getWornDevice(US_Player,UDmain.libs.zad_DeviousBelt) 
        string loc_belt_name = loc_belt.GetName()
        bool USBeltIsStripped = false
        if UDmain.libs.UnlockDevice(US_Player, deviceInventory = loc_belt, zad_DeviousDevice = UDmain.libs.zad_DeviousBelt, destroydevice = true, genericonly = true)
            USBeltIsStripped = true
        endif
        Utility.Wait(1) ; giving time to strip
        ; if after stripping belt still some belt detected - it's harness, they are not stripped by belt keywords! DD bug?
        if US_Player.wornhaskeyword(UDmain.libs.zad_DeviousHarness) && US_Player.wornhaskeyword(UDmain.libs.zad_DeviousBelt)
            loc_belt = UDmain.libs.getWornDevice(US_Player,UDmain.libs.zad_DeviousHarness) 
            if UDmain.libs.UnlockDevice(US_Player, deviceInventory = loc_belt, zad_DeviousDevice = UDmain.libs.zad_DeviousHarness, destroydevice = true, genericonly = true)
                USBeltIsStripped = true
                loc_belt_name = loc_belt.GetName()
            endif
        endif    
        if USBeltIsStripped
            UDmain.Print(GetActorName(akActor) + " unlocks " + loc_belt_name + " with their key")
        endif    
    endif

    if US_Player.wornhaskeyword(UDmain.libs.zad_DeviousPlugVaginal) ; strip vaginal plug
        Armor loc_plug = UDmain.libs.getWornDevice(US_Player,UDmain.libs.zad_DeviousPlugVaginal) 
        string loc_plug_name = loc_plug.GetName()
        bool USPlugIsStripped = false
        if UDmain.libs.UnlockDevice(US_Player, deviceInventory = loc_plug, zad_DeviousDevice = UDmain.libs.zad_DeviousPlugVaginal, destroydevice = true, genericonly = true)
            USPlugIsStripped = true
        endif
        Utility.Wait(1) ; giving time to strip
        if USPlugIsStripped
            UDmain.Print(GetActorName(akActor) + " unlocks " + loc_plug_name + " with their key")
        else
            UDmain.Print(GetActorName(akActor) + " fails to pull out " + loc_plug_name)
        endif    
    endif

    if US_Player.wornhaskeyword(UDmain.libs.zad_DeviousPlugAnal) ; strip anal plug
        Armor loc_plug = UDmain.libs.getWornDevice(US_Player,UDmain.libs.zad_DeviousPlugAnal) 
        string loc_plug_name = loc_plug.GetName()
        bool USPlugIsStripped = false
        if UDmain.libs.UnlockDevice(US_Player, deviceInventory = loc_plug, zad_DeviousDevice = UDmain.libs.zad_DeviousPlugAnal, destroydevice = true, genericonly = true)
            USPlugIsStripped = true
        endif
        Utility.Wait(1) ; giving time to strip
        if USPlugIsStripped
            UDmain.Print(GetActorName(akActor) + " unlocks " + loc_plug_name + " with their key")
        else
            UDmain.Print(GetActorName(akActor) + " fails to pull out " + loc_plug_name)
        endif    
    endif

    if !US_Player.wornhaskeyword(UDmain.libs.zad_DeviousBelt) && !US_Player.wornhaskeyword(UDmain.libs.zad_DeviousPlugVaginal) && !US_Player.wornhaskeyword(UDmain.libs.zad_DeviousPlugAnal)
        return true
    else
        return false
    endif
EndFunction

Function StartSex(Actor akActor)
    USlibs.DHLPSuspend()
    Actor[] US_SLActors = new Actor[2]
    sslBaseAnimation[] US_SLAnim    
    US_SLActors[0] = Game.GetPlayer()
    US_SLActors[1] = akActor
    
    US_SLAnim = UDmain.libs.SelectValidDDAnimations(US_SLActors, 2, true, "MF")
    If US_SLAnim.Length == 0
        ;UDCDmain.Print("No anims were found for aggressive vaginal by DD")
        ; A bit of randomness for the sake of variety
        if Utility.randomInt(1,2) == 1
            US_SLAnim = UDmain.libs.SexLab.GetAnimationsByTag(2, "Aggressive", "MF", RequireAll=true)
        else
            US_SLAnim = UDmain.libs.SelectValidDDAnimations(US_SLActors, 2, false, "MF")
        endif
    EndIf
    
    If US_SLAnim.Length > 0
        ;UDCDmain.Print("Number of anims found is " + AS_SLAnim.Length)
        ;UDCDmain.Print("Starting animation for " + GetActorName(AS_SLActors[1]) + " to rape " + GetActorName(AS_SLActors[0]))
        UDmain.libs.SexLab.StartSex(Positions = US_SLActors, Anims = US_SLAnim, Victim = US_SLActors[0])
    endif
    USlibs.DHLPResume()
EndFunction