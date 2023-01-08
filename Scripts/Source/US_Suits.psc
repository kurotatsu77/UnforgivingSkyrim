Scriptname US_Suits extends UD_PatchInit

import UnforgivingDevicesMain
UDCustomDeviceMain Property UDCDmain auto

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
    libs.SwapDevices(akActor,UDlibs.AbadonPlug,libs.zad_deviousPlugVaginal,true) ; maybe better do this at random basis? alhtough it's nice to have one suit with additional difficulty...
    UDmain.ItemManager.equipAbadonFinisherSuit(akActor)
    ;libs.strip(akActor,false)
EndFunction

Function EquipSuitBoxbinder(Actor akActor)
    libs.strip(akActor,false)
    if akActor.wornhaskeyword(libs.zad_deviousSuit)
        libs.UnlockDeviceByKeyword(akActor,libs.zad_DeviousSuit)
    endif
    if Utility.randomInt(0,1)
        libs.SwapDevices(akActor,US_AbadonBoxbinderOutfit,libs.zad_deviousHeavyBondage,true)
    else
        libs.SwapDevices(akActor,US_AbadonBoxbinder,libs.zad_deviousHeavyBondage,true)
    endif
    UDmain.ItemManager.LockAbadonPiercings(akActor)
    UDmain.ItemManager.lockAbadonHelperPlugs(akActor)
    libs.SwapDevices(akActor,US_AbadonSlaveHarness,libs.zad_DeviousHarness,true)
    libs.SwapDevices(akActor,UDlibs.AbadonBelt,libs.zad_DeviousBelt,true)
    libs.SwapDevices(akActor,UDlibs.AbadonBra,libs.zad_DeviousBra,true)
    libs.SwapDevices(akActor,US_AbadonHeavyBlindfold,libs.zad_DeviousBlindfold,true)
    libs.SwapDevices(akActor,US_AbadonHeavyGag,libs.zad_DeviousGag,true)
    libs.SwapDevices(akActor,US_AbadonHeavyCollar,libs.zad_DeviousCollar,true)
    libs.SwapDevices(akActor,UDlibs.AbadonRestrictiveBoots,libs.zad_DeviousBoots,true)
    ;libs.strip(akActor,false)
EndFunction

Function EquipSuitRandom(Actor akActor)
    libs.strip(akActor,false)
    UDCDmain.DisableActor(akActor)
    UDmain.UDRRM.LockAllSuitableRestrains(akActor,force = false)
    UDCDmain.EnableActor(akActor)
    ;libs.strip(akActor,false)
EndFunction
