Scriptname US_GRQStarter_Script extends ReferenceAlias
{This will kickstart Goo Research Quest into proper stage}

Location Property Whiterun  Auto  
Ingredient Property BlackGoo  Auto  
Quest Property GRQ  Auto  
Quest Property GRQStarter  Auto  

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
    if akNewLoc == Whiterun
        if (Game.GetPlayer().GetItemCount(BlackGoo) > 0)
            if BlackGoo.GetIsNthEffectKnown(0)
                GRQ.SetStage(10)
                GRQStarter.Stop()
            endif
        endif
    endif
EndEvent
