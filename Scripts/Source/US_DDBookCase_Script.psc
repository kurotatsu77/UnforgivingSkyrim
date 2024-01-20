Scriptname US_DDBookCase_Script extends ObjectReference  
{Trap control script for the Forbidden Bookcase}

zadlibs property libs auto 
zadxlibs property libsx auto
zadxlibs2 property libsx2 auto
SexLabFramework Property SexLab auto

Key Property DDBookCaseKey auto
bool Property TrapOn = true auto
bool CanActivate = true

Faction Property CurrentFollowerFaction auto
FormList FollowerList

Event OnActivate(ObjectReference akActionRef)
    ;Actor loc_player = Game.GetPlayer() ; using libs.playerref instead because libs defined anyways
    if CanActivate && TrapOn && akActionRef == libs.playerref && (libs.playerref.GetItemCount(DDBookCaseKey) > 0)
        CanActivate = false
        RegisterForSingleUpdate(60)
        Debug.MessageBox("Ahaha, they were so stupid to leave that key in the open! You feel quite happy with cunning yourself as you open the bookcase, but suddenly trap inside springs up! Sudden darkness embraces you and you lose consciousness...")
        UI.InvokeString("ContainerMenu", "_global.skse.CloseMenu", "ContainerMenu") ; force close the container menu
        ;remove all keys and lockpicks, relock the bookcase
        libs.playerref.RemoveItem(DDBookCaseKey, libs.playerref.GetItemCount(DDBookCaseKey))
        libs.playerref.RemoveItem(libs.chastityKey, libs.playerref.GetItemCount(libs.chastityKey))
        libs.playerref.RemoveItem(libs.restraintsKey, libs.playerref.GetItemCount(libs.restraintsKey))
        libs.playerref.RemoveItem(libs.piercingKey, libs.playerref.GetItemCount(libs.piercingKey))
        libs.playerref.RemoveItem(libs.Lockpick, libs.playerref.GetItemCount(libs.Lockpick))
        self.Lock()
        ;try to send player to Simple Slavery if it's present, otherwise punish the player by binding them and dismissing follower
        if (Game.GetModByName("SimpleSlavery.esp") != 255) && (Game.GetModByName("SimpleSlavery.esp") != 0) ; 255 = not found, 0 = no skse
            sendModEvent("SSLV Entry") ;Thanks to HexBolt8 for SS++ and Bane Master for FSM, it makes results so much more flexible and better!
        else ; no Simple Slavery enabled, dismiss follower and make player into fuck pet
            ;add blackout here
            Game.FadeOutGame(False, True, 1000000, 1)
            ;No follower frameworks support here because it's PIA. Want to have them supported? Install SS++ and FSM! Credit here goes to Code Serpent
            Quest DialogueFollower = Quest.GetQuest("DialogueFollower")
            (DialogueFollower As DialogueFollowerScript).DismissFollower(0, 0)
            libs.strip(libs.playerref,false)
            if !libs.playerref.wornhaskeyword(libs.zad_DeviousBlindfold)
                libs.LockDevice(libs.playerref,libsx.eboniteBlindfold)
            endif
            if !libs.playerref.wornhaskeyword(libs.zad_DeviousGag)
                libs.LockDevice(libs.playerref,libsx.gagEboniteRing)
            endif
            if !libs.playerref.wornhaskeyword(libs.zad_DeviousGloves)
                libs.LockDevice(libs.playerref,libsx.zadx_PawBondageMittensLatexInventory)
            endif
            if !libs.playerref.wornhaskeyword(libs.zad_DeviousHeavyBondage)
                libs.LockDevice(libs.playerref,libsx2.zadx_PetSuit_Ebonite_Black_Inventory)
            endif
            ;blackout end here
            Game.FadeOutGame(False,True, 0.1, 2.0)
	        Utility.Wait(2)
            Debug.MessageBox("...as you regain consciousness, you can't see a thing, your mouth forced open by something in it and your limbs forced to be bent. Now all that left to check if you still have your keys and lockpicks. And your companion surely will help, right?")
            Utility.Wait(1)
            UI.InvokeString("ContainerMenu", "_global.skse.CloseMenu", "ContainerMenu") ; force close the container and all other menus again, just to be sure...
            UI.InvokeString("Dialogue Menu", "_global.skse.CloseMenu", "Dialogue Menu")
            UI.InvokeString("InventoryMenu", "_global.skse.CloseMenu", "InventoryMenu")
            UI.InvokeString("TweenMenu", "_global.skse.CloseMenu", "TweenMenu")
            UI.InvokeString("GiftMenu", "_global.skse.CloseMenu", "GiftMenu")
        endif
    elseif CanActivate && !TrapOn && akActionRef == libs.playerref && (libs.playerref.GetItemCount(DDBookCaseKey) > 0)
        CanActivate = false
        Debug.MessageBox("You heard some rumors about this bookcase and Urag, but now you have permission, it should be safe, right? With trepidation you open the bookcase and nothing happens. Looks like whatever trap was set here is now disabled, at least for you.")
        RegisterForSingleUpdate(3)
    endif
EndEvent

Event OnUpdate()
    if !CanActivate
        CanActivate = true
    endif
EndEvent
