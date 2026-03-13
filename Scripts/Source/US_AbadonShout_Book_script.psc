Scriptname US_AbadonShout_Book_script extends ObjectReference  

US_libs Property USLibs auto
Message Property US_ASB_MSG Auto

Event OnRead()
    if !USLibs.MQ104.IsCompleted() && !USLibs.ASQuest.IsRunning() && !USLibs.ASQuest.IsCompleted() ; starting the Abadon Shout learning quest at pre-MQ014 stage
        USLibs.ASQuest.Start()
        USLibs.ASQuest.SetStage(50)
        USLibs.ASQuest.SetObjectiveDisplayed(50)
    elseif USLibs.MQ104.IsCompleted() && !USLibs.ASQuest.IsRunning() && !USLibs.ASQuest.IsCompleted() ; starting the Abadon Shout learning quest if it not running and not complete yet
        USLibs.ASQuest.Start()
        USLibs.ASQuest.SetStage(100)
        USLibs.ASQuest.SetObjectiveDisplayed(100)
    elseif USLibs.ASQuest.IsRunning() && !USLibs.ASQuest.IsCompleted() ; will not handle event of already knowing it all, it will be ordinary book.
		int ASBSouls = Game.GetPlayer().GetActorValue("DragonSouls") as int	; ASBSouls - number of dragon souls player has
		int loc_choice
		if ASBSouls > 0 ; no need to go further if no dragon souls present
			int ASQStage = USLibs.ASQuest.GetCurrentStageID()
			Utility.Wait(10.0)
			if  ASQStage == 100 ; Learning first Abadon Shout word
                loc_choice = US_ASB_MSG.Show()
                if loc_choice == 0
					ASBSouls -= 1
					Game.GetPlayer().ForceActorValue("DragonSouls", ASBSouls)
		            debug.messagebox("Now you finally have full understanding, it makes perfect sense for Master to bind woman's hands before using her, bound sex is great!")
        	        Game.GetPlayer().AddShout(USLibs.AbadonShout)
            	    Game.TeachWord(USLibs.AbadonShoutWord1)
	               	Game.UnlockWord(USLibs.AbadonShoutWord1)
	   	            USLibs.ASQuest.SetObjectiveCompleted(100)
    	            USLibs.ASQuest.SetStage(200)
	                USLibs.ASQuest.SetObjectiveDisplayed(200)
				endif
			elseif  ASQStage == 200 ; Learning second Abadon Shout word
                loc_choice = US_ASB_MSG.Show()
                if loc_choice == 0
					ASBSouls -= 1
					Game.GetPlayer().ForceActorValue("DragonSouls", ASBSouls)
    	            debug.messagebox("Second Word understanding is now clear to you - only through true helplessness of being bound, gagged and blindfolded woman can achieve a true masochist's delight.")
        	        Game.TeachWord(USLibs.AbadonShoutWord2)
            	    Game.UnlockWord(USLibs.AbadonShoutWord2)
                	USLibs.ASQuest.SetObjectiveCompleted(200)
	                USLibs.ASQuest.SetStage(300)
    	            USLibs.ASQuest.SetObjectiveDisplayed(300)
				endif
			elseif  ASQStage == 300 ; Learning third Abadon Shout word			
                loc_choice = US_ASB_MSG.Show()
                if loc_choice == 0
					ASBSouls -= 1
					Game.GetPlayer().ForceActorValue("DragonSouls", ASBSouls)
    	            debug.messagebox("It's very obvious now to you. Women are slaves to Master's whims, to be wrapped in restraints and used. Master does not need permission from slave meat. Being reduced to bound playtoy without any rights feels wonderful!")
        	        Game.TeachWord(USLibs.AbadonShoutWord3)
            	    Game.UnlockWord(USLibs.AbadonShoutWord3)
	               	USLibs.ASQuest.SetObjectiveCompleted(300)
    	            USLibs.ASQuest.SetStage(1000)
        	        USLibs.ASQuest.CompleteQuest()
				endif
			endif
		else 
            debug.messagebox("You feel you lack necessary dragon power to truly absorb the knowledge. Time to hunt some dragons!")
		endif
    endif
EndEvent
