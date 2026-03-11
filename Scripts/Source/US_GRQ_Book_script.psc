Scriptname US_GRQ_Book_script extends ObjectReference  

US_GooResearch_Script Property GRQ auto
GlobalVariable Property BCCraftEnable auto

Event OnRead()
    GRQ.GooRecipesBasic = true
    GRQ.GooRecipesAdvanced = true
    GRQ.GooRecipesCursed = true
    GRQ.GooRecipesPurified = true
    GRQ.DragonNutsRecipes = true
    GRQ.AbadoniumRecipes = true
    GRQ.AbadonWeaponsRecipes = true
    GRQ.AbadonRingRecipes = true
    GRQ.ControllablePlugsRecipes = true
    GRQ.ChargablePlugsRecipes = true
    GRQ.ExecutionPotionRecipes = true
    
	BCCraftEnable.SetValueInt(1)
EndEvent
