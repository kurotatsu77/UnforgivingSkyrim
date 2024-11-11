Scriptname US_AbadonExecution_ME_Script extends activemagiceffect  

import UnforgivingDevicesMain

UD_AbadonQuest_script Property UD_AbadonQuest auto

zadlibs Property libs auto

zadlibs_UDPatch Property libsp
    zadlibs_UDPatch Function get()
        return libs as zadlibs_UDPatch
    EndFunction
EndProperty

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

Event OnEffectStart(Actor akTarget, Actor akCaster)
    if !UDCDMain.UDmain.ActorIsValidForUD(akTarget)
        return ;non valid actor, return
    endif
    ;libsp.strip(akTarget,false)
;    if !akTarget.wornhaskeyword(libs.zad_DeviousPiercingsVaginal)
;        libs.LockDevice(akTarget,UDlibs.PunisherPiercing)
;    endif
    libs.SwapDevices(akTarget, UDlibs.PunisherPiercing, libs.zad_DeviousPiercingsVaginal)
    UDmain.ItemManager.equipAbadonFinisherSuit(akTarget)
    Utility.Wait(5)
    if UD_AbadonQuest.IsCompleted()
;        if (akTarget.WornhasKeyword(libs.zad_deviousPlugVaginal))
;            Armor loc_plug
;            loc_plug = libs.getWornDevice(akTarget, libs.zad_deviousPlugVaginal) 
;            libs.UnlockDevice(akTarget, deviceInventory = loc_plug, zad_DeviousDevice = libs.zad_deviousPlugVaginal, destroydevice = true, genericonly = true)
;            Utility.Wait(0.5)
;        endif
;        libs.LockDevice(akTarget, UDlibs.AbadonPlug)
        libs.SwapDevices(akTarget, UDlibs.AbadonPlug, libs.zad_deviousPlugVaginal)
    endif
EndEvent