Scriptname US_Suits extends UD_PatchInit

import UnforgivingDevicesMain
UD_AbadonQuest_script Property AbadonQuest auto
US_MCM Property USMCM auto

UD_libs Property UDlibs Hidden;device/keyword library
    UD_libs Function get()
        return UDmain.UDlibs
    EndFunction
EndProperty

;Filling out devices properties
Armor _AbadonBoxbinder
Armor Property US_AbadonBoxbinder
    Armor Function Get()
        if !_AbadonBoxbinder
            _AbadonBoxbinder = GetMeMyForm(0x15D5E3, "UnforgivingSkyrim.esp") as Armor
        endif
        return _AbadonBoxbinder
    EndFunction
    Function Set(Armor akArmor)
        _AbadonBoxbinder = akArmor
    EndFunction
EndProperty

Armor _AbadonBoxbinderOutfit
Armor Property US_AbadonBoxbinderOutfit
    Armor Function Get()
        if !_AbadonBoxbinderOutfit
            _AbadonBoxbinderOutfit = GetMeMyForm(0x15D5E5, "UnforgivingSkyrim.esp") as Armor
        endif
        return _AbadonBoxbinderOutfit
    EndFunction
    Function Set(Armor akArmor)
        _AbadonBoxbinderOutfit = akArmor
    EndFunction
EndProperty

Armor _AbadonHeavyBlindfold
Armor Property US_AbadonHeavyBlindfold
    Armor Function Get()
        if !_AbadonHeavyBlindfold
            _AbadonHeavyBlindfold = GetMeMyForm(0x15D5F9, "UnforgivingSkyrim.esp") as Armor
        endif
        return _AbadonHeavyBlindfold
    EndFunction
    Function Set(Armor akArmor)
        _AbadonHeavyBlindfold = akArmor
    EndFunction
EndProperty

Armor _AbadonHeavyGag
Armor Property US_AbadonHeavyGag
    Armor Function Get()
        if !_AbadonHeavyGag
            _AbadonHeavyGag = GetMeMyForm(0x15D5F5, "UnforgivingSkyrim.esp") as Armor
        endif
        return _AbadonHeavyGag
    EndFunction
    Function Set(Armor akArmor)
        _AbadonHeavyGag = akArmor
    EndFunction
EndProperty

Armor _AbadonHeavyCollar
Armor Property US_AbadonHeavyCollar
    Armor Function Get()
        if !_AbadonHeavyCollar
            _AbadonHeavyCollar = GetMeMyForm(0x15D5F7, "UnforgivingSkyrim.esp") as Armor
        endif
        return _AbadonHeavyCollar
    EndFunction
    Function Set(Armor akArmor)
        _AbadonHeavyCollar = akArmor
    EndFunction
EndProperty

Armor _AbadonSlaveHarness
Armor Property US_AbadonSlaveHarness
    Armor Function Get()
        if !_AbadonSlaveHarness
            _AbadonSlaveHarness = GetMeMyForm(0x15D5FB, "UnforgivingSkyrim.esp") as Armor
        endif
        return _AbadonSlaveHarness
    EndFunction
    Function Set(Armor akArmor)
        _AbadonSlaveHarness = akArmor
    EndFunction
EndProperty

;The main function override
Function EquipSuit(Actor akActor,String asEventName)
    Utility.wait(0.01) ;wait for menu to close
    UDmain.UDCDmain.DisableActor(akActor)
    if asEventName == "US_Suit_Cursed"
        EquipSuitCursed(akActor)
    elseif asEventName == "US_Suit_Boxbinder"
        EquipSuitBoxbinder(akActor)
    elseif asEventName == "US_Suit_Random"
        EquipSuitRandom(akActor)
    endif
    UDmain.UDCDmain.EnableActor(akActor)
EndFunction

Function EquipSuitCursed(Actor akActor)
    libs.strip(akActor,false)
    ;libs.SwapDevices(akActor,UDlibs.PunisherPiercing,libs.zad_DeviousPiercingsVaginal,true)
    UDmain.ItemManager.equipAbadonFinisherSuit(akActor)
    ;need to add Abadon Quest stages check to avoid triggering it too early
    if AbadonQuest.IsCompleted() && USMCM.AllowSuitAbadonPlug
        libs.SwapDevices(akActor,UDlibs.AbadonPlug,libs.zad_deviousPlugVaginal,true) ; maybe better do this at random basis? alhtough it's nice to have one suit with additional difficulty...
    endif
    ;libs.strip(akActor,false)
EndFunction

Function EquipSuitBoxbinder(Actor akActor)
    libs.strip(akActor,false)
    if (!akActor.WornhasKeyword(libs.zad_DeviousHeavyBondage))
        if akActor.wornhaskeyword(libs.zad_deviousSuit)
            libs.UnlockDeviceByKeyword(akActor,libs.zad_DeviousSuit)
        endif
        if Utility.randomInt(0,1)
            libs.LockDevice(akActor,US_AbadonBoxbinderOutfit)
        else
            libs.LockDevice(akActor,US_AbadonBoxbinder)
        endif
    endif
    UDmain.ItemManager.LockAbadonPiercings(akActor)
    UDmain.ItemManager.lockAbadonHelperPlugs(akActor)
    if (!akActor.WornhasKeyword(libs.zad_DeviousHarness) && !akActor.WornhasKeyword(libs.zad_DeviousCorset))
        libs.LockDevice(akActor,US_AbadonSlaveHarness)
    endif
    
    ; 50% chance for each of belt and bra for variety
    if (!akActor.WornhasKeyword(libs.zad_DeviousBelt) && Utility.randomInt(0,1))
        libs.LockDevice(akActor,UDlibs.AbadonBelt)
    endif
    if (!akActor.WornhasKeyword(libs.zad_DeviousBra) && Utility.randomInt(0,1))
        libs.LockDevice(akActor,UDlibs.AbadonBra)
    endif
    
    if (!akActor.WornhasKeyword(libs.zad_DeviousBlindfold))
        libs.LockDevice(akActor,US_AbadonHeavyBlindfold)
    endif
    if (!akActor.WornhasKeyword(libs.zad_DeviousGag))
        libs.LockDevice(akActor,US_AbadonHeavyGag)
    endif
    if (!akActor.WornhasKeyword(libs.zad_DeviousCollar))
        libs.LockDevice(akActor,US_AbadonHeavyCollar)
    endif
    if (!akActor.WornhasKeyword(libs.zad_DeviousBoots))
        libs.LockDevice(akActor,UDlibs.AbadonRestrictiveBoots)
    endif
    ;libs.strip(akActor,false)
EndFunction

Function EquipSuitRandom(Actor akActor)
    libs.strip(akActor,false)
    UDCDmain.DisableActor(akActor)
    
    ; maybe replace this one with bunch of random Abadon restraints?
    ;UDmain.UDRRM.LockAllSuitableRestrains(akActor,force = false)
    
    ; here's replacement
    int _randomDevice
    ; heavy bondage or straitjackets first
    if (!akActor.WornhasKeyword(libs.zad_DeviousHeavyBondage))
        if (!akActor.WornhasKeyword(libs.zad_DeviousSuit))
            _randomDevice = Utility.randomInt(0,400) ; 101-400 is for straitjackets, they have bigger weight to be seen more because catsuits block them
        else
            _randomDevice = Utility.randomInt(0,100)
        endif
        if _randomDevice < 20
            libs.LockDevice(akActor,UDlibs.AbadonElbowbinderEbonite)
        elseif _randomDevice < 40
            libs.LockDevice(akActor,UDlibs.AbadonArmbinderEbonite)
        elseif _randomDevice < 60
            libs.LockDevice(akActor,UDlibs.AbadonArmbinder)
        elseif _randomDevice < 80
            libs.LockDevice(akActor,UDlibs.RogueBinder)
        elseif _randomDevice < 90
            libs.LockDevice(akActor,UDlibs.PunisherArmbinder)
        elseif _randomDevice < 101
            libs.LockDevice(akActor,UDlibs.AbadonBlueArmbinder)
        ;straitjackets section
        elseif _randomDevice < 150
            libs.LockDevice(akActor,US_AbadonBoxbinderOutfit)
        elseif _randomDevice < 200
            libs.LockDevice(akActor,US_AbadonBoxbinder)
        elseif _randomDevice < 250
            libs.LockDevice(akActor,UDlibs.AbadonStraitjacketEbonite)
        elseif _randomDevice < 300
            libs.LockDevice(akActor,UDlibs.AbadonStraitjacketEboniteOpen)
        elseif _randomDevice < 350
            libs.LockDevice(akActor,UDlibs.AbadonStraitjacket)
        elseif _randomDevice < 380
            libs.LockDevice(akActor,UDlibs.MageBinder)
        else
            libs.LockDevice(akActor,UDlibs.AbadonCursedStraitjacket)    
        endif
    endif

    ;piercings, vaginal and nipple, 75% for each
    if (!akActor.WornhasKeyword(libs.zad_DeviousPiercingsVaginal))
        _randomDevice = Utility.randomInt(0,100)
        if _randomDevice < 75
            libs.LockDevice(akActor,UDlibs.AbadonPiercingVaginal)    
        endif
    endif
    if (!akActor.WornhasKeyword(libs.zad_DeviousPiercingsNipple))
        _randomDevice = Utility.randomInt(0,100)
        if _randomDevice < 75
            libs.LockDevice(akActor,UDlibs.AbadonPiercingNipple)    
        endif
    endif
    
    ;hoods/gasmasks, chance none will be applied is 50%
    if (!akActor.WornhasKeyword(libs.zad_DeviousHood))
        _randomDevice = Utility.randomInt(0,100)
        if _randomDevice < 35
            libs.LockDevice(akActor,UDlibs.AbadonGasmask)
        elseif _randomDevice < 50
            libs.LockDevice(akActor,UDlibs.CursedAbadonGasmask)
        endif
    endif

    ;Corset or harness or 25% for nothing
    if (!akActor.WornhasKeyword(libs.zad_DeviousCorset) && !akActor.WornhasKeyword(libs.zad_DeviousHarness))
        _randomDevice = Utility.randomInt(0,100)
        if _randomDevice < 35
            libs.LockDevice(akActor,UDlibs.AbadonCorset)
        elseif _randomDevice < 50
            libs.LockDevice(akActor,US_AbadonSlaveHarness)
        elseif _randomDevice < 75 && !akActor.WornhasKeyword(libs.zad_DeviousBelt) && !akActor.WornhasKeyword(libs.zad_DeviousCollar)
            libs.LockDevice(akActor,UDlibs.AbadonHarness)
        endif
    endif

    ;gags
    if (!akActor.WornhasKeyword(libs.zad_DeviousGag))
        _randomDevice = Utility.randomInt(0,100)
        if _randomDevice < 15
            libs.LockDevice(akActor,UDlibs.AbadonBallGag)
        elseif _randomDevice < 30
            libs.LockDevice(akActor,UDlibs.AbadonPanelGag)
        elseif _randomDevice < 45
            libs.LockDevice(akActor,UDlibs.AbadonRingGag)
        elseif _randomDevice < 60
            libs.LockDevice(akActor,UDlibs.AbadonGagTape)
        elseif _randomDevice < 75
            libs.LockDevice(akActor,UDlibs.AbadonExtremeBallGag)
        elseif _randomDevice < 90
            libs.LockDevice(akActor,UDlibs.AbadonExtremeInflatableGag)
        else
            libs.LockDevice(akActor,US_AbadonHeavyGag)
        endif
    endif
    
    ;blindfolds
    if (!akActor.WornhasKeyword(libs.zad_DeviousGag))
        _randomDevice = Utility.randomInt(0,100)
        if _randomDevice < 50
            libs.LockDevice(akActor,UDlibs.AbadonBlindfold)
        else
            libs.LockDevice(akActor,US_AbadonHeavyBlindfold)
        endif
    endif

    ;belt, chance none will be applied is 25%
    if (!akActor.WornhasKeyword(libs.zad_DeviousBelt))
        _randomDevice = Utility.randomInt(0,100)
        if _randomDevice < 35
            libs.LockDevice(akActor,UDlibs.AbadonBelt)
        elseif _randomDevice < 75 && !akActor.WornhasKeyword(libs.zad_DeviousHarness) && !akActor.WornhasKeyword(libs.zad_DeviousCorset) && !akActor.WornhasKeyword(libs.zad_DeviousCollar)
            libs.LockDevice(akActor,UDlibs.AbadonHarness)
        endif
    endif
    
    ;bra, chance none will be applied is 25%
    if (!akActor.WornhasKeyword(libs.zad_DeviousBra))
        _randomDevice = Utility.randomInt(0,100)
        if _randomDevice < 75
            libs.LockDevice(akActor,UDlibs.AbadonBra)
        endif
    endif

    ;gloves/mittens, chance none is 25%
    if (!akActor.WornhasKeyword(libs.zad_DeviousGloves))
        _randomDevice = Utility.randomInt(0,100)
        if _randomDevice < 35
            libs.LockDevice(akActor,UDlibs.AbadonRestrictiveGloves)
        elseif _randomDevice < 75
            libs.LockDevice(akActor,UDlibs.AbadonMittens)
        endif
    endif

    ;boots, chance none is 25%
    if (!akActor.WornhasKeyword(libs.zad_DeviousBoots))
        _randomDevice = Utility.randomInt(0,100)
        if _randomDevice < 35
            libs.LockDevice(akActor,UDlibs.AbadonRestrictiveBoots)
        elseif _randomDevice < 75
            libs.LockDevice(akActor,UDlibs.AbadonBalletBoots)
        endif
    endif
    
    ;collars, chance none is 25%
    if (!akActor.WornhasKeyword(libs.zad_DeviousBoots))
        _randomDevice = Utility.randomInt(0,100)
        if _randomDevice < 25
            libs.LockDevice(akActor,UDlibs.AbadonRestrictiveCollar)
        elseif _randomDevice < 50
            libs.LockDevice(akActor,UDlibs.AbadonCuffCollar)
        elseif _randomDevice < 75
            libs.LockDevice(akActor,US_AbadonHeavyCollar)
        endif
    endif
    
    ;cuffs, arm and leg, 75% for each
    if (!akActor.WornhasKeyword(libs.zad_DeviousArmCuffs))
        _randomDevice = Utility.randomInt(0,100)
        if _randomDevice < 75
            libs.LockDevice(akActor,UDlibs.AbadonArmCuffs)    
        endif
    endif
    if (!akActor.WornhasKeyword(libs.zad_DeviousLegCuffs))
        _randomDevice = Utility.randomInt(0,100)
        if _randomDevice < 75
            libs.LockDevice(akActor,UDlibs.AbadonLegsCuffs)    
        endif
    endif

    ;finally plugs, vaginal and anal, chance none is 25%
    if (!akActor.WornhasKeyword(libs.zad_DeviousPlugVaginal))
        _randomDevice = Utility.randomInt(0,100)
        if _randomDevice < 50
            libs.LockDevice(akActor,UDlibs.InflatablePlugVag)    
        elseif _randomDevice < 75 && AbadonQuest.IsCompleted() && USMCM.AllowSuitAbadonPlug ; check for Abadon quest to avoid triggering it too early
            libs.LockDevice(akActor,UDlibs.AbadonPlug)    
        endif
    endif
    if (!akActor.WornhasKeyword(libs.zad_DeviousPlugAnal))
        _randomDevice = Utility.randomInt(0,100)
        if _randomDevice < 20
            libs.LockDevice(akActor,UDlibs.InflatablePlugAnal)   
        elseif _randomDevice < 40
            libs.LockDevice(akActor,UDlibs.LittleHelper)    
        elseif _randomDevice < 60
            libs.LockDevice(akActor,UDlibs.CursedInflatablePlugAnal)    
        elseif _randomDevice < 75 && AbadonQuest.IsCompleted() && USMCM.AllowSuitAbadonPlug ; check for Abadon quest to avoid triggering it too early
            libs.LockDevice(akActor,UDlibs.AbadonPlugAnal)    
        endif
    endif

    UDCDmain.EnableActor(akActor)
    ;libs.strip(akActor,false)
EndFunction
