Scriptname US_UragGRQ_Script extends Quest Conditional
{This script contains all variables to control Urag's knowledge of the recipes.}

US_libs Property USlibs auto
US_GooResearch_Script Property GRQ  Auto  
Spell Property MasoSpell auto
ReferenceAlias Property Player  Auto
ReferenceAlias Property Urag  Auto
MiscObject Property Gold auto
Ingredient Property BlackGoo auto
Ingredient Property ConcBlackGoo auto

float Property LastTimeActivated = 0.0  auto
int Property BaseReward = 500 auto      ; base reward, all rewards are done as multipliers of this
int Property GoldAvailable = 500 auto   ; Amount of gold gathered by Urag to pay as additional research award
int Property GoldPerDay = 500 auto      ; Amount of gold got by Urag per day

int Property ChosenResearch = 0 auto conditional ; which research Urag chose to do
; 0 - none
; 1 - Black Goo
; 2 - Concentrated Black Goo
; 3 - Purified Black Goo
; 4 - Cursed Goo
; 5 - Abadon Execution 
; 6 - Abadon Plug
; 7 - Abadon Shout

; rewards multipliers list
float Property BlackGooReward       = 1.0   auto
float Property ConcBlackGooReward   = 2.0   auto
float Property PureBlackGooReward   = 2.0   auto
float Property CursedGooReward      = 5.0   auto
float Property ExecutionGooReward   = 10.0  auto
float Property PlugReward           = 3.0   auto
float Property ShoutReward          = 2.0   auto

;rework and change names?
bool Property ConcGoo                   = false auto conditional    ; shown Concentrated Black Goo
bool Property GooRecipesBasic           = false auto conditional    ; convert Black Goo into Concentrated
bool Property GooRecipesAdvanced        = false auto conditional    ; make (Concentrated) Goo Balls
bool Property GooRecipesCursed          = false auto conditional    ; make Cursed Goo
bool Property GooRecipesPurified        = false auto conditional    ; make Purified Goo and Purified Water
bool Property DragonNutsRecipes         = false auto conditional    ; make Cooked Dragon Nuts
bool Property AbadonPlug                = false auto conditional    ; demonstrated Abadon Plug
bool Property AbadoniumRecipes          = false auto conditional    ; make Abadonium Ingots
bool Property AbadonWeaponsRecipes      = false auto conditional    ; make Abadon Weapons
bool Property AbadonRingRecipes         = false auto conditional    ; make Abadon Ring
bool Property ControllablePlugsRecipes  = false auto conditional    ; make Controllable Plugs
bool Property ChargablePlugsRecipes     = false auto conditional    ; make Chargable Plugs
bool Property ExecutionPotionRecipes    = false auto conditional    ; make Abadon Execution Potion
bool Property AbadonShout               = false auto conditional    ; demonstrated Abadon Shout

; Gives to player reward, afReward is multiplier to be applied to BaseReward, if abMakeProfit set - adds triple amount of gold to available reward instead of deducting it
Function GiveReward(float afReward, bool abMakeProfit = false)
    int loc_gold
    loc_gold = Round((BaseReward * afReward))
    Player.GetActorRef().AddItem(Gold, loc_gold)
    if abMakeProfit
        GoldAvailable = GoldAvailable + Round(loc_gold)
    else
        GoldAvailable = GoldAvailable - loc_gold
    endif
EndFunction

; Calculates income at this moment in time, applies to GoldAvailable, more he knows - more he earns
Function CalculateIncome()
    if LastTimeActivated == 0.0 ;&& GoldAvailable == 500; failsafe to ensure timer is reset in case the quest was started manually, otherwise Urag will have ridiculous amount of gold gathered
        StartTimer()
        return
    endif
    float loc_DaysPassed
    loc_DaysPassed = Utility.GetCurrentGameTime() - LastTimeActivated
    GoldAvailable = GoldAvailable + Round(GoldPerDay * loc_DaysPassed)
    if ConcGoo
        GoldAvailable = GoldAvailable + Round(GoldPerDay * ConcBlackGooReward * loc_DaysPassed)
    endif
    if GooRecipesBasic
        GoldAvailable = GoldAvailable + Round(GoldPerDay * ConcBlackGooReward * loc_DaysPassed)
    endif
    if GooRecipesAdvanced
        GoldAvailable = GoldAvailable + Round(GoldPerDay * ConcBlackGooReward * loc_DaysPassed)
    endif
    if GooRecipesCursed
        GoldAvailable = GoldAvailable + Round(GoldPerDay * CursedGooReward * loc_DaysPassed)
    endif
    if GooRecipesPurified
        GoldAvailable = GoldAvailable + Round(GoldPerDay * ConcBlackGooReward * loc_DaysPassed)
    endif
    if DragonNutsRecipes
        GoldAvailable = GoldAvailable + Round(GoldPerDay * ConcBlackGooReward * loc_DaysPassed)
    endif
    if AbadonPlug
        GoldAvailable = GoldAvailable + Round(GoldPerDay * PlugReward * loc_DaysPassed)
    endif
    if AbadoniumRecipes
        GoldAvailable = GoldAvailable + Round(GoldPerDay * PlugReward * loc_DaysPassed)
    endif
    if AbadonWeaponsRecipes
        GoldAvailable = GoldAvailable + Round(GoldPerDay * PlugReward * loc_DaysPassed)
    endif
    if AbadonRingRecipes
        GoldAvailable = GoldAvailable + Round(GoldPerDay * PlugReward * loc_DaysPassed)
    endif
    if ControllablePlugsRecipes
        GoldAvailable = GoldAvailable + Round(GoldPerDay * PlugReward * loc_DaysPassed)
    endif
    if ChargablePlugsRecipes
        GoldAvailable = GoldAvailable + Round(GoldPerDay * PlugReward * loc_DaysPassed)
    endif
    if ExecutionPotionRecipes
        GoldAvailable = GoldAvailable + Round(GoldPerDay * ExecutionGooReward * loc_DaysPassed)
    endif
    LastTimeActivated = Utility.GetCurrentGameTime()
EndFunction

; Chooses which research Urag wants to perform, based on what is known and how much gold gathered
Function ChooseResearch()
    if ((Utility.GetCurrentGameTime() - LastTimeActivated) > 0.5) || (ChosenResearch == 0) ; if already chosen research - change it once per 12 hours
        CalculateIncome()
        ChosenResearch = 0
        int[] loc_researches = new int [7]
        int loc_total = 0
        if GoldAvailable > Round(BaseReward * BlackGooReward)
            loc_researches[loc_total] = 1
            loc_total += 1
        endif
        if ConcGoo && (GoldAvailable > Round(BaseReward * ConcBlackGooReward))
            loc_researches[loc_total] = 2
            loc_total += 1
        endif
        if GooRecipesPurified && (GoldAvailable > Round(BaseReward * PureBlackGooReward))
            loc_researches[loc_total] = 3
            loc_total += 1
        endif
        if GooRecipesCursed && (GoldAvailable > Round(BaseReward * CursedGooReward))
            loc_researches[loc_total] = 4
            loc_total += 1
        endif
        if ExecutionPotionRecipes && (GoldAvailable > Round(BaseReward * ExecutionGooReward))
            loc_researches[loc_total] = 5
            loc_total += 1
        endif
        if AbadonPlug && (GoldAvailable > Round(BaseReward * PlugReward))
            loc_researches[loc_total] = 6
            loc_total += 1
        endif
        if AbadonShout && (GoldAvailable > Round(BaseReward * ShoutReward))
            loc_researches[loc_total] = 7
            loc_total += 1
        endif
        if loc_total > 0
            int loc_random
            loc_random = Utility.RandomInt(1,loc_total)
            ChosenResearch = loc_researches[loc_random - 1]
        endif
    endif
EndFunction

; used to fire off timer when quest starts
Function StartTimer()
    LastTimeActivated = Utility.GetCurrentGameTime()
    ;GoldAvailable = 500
EndFunction

int Function Round(float afValue)
    return Math.floor(afValue + 0.5)
EndFunction

;performs sexscene between player and Urag with tag defined by asTag
Function StartSex(string asTag="MF")
    USlibs.DHLPSuspend() 
    Utility.Wait(3)
    USlibs.UDCDmain.DisableActor(Player.GetActorRef())
    Game.SetPlayerAIDriven(true)

    Actor[] loc_SLActors = new Actor[2]
    sslBaseAnimation[] loc_SLAnim    
    loc_SLActors[0] = Player.GetActorRef()
    loc_SLActors[1] = Urag.GetActorRef()

    ; A bit of randomness for the sake of variety
    if Utility.randomInt(1,2) == 1
        loc_SLAnim = USlibs.UDmain.libs.SexLab.GetAnimationsByTag(2, "Aggressive", asTag, RequireAll=true)
    else
        loc_SLAnim = USlibs.UDmain.libs.SelectValidDDAnimations(loc_SLActors, 2, true, asTag)
    endif
    ; fallback to consensual MF if nothing found
    If loc_SLAnim.Length == 0
        loc_SLAnim = USlibs.UDmain.libs.SelectValidDDAnimations(loc_SLActors, 2, false, asTag)
    EndIf

    If loc_SLAnim.Length > 0
        USlibs.UDmain.libs.SexLab.StartSex(Positions = loc_SLActors, Anims = loc_SLAnim, Victim = Player.GetActorRef())
    endif

    while USlibs.UDmain.libs.IsAnimating(Player.GetActorRef())
        Utility.Wait(1)
    endwhile

    USlibs.UDCDmain.EnableActor(Player.GetActorRef())
    Game.SetPlayerAIDriven(false)
    USlibs.DHLPResume()

    MasoSpell.Cast(Player.GetActorRef())
    USlibs.UDmain.Print("You feel strangely invigorated by this encounter!")
EndFunction

; makes Urag to whip player
Function Whip()
    USlibs.DHLPSuspend() 
    Utility.Wait(3)
    USlibs.UDCDmain.DisableActor(Player.GetActorRef())
    Game.SetPlayerAIDriven(true)

    USlibs.USWhip(Player.GetActorRef(), Urag.GetActorRef())
    
    USlibs.UDCDmain.EnableActor(Player.GetActorRef())
    Game.SetPlayerAIDriven(false)
    USlibs.DHLPResume()

    MasoSpell.Cast(Player.GetActorRef())
    USlibs.UDmain.Print("You feel strangely invigorated by this encounter!")
EndFunction

Function DoResearch()
    int loc_relation = Urag.GetActorRef().GetRelationshipRank(Player.GetActorRef())    
    if ChosenResearch == 0
        return
    elseif ChosenResearch == 1
        USlibs.UDmain.Print("Doing Black Goo action.")
        Player.GetActorRef().AddItem(BlackGoo, 1)
        Player.GetActorRef().EquipItem(BlackGoo)
        Utility.Wait(1)
        StartSex()
        GiveReward(BlackGooReward)
        if loc_relation < 1
            Urag.GetActorRef().SetRelationshipRank(Player.GetActorRef(), loc_relation + 1)
        endif
        GRQ.Masochism = GRQ.Masochism + 2
        ChosenResearch = 0
    elseif ChosenResearch == 2
        USlibs.UDmain.Print("Doing Concentrated Black Goo action.")
        Player.GetActorRef().AddItem(ConcBlackGoo, 1)
        Player.GetActorRef().EquipItem(ConcBlackGoo)
        Utility.Wait(1)
        Whip()
        GiveReward(ConcBlackGooReward)
        if loc_relation < 2
            Urag.GetActorRef().SetRelationshipRank(Player.GetActorRef(), loc_relation + 1)
        endif
        GRQ.Masochism = GRQ.Masochism + 3
        ChosenResearch = 0
    elseif ChosenResearch == 3
        USlibs.UDmain.Print("Doing Purified Black Goo action.")
        ChosenResearch = 0
    elseif ChosenResearch == 4
        USlibs.UDmain.Print("Doing Cursed Goo action.")
        ChosenResearch = 0
    elseif ChosenResearch == 5
        USlibs.UDmain.Print("Doing Abadon Execution action.")
        ChosenResearch = 0
    elseif ChosenResearch == 6
        USlibs.UDmain.Print("Doing Abadon Plug action.")
        ChosenResearch = 0
    elseif ChosenResearch == 7
        USlibs.UDmain.Print("Doing Abadon Shout action.")
        ChosenResearch = 0
    else
        ChosenResearch = 0
    endif
EndFunction

