Scriptname US_GRQ_RLogScript extends ObjectReference
{This is actual research drive script}

import UnforgivingDevicesMain
UD_libs Property UDlibs auto
US_GooResearch_Script Property GRQ auto
US_GRQ_RChestScript Property RChest auto
ObjectReference Property StationAlchemy auto
ObjectReference Property StationEnchant auto

float Property LastTimeActivated = 0.0  auto
int ResearchPoints = 0
int Property ResearchPointsPerDay = 24 auto

;these values are unboosted, i.e. without appropriate stations
int Property AlchemyRPCost = 3 auto                 
int Property AlchemyGoldCost = 300 auto
int Property EnchantRPCost = 6 auto
int Property EnchantGoldCost = 600 auto

;how much stations reduce costs of researches using them
int Property BoostAlchemyMultiplier = 3 auto
int Property BoostEnchantMultiplier = 3 auto

Keyword Property IngredientKeyword Auto
MiscObject Property Gold Auto

;some are defined in UDlibs, no point in redefining them
;Ingredient Property BlackGoo auto
;Ingredient Property AncientSeed auto
;MiscObject Property AbadonGem auto
;Armor Property AbadonPlug auto
;Armor Property AbadonPlugAnal auto

;soulgems too
;Soulgem Property EmptySoulgem_Petty auto
;Soulgem Property EmptySoulgem_Lesser auto
;Soulgem Property EmptySoulgem_Common auto
;Soulgem Property EmptySoulgem_Great  auto
;Soulgem Property EmptySoulgem_Grand  auto
;Soulgem Property FilledSoulgem_Petty auto
;Soulgem Property FilledSoulgem_Lesser auto
;Soulgem Property FilledSoulgem_Common auto
;Soulgem Property FilledSoulgem_Great  auto
;Soulgem Property FilledSoulgem_Grand  auto

;these are not defined in UDlibs
Ingredient Property ConcBlackGoo Auto
Ingredient Property PurifiedGoo Auto
Ingredient Property DragonNuts Auto
Ingredient Property CookedDragonNuts Auto
MiscObject Property AbadoniumIngot auto

bool BoostAlchemy
bool BoostEnchant

string MaterialHints

bool ResearchPaused = false

Event OnActivate(ObjectReference akActionRef)
    BoostAlchemy = StationAlchemy.IsEnabled()
    BoostEnchant = StationEnchant.IsEnabled()
    bool ResearchFound = true
    int ResearchCost
    int ItemsInChest
    int loc_i
    Form CurrentItem
    int CurrentItemNum
    int CheckResult

    MaterialHints = "\n No further ideas for now. Maybe later..."
    if ResearchPaused
        LastTimeActivated = Utility.GetCurrentGameTime()
        Debug.MessageBox("Looks like no research has been made due to the problems arisen!")
        return
    endif
    ResearchPoints = ResearchPoints + UD_Native.Round((Utility.GetCurrentGameTime() - LastTimeActivated) * ResearchPointsPerDay)
    LastTimeActivated = Utility.GetCurrentGameTime()

;now processing all ingredients, generic and custom
    ItemsInChest =  RChest.GetNumItems()
;check before even starting the cycle to save up some time
    if DeductRPandGold(AlchemyRPCost,AlchemyGoldCost, true, false, true)
        loc_i = 0
    else
        loc_i = ItemsInChest
    endif
    while loc_i < ItemsInChest
        CurrentItem = RChest.GetNthForm(loc_i)
        CurrentItemNum = RChest.GetItemCount(CurrentItem)
; checking for ingredients first
        CheckResult = CheckForUnknownEffects(CurrentItem)
        if CheckResult == -1
; it was ingredient with all known effects, continue
            loc_i += 1
        elseif CheckResult == -2
; processing non-ingredients, nothing to do here for now
            loc_i += 1
        else
; trying to open needed effect if we have enough research points and gold
            if DeductRPandGold(AlchemyRPCost,AlchemyGoldCost, true, false)
                RChest.RemoveItem(CurrentItem,1,true)
                ;ResearchFound = true
                ;ShowResearchResult("Discovered " + NthName(CheckResult) + " effect of " + CurrentItem.GetName())
                ;MagicEffect GetNthEffectMagicEffect(Int index)
                ShowResearchResult("Discovered " + NthName(CheckResult) + " effect of " + CurrentItem.GetName() + " to be " + EffectName(CurrentItem,CheckResult))
                LearnUnknownEffect(CurrentItem,CheckResult)
                if DeductRPandGold(AlchemyRPCost,AlchemyGoldCost, true, false, true) ; checking if there's any point in continuing
                    loc_i=0
                else
                    loc_i = ItemsInChest
                endif
            else
                loc_i = ItemsInChest ; shouldn't ever get to be triggered, just in case, I guess?
            endif
        endif
    endwhile

;main research checks
    while ResearchFound
        ResearchFound = false
        if !GRQ.GooRecipesBasic
            If CheckForAllEffects(UDlibs.BlackGoo) && CheckForAllEffects(ConcBlackGoo)
                If (RChest.GetItemCount(UDlibs.BlackGoo) > 9)
                    If (RChest.GetItemCount(ConcBlackGoo) > 2)
                        if DeductRPandGold(AlchemyRPCost * 3,AlchemyGoldCost * 3, true, false)
                            RChest.RemoveItem(UDlibs.BlackGoo,10,true)
                            RChest.RemoveItem(ConcBlackGoo,3,true)
                            ResearchFound = true
                            ;loc_i = 0
                            ShowResearchResult("Found a way to concentrate Black Goo into Concentrated Black Goo. Should be useful! \nWith this we now know all their basic abilities and can switch to much more advanced research into their effects.")
                            GRQ.GooRecipesBasic = true
                        else
                            MaterialHints = "\n Got to get more time to research and more gold..."
                        endif
                    Else
                        MaterialHints = "\n I feel like getting more Concentrated Black Goo would help me..."
                    EndIf
                Else
                    MaterialHints = "\n I feel like getting more Black Goo would help me..."
                EndIf
            Else
                ;loc_i += 1
            EndIf
        else
            if !GRQ.GooRecipesPurified
                If (RChest.GetItemCount(ConcBlackGoo) > 2)
                    if DeductRPandGold(AlchemyRPCost * 3,AlchemyGoldCost * 3, true, false)
                        RChest.RemoveItem(ConcBlackGoo,3,true)
                        ResearchFound = true
                        ;loc_i = 0
                        ShowResearchResult("By combining Concentrated Black Goo with salt, I managed to create new variety of goo, which I named Purified Black Goo. \n Time to make a lot of them to learn all their effects!")
                        GRQ.GooRecipesPurified = true
                    else
                        MaterialHints = "\n Got to get more time to research and more gold..."
                    endif
                Else
                    MaterialHints = "\n I feel like getting more Concentrated Black Goo would help me..."
                EndIf        
            elseif !GRQ.DragonNutsRecipes
                If CheckForAllEffects(DragonNuts)
                    If (RChest.GetItemCount(DragonNuts) > 0)
                        if DeductRPandGold(AlchemyRPCost * 3,AlchemyGoldCost * 3, true, false)
                            RChest.RemoveItem(DragonNuts,1,true)
                            ResearchFound = true
                            ;loc_i = 0
                            ShowResearchResult("These strange nuts can be seriously altered by boiling them in salty Nord Mead. \n Need to cook more of these to research their effects.")
                            GRQ.DragonNutsRecipes = true
                        else
                            MaterialHints = "\n Got to get more time to research and more gold..."
                        endif
                    Else
                        MaterialHints = "\n I need more of those nuts..."
                    EndIf        
                endif
            elseif !GRQ.GooRecipesAdvanced
                If (RChest.GetItemCount(UDlibs.BlackGoo) > 9)
                    If (RChest.GetItemCount(ConcBlackGoo) > 9)
                        if DeductRPandGold(AlchemyRPCost * 9,AlchemyGoldCost * 9, true, false)
                            RChest.RemoveItem(UDlibs.BlackGoo,10,true)
                            RChest.RemoveItem(ConcBlackGoo,10,true)
                            ResearchFound = true
                            ;loc_i = 0
                            ShowResearchResult("Managed to find a way to combine a lot of goo to form a nice gooey ball. \n Placing it into other's pockets would make the ball pop and unsuspecting victim will get all bound up!")
                            GRQ.GooRecipesAdvanced = true
                        else
                            MaterialHints = "\n Got to get more time to research and more gold..."
                        endif
                    Else
                        MaterialHints = "\n I feel like getting more Concentrated Black Goo would help me..."
                    EndIf
                Else
                    MaterialHints = "\n I feel like getting more Black Goo would help me..."
                EndIf
            elseif !GRQ.GooRecipesCursed
                If (RChest.GetItemCount(ConcBlackGoo) > 19)
                    if DeductRPandGold(AlchemyRPCost * 21,AlchemyGoldCost * 21, true, false)
                        RChest.RemoveItem(ConcBlackGoo,20,true)
                        ResearchFound = true
                        ;loc_i = 0
                        ShowResearchResult("I think I found a way to truly challenge any escape artist with this cursed goo I've created!")
                        GRQ.GooRecipesCursed = true
                    else
                        MaterialHints = "\n Got to get more time to research and more gold..."
                    endif
                Else
                    MaterialHints = "\n I feel like getting more Concentrated Black Goo would help me..."
                EndIf
            elseif !GRQ.ExecutionPotionRecipes
                If (RChest.GetItemCount(ConcBlackGoo) > 29)
                    if DeductRPandGold(AlchemyRPCost * 30,AlchemyGoldCost * 30, true, false)
                        RChest.RemoveItem(ConcBlackGoo,30,true)
                        ResearchFound = true
                        ;loc_i = 0
                        ShowResearchResult("This potion I developed is a true masterpiece! \n Even with help of others escaping restraints it creates should be near impossible!")
                        GRQ.ExecutionPotionRecipes = true
                    else
                        MaterialHints = "\n Got to get more time to research and more gold..."
                    endif
                Else
                    MaterialHints = "\n I feel like getting more Concentrated Black Goo would help me..."
                EndIf
            endif
;ingots etc        
            ;if !ResearchFound
                if !GRQ.AbadoniumRecipes
                    If (RChest.GetItemCount(AbadoniumIngot) > 0)
                        if DeductRPandGold(EnchantRPCost * 10,EnchantGoldCost * 10, false, true)
                            RChest.RemoveItem(AbadoniumIngot,1,true)
                            ResearchFound = true
                            ;loc_i = 0
                            ShowResearchResult("After studying this strange ingot I was able to figure a way to create more of those. It has huge potential without doubt!")
                            GRQ.AbadoniumRecipes = true
                        else
                            MaterialHints = "\n Got to get more time to research and more gold..."
                        endif
                    Else
                        MaterialHints = "\n I have a feeling that out there might be some unusual ingots. Partner has to do more adventuring it seems!"
                    EndIf
                elseif !GRQ.AbadonRingRecipes
                    If (RChest.GetItemCount(UDlibs.AbadonGem) > 0)
                        if DeductRPandGold(EnchantRPCost * 20,EnchantGoldCost * 20, false, true)
                            RChest.RemoveItem(UDlibs.AbadonGem,1,true)
                            ResearchFound = true
                            ;loc_i = 0
                            ShowResearchResult("This strange gem emits strong magical field. I've found a way to harness it by making a ring with it. This ring will absorb magical energy directed at wearer, but I suspect it will affect wearer's libido...")
                            GRQ.AbadonRingRecipes = true
                        else
                            MaterialHints = "\n Got to get more time to research and more gold..."
                        endif
                    Else
                        MaterialHints = "\n Got to make my partner to craft more of these plugs and wear them, these Abadon Gems certainly have huge potential!"
                    EndIf
                elseif !GRQ.ControllablePlugsRecipes
                    If (RChest.GetItemCount(UDlibs.AbadonGem) > 0)
                        if DeductRPandGold(EnchantRPCost * 10,EnchantGoldCost * 10, false, true)
                            RChest.RemoveItem(UDlibs.AbadonGem,1,true)
                            ResearchFound = true
                            ;loc_i = 0
                            ShowResearchResult("Gem affecting libido of wearer is no-brainer to be used in sex toys! And the perfect ones would be powerful controlled vibrating plugs, a dream came true for any slut! Still have more ideas for these gems, need more of them...")
                            GRQ.ControllablePlugsRecipes = true
                        else
                            MaterialHints = "\n Got to get more time to research and more gold..."
                        endif
                    Else
                        MaterialHints = "\n Got to make my partner to craft more of these plugs and wear them, these Abadon Gems certainly have huge potential!"
                    EndIf
                elseif !GRQ.AbadonWeaponsRecipes
                    If (RChest.GetItemCount(UDlibs.AbadonGem) > 0)
                        if DeductRPandGold(EnchantRPCost * 30,EnchantGoldCost * 30, false, true)
                            RChest.RemoveItem(UDlibs.AbadonGem,1,true)
                            ResearchFound = true
                            ;loc_i = 0
                            ShowResearchResult("Found yet another way to harness the gem's energy! When it's placed into weapon, energy will flow and use target's arousal to conjure restraints on them! Will not work on each strike, but still powerful effect!")
                            GRQ.AbadonWeaponsRecipes = true
                        else
                            MaterialHints = "\n Got to get more time to research and more gold..."
                        endif
                    Else
                        MaterialHints = "\n Got to make my partner to craft more of these plugs and wear them, these Abadon Gems certainly have huge potential!"
                    EndIf
                endif
            ;endif
            if GRQ.AbadoniumRecipes && !GRQ.ChargablePlugsRecipes        
                If (RChest.GetItemCount(UDlibs.EmptySoulgem_Grand) > 0)
                    If (RChest.GetItemCount(UDlibs.EmptySoulgem_Great) > 2)
                        if DeductRPandGold(EnchantRPCost * 50,EnchantGoldCost * 50, false, true)
                            RChest.RemoveItem(UDlibs.EmptySoulgem_Grand,1,true)
                            RChest.RemoveItem(UDlibs.EmptySoulgem_Great,3,true)
                            ResearchFound = true
                            ;loc_i = 0
                            ShowResearchResult("While fiddling with some big empty souldgems suddenly I've got idea and after quite some experimentation I've managed to develop recipes for chargable plugs. Wearer will fill the soulgems in them with her lust instead of some soul. Quite neat!")
                            GRQ.ChargablePlugsRecipes = true
                        else
                            MaterialHints = "\n Got to get more time to research and more gold..."
                        endif
                    Else
                        MaterialHints = "\n I think I have a neat idea! Just need some empty Great Soulgems..."
                    EndIf
                Else
                    MaterialHints = "\n I think I have a neat idea! Just need some empty Grand Soulgems..."
                EndIf
            endif
        endif
    endwhile

    Utility.Wait(0.5) ; to prevent final results box to pop over the research ones
    debug.MessageBox("Research time idle: " + UD_Native.Round(ResearchPoints / ResearchPointsPerDay) + " day(s).\n" + Advice() + "\n End of report.")
    ;StartTimer() ; better keep this commented out, too nasty not to allow to gather up some RPs...
EndEvent

Function StartTimer()
    LastTimeActivated = Utility.GetCurrentGameTime()
    ResearchPoints = 0
EndFunction

Function PauseTimer()
    ResearchPoints = ResearchPoints + UD_Native.Round((Utility.GetCurrentGameTime() - LastTimeActivated) * ResearchPointsPerDay)
    LastTimeActivated = Utility.GetCurrentGameTime()
    ResearchPaused = true
EndFunction

Function UnpauseTimer()
    LastTimeActivated = Utility.GetCurrentGameTime()
    ResearchPaused = false
EndFunction

; returns -1 if nothing to open or -2 if not ingredient, else returns first unknown effect number (0..3)
int Function CheckForUnknownEffects(Form afToCheck)
    Ingredient loc_ingr_to_check
    int loc_i
    if  afToCheck.haskeyword(IngredientKeyword)
        loc_ingr_to_check = afToCheck as Ingredient
        while loc_i < loc_ingr_to_check.GetNumEffects()
            if !loc_ingr_to_check.GetIsNthEffectKnown(loc_i)
                return loc_i
            endif
            loc_i += 1
        endwhile
        return -1 ; no unknown effects found on this ingredient
    else
        return -2 ; no inhgredient keyword on this, we assume it's not one
    endif
EndFunction

bool Function CheckForAllEffects(Ingredient afToCheck)
    int loc_i
    while loc_i < afToCheck.GetNumEffects()
            if !afToCheck.GetIsNthEffectKnown(loc_i)
                return false
            endif
            loc_i += 1
    endwhile
    return true ; no unknown effects found on this ingredient
EndFunction

int Function LearnUnknownEffect(Form afToLearn, int aiEffectNumber)
    Ingredient loc_ingr_to_learn
    loc_ingr_to_learn = afToLearn as Ingredient
    loc_ingr_to_learn.LearnEffect(aiEffectNumber)
EndFunction

string Function EffectName(Form afToLearn, int aiEffectNumber)
    Ingredient loc_ingr_to_learn
    loc_ingr_to_learn = afToLearn as Ingredient
    return loc_ingr_to_learn.GetNthEffectMagicEffect(aiEffectNumber).GetName()
EndFunction

;can both test for having enough gold and research points and actually deduct them depending on abTestOnly parameter, default is not testing
bool Function DeductRPandGold(int aiRP, int aiGold, bool abAlchemy, bool abEnchant, bool abTestOnly = false)
    if abAlchemy
        if BoostAlchemy
            aiRP = UD_Native.Round(aiRP / BoostAlchemyMultiplier)
            aiGold = UD_Native.Round(aiGold / BoostAlchemyMultiplier)
        EndIf
    endif
    if abEnchant
        If BoostEnchant
            aiRP = UD_Native.Round(aiRP / BoostEnchantMultiplier)
            aiGold = UD_Native.Round(aiGold / BoostEnchantMultiplier)
        EndIf
    endif
    if  ResearchPoints > aiRP
        if (RChest.GetItemCount(Gold) > aiGold)
            if !abTestOnly
                ResearchPoints = ResearchPoints - aiRP
                RChest.RemoveItem(Gold,aiGold,true)
            endif
            return true
        endif
    EndIf
    return false
EndFunction

string Function NthName(int aiNumber)
    if aiNumber == 0
        return " first "
    elseif aiNumber == 1
        return " second "
    elseif aiNumber == 2
        return " third "
    else 
        return " fourth "
    endif
EndFunction

Function ShowResearchResult(string asMessage)
    string loc_header
    loc_header = Utility.GameTimeToString((Utility.GetCurrentGameTime() - (ResearchPoints / ResearchPointsPerDay)))
    Debug.MessageBox("Date: " + loc_header + "\n Research report: \n " + asMessage + "\n Press OK to open next report page.")
EndFunction

; This should return some hints to player at the report's end about what materials they should bring to progress. Made this as function in case I want to expand this feature.
string Function Advice()
    return MaterialHints + "\n"
EndFunction