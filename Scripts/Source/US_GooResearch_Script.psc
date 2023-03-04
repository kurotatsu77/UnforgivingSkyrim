Scriptname US_GooResearch_Script extends Quest  Conditional
{Goo Research Quest conditional script}

Ingredient Property BlackGoo  Auto  
Ingredient Property ConcBlackGoo  Auto  
ReferenceAlias Property Nodaba  Auto  
ReferenceAlias Property Hulda  Auto  
Faction Property US_GRQFaction Auto
Key Property HubKey Auto

;how infamous our player as masochist across Skyrim
int Property Masochism = 0 auto conditional

;conditionals to control available recipes, consult the pdf to see research flowchart
bool Property GooRecipesBasic           = false auto conditional    ; convert Black Goo into Concentrated
bool Property GooRecipesAdvanced        = false auto conditional    ; make (Concentrated) Goo Balls
bool Property GooRecipesCursed          = false auto conditional    ; make Cursed Goo
bool Property GooRecipesPurified        = false auto conditional    ; make Purified Goo and Purified Water
bool Property DragonNutsRecipes         = false auto conditional    ; make Cooked Dragon Nuts
bool Property AbadoniumRecipes          = false auto conditional    ; make Abadonium Ingots
bool Property AbadonWeaponsRecipes      = false auto conditional    ; make Abadon Weapons
bool Property AbadonRingRecipes         = false auto conditional    ; make Abadon Ring
bool Property ControllablePlugsRecipes  = false auto conditional    ; make Controllable Plugs
bool Property ChargablePlugsRecipes     = false auto conditional    ; make Chargable Plugs
bool Property ExecutionPotionRecipes    = false auto conditional    ; make Abadon Execution Potion
