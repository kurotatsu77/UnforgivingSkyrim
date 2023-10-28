Scriptname US_UragGRQ_Script extends Quest Conditional
{This script contains all variables to control Urag's knowledge of the recipes.}

US_libs Property USlibs auto
US_GooResearch_Script Property GRQ  Auto  
US_GRQ_Enchanting_Quest_script Property GRQE auto
US_MCM Property USMCM  Auto  
Spell Property MasoSpell auto
ReferenceAlias Property Player  Auto
ReferenceAlias Property Urag  Auto
MiscObject Property Gold auto
Ingredient Property BlackGoo auto
Ingredient Property ConcBlackGoo auto
Ingredient Property PureBlackGoo auto
Potion Property CursedGoo auto
Potion Property ExecutionPotion auto
Scene Property UragScene auto
Package Property UragPackage auto

LeveledItem[] Property LLDagger auto
LeveledItem[] Property LLSword auto
LeveledItem[] Property LLGreatsword auto
LeveledItem[] Property LLBow auto

Weapon Property AbadonDagger auto
Weapon Property AbadonSword auto
Weapon Property AbadonGreatsword auto
Weapon Property AbadonBow auto

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
; 8 - Bound Cunt Outfit

int Property WeightBlackGoo		= 100 	auto
int Property WeightConcGoo		= 50 	auto
int Property WeightPureGoo 		= 50 	auto
int Property WeightCursedGoo 	= 20 	auto
int Property WeightExecutionGoo = 10 	auto
int Property WeightPlug 		= 30 	auto
int Property WeightShout 		= 50 	auto
int Property WeightBoundCunt 	= 40 	auto

; rewards multipliers list
float Property BlackGooReward       = 1.0   auto
float Property ConcBlackGooReward   = 2.0   auto
float Property PureBlackGooReward   = 2.0   auto
float Property CursedGooReward      = 5.0   auto
float Property ExecutionGooReward   = 10.0  auto
float Property PlugReward           = 3.0   auto
float Property ShoutReward          = 2.0   auto
float Property BCReward          = 2.0   auto

;rework and change names?
bool Property ConcGoo                   = false auto conditional    ; shown Concentrated Black Goo
bool Property AncientSeed               = false auto conditional    ; shown Ancient Seed
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
bool Property BoundCunt               = false auto conditional    ; demonstrated Bound Cunt items

; Gives to player reward, afReward is multiplier to be applied to BaseReward, if abMakeProfit set - adds same amount of gold to available reward instead of deducting it
Function GiveReward(float afReward, bool abMakeProfit = false)
    int loc_gold
    loc_gold = Round((BaseReward * afReward))
    Player.GetActorRef().AddItem(Gold, loc_gold)
    ;Urag already makes serious gold, so no need to buff him with sold materials, lets drain him instead
    ;if abMakeProfit
    ;    GoldAvailable = GoldAvailable + loc_gold
    ;else
        GoldAvailable = GoldAvailable - loc_gold
    ;endif
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
    if BoundCunt
        GoldAvailable = GoldAvailable + Round(GoldPerDay * BCReward* loc_DaysPassed)
    endif
    LastTimeActivated = Utility.GetCurrentGameTime()
EndFunction

; Chooses which research Urag wants to perform, based on what is known and how much gold gathered
Function ChooseResearch()
    if ((Utility.GetCurrentGameTime() - LastTimeActivated) > 0.5) || (ChosenResearch == 0) ; if already chosen research - change it once per 12 hours
        CalculateIncome()
        ChosenResearch = 0
        int[] loc_researches = new int [8]
        int[] loc_weights = new int [8]
        int loc_total = 0
        int loc_total_weights = 0
        if GoldAvailable > Round(BaseReward * BlackGooReward)
            loc_researches[loc_total] = 1
            loc_weights[loc_total] = WeightBlackGoo
            loc_total_weights += WeightBlackGoo
            loc_total += 1
        endif
        if ConcGoo && (GoldAvailable > Round(BaseReward * ConcBlackGooReward))
            loc_researches[loc_total] = 2
            loc_weights[loc_total] = WeightConcGoo
            loc_total_weights += WeightConcGoo
            loc_total += 1
        endif
        if GooRecipesPurified && (GoldAvailable > Round(BaseReward * PureBlackGooReward))
            loc_researches[loc_total] = 3
            loc_weights[loc_total] = WeightPureGoo
            loc_total_weights += WeightPureGoo
            loc_total += 1
        endif
        if GooRecipesCursed && (GoldAvailable > Round(BaseReward * CursedGooReward))
            loc_researches[loc_total] = 4
            loc_weights[loc_total] = WeightCursedGoo
            loc_total_weights += WeightCursedGoo
            loc_total += 1
        endif
        if ExecutionPotionRecipes && (GoldAvailable > Round(BaseReward * ExecutionGooReward))
            loc_researches[loc_total] = 5
            loc_weights[loc_total] = WeightExecutionGoo
            loc_total_weights += WeightExecutionGoo
            loc_total += 1
        endif
        if AbadonPlug && (GoldAvailable > Round(BaseReward * PlugReward))
            loc_researches[loc_total] = 6
            loc_weights[loc_total] = WeightPlug
            loc_total_weights += WeightPlug
            loc_total += 1
        endif
        if AbadonShout && (GoldAvailable > Round(BaseReward * ShoutReward))
            loc_researches[loc_total] = 7
            loc_weights[loc_total] = WeightShout
            loc_total_weights += WeightShout
            loc_total += 1
        endif
        if BoundCunt && (GoldAvailable > Round(BaseReward * BCReward))
            loc_researches[loc_total] = 8
            loc_weights[loc_total] = WeightBoundCunt
            loc_total_weights += WeightBoundCunt
            loc_total += 1
        endif
        if loc_total > 0 && loc_total_weights > 0
            int loc_random
            loc_random = Utility.RandomInt(1, loc_total_weights)
            int loc_temp = 0
            int loc_i = 0
            while loc_i < loc_total
                ChosenResearch = loc_researches[loc_i]
                loc_temp += loc_weights[loc_i]
                if loc_random > loc_temp
                    loc_i += 1
                else
                    loc_i = loc_total
                endif
            endwhile
        endif
    endif
EndFunction

; used to fire off timer when quest starts
Function StartTimer()
    LastTimeActivated = Utility.GetCurrentGameTime()
    ;BaseReward = USMCM.UragBaseReward
    ;GoldAvailable = 500
EndFunction

int Function Round(float afValue)
    return Math.floor(afValue + 0.5)
EndFunction

;performs sexscene between player and Urag with tag defined by asTag
Function StartSex(string asTag="MF")
    USlibs.DHLPSuspend() 
    ;Utility.Wait(3)
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
    ; fallback to consensual if nothing found
    If loc_SLAnim.Length == 0
        loc_SLAnim = USlibs.UDmain.libs.SelectValidDDAnimations(loc_SLActors, 2, false, asTag)
    EndIf

    If loc_SLAnim.Length > 0
        USlibs.UDmain.libs.SexLab.StartSex(Positions = loc_SLActors, Anims = loc_SLAnim, Victim = Player.GetActorRef())
        MasoSpell.Cast(Player.GetActorRef())
        USlibs.UDmain.Print("You feel strangely invigorated by this encounter!")
    endif

    while USlibs.UDmain.libs.IsAnimating(Player.GetActorRef())
        Utility.Wait(1)
    endwhile

    USlibs.UDCDmain.EnableActor(Player.GetActorRef())
    Game.SetPlayerAIDriven(false)
    USlibs.DHLPResume()
EndFunction

bool Function Strip(Keyword akKeyword)
    Actor loc_PlayerRef = Player.GetActorRef()
    if !loc_PlayerRef.wornhaskeyword(akKeyword)
        return true
    else
        Armor loc_device = USlibs.libs.getWornDevice(loc_PlayerRef, akKeyword) 
        string loc_device_name = loc_device.GetName()
        bool loc_DeviceWasStripped = false
        if USlibs.libs.UnlockDevice(loc_PlayerRef, deviceInventory = loc_device, zad_DeviousDevice = akKeyword, destroydevice = true, genericonly = true)
            loc_DeviceWasStripped = true
        endif
        Utility.Wait(1) ; giving time to strip
        ; if after stripping belt still some belt detected - it's harness, they are not stripped by belt keywords! DD bug?
        if !loc_DeviceWasStripped && akKeyword == USlibs.libs.zad_DeviousBelt && loc_PlayerRef.wornhaskeyword(USlibs.libs.zad_DeviousHarness) && loc_PlayerRef.wornhaskeyword(USlibs.libs.zad_DeviousBelt)
            loc_device = USlibs.libs.getWornDevice(loc_PlayerRef,USlibs.libs.zad_DeviousHarness) 
            if USlibs.libs.UnlockDevice(loc_PlayerRef, deviceInventory = loc_device, zad_DeviousDevice = USlibs.libs.zad_DeviousHarness, destroydevice = true, genericonly = true)
                loc_DeviceWasStripped = true
                loc_device_name = loc_device.GetName()
            endif
        endif
        ;same thing with gags and hoods
        if !loc_DeviceWasStripped && akKeyword == USlibs.libs.zad_DeviousGag && loc_PlayerRef.wornhaskeyword(USlibs.libs.zad_DeviousHood) && loc_PlayerRef.wornhaskeyword(USlibs.libs.zad_DeviousGag)
            loc_device = USlibs.libs.getWornDevice(loc_PlayerRef,USlibs.libs.zad_DeviousHood) 
            if USlibs.libs.UnlockDevice(loc_PlayerRef, deviceInventory = loc_device, zad_DeviousDevice = USlibs.libs.zad_DeviousHood, destroydevice = true, genericonly = true)
                loc_DeviceWasStripped = true
                loc_device_name = loc_device.GetName()
            endif
        endif
        if loc_DeviceWasStripped
            USlibs.UDmain.Print("Urag uses his key to unlock " + loc_device_name)
        endif   
        return loc_DeviceWasStripped
    endif
EndFunction

; makes Urag to whip player
Function Whip()
    USlibs.DHLPSuspend() 
    ;Utility.Wait(3)
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
    Actor loc_PlayerRef = Player.GetActorRef()
    if ChosenResearch == 0
        return
    elseif ChosenResearch == 1
        ;USlibs.UDmain.Print("Doing Black Goo action.")
        Player.GetActorRef().AddItem(BlackGoo, 1, true)
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
        ;USlibs.UDmain.Print("Doing Concentrated Black Goo action.")
        Player.GetActorRef().AddItem(ConcBlackGoo, 1, true)
        Player.GetActorRef().EquipItem(ConcBlackGoo)
        Utility.Wait(3)
        Whip()
        GiveReward(ConcBlackGooReward)
        if loc_relation < 2
            Urag.GetActorRef().SetRelationshipRank(Player.GetActorRef(), loc_relation + 1)
        endif
        GRQ.Masochism = GRQ.Masochism + 3
        ChosenResearch = 0
    elseif ChosenResearch == 3
        ;USlibs.UDmain.Print("Doing Purified Black Goo action.")
        USlibs.libs.strip(loc_PlayerRef, false)
        
        ; add here package for Urag to follow player
        ActorUtil.AddPackageOverride(Urag.GetActorRef(),UragPackage,99)
        Urag.GetActorRef().EvaluatePackage()

        Player.GetActorRef().AddItem(PureBlackGoo, 1, true)
        Player.GetActorRef().EquipItem(PureBlackGoo)
        ;Giving Urag keys if he don't have them
        int loc_keysnum
        bool loc_stripgag
        bool loc_stripbelt
        bool loc_stripplug
        loc_keysnum = Urag.GetActorRef().GetItemCount(USlibs.libs.restraintsKey)
        if loc_keysnum == 0
            Urag.GetActorRef().AddItem(USlibs.libs.restraintsKey, 1)
        endif
        loc_keysnum = Urag.GetActorRef().GetItemCount(USlibs.libs.chastityKey)
        if loc_keysnum == 0
            Urag.GetActorRef().AddItem(USlibs.libs.chastityKey, 1)
        endif
        loc_keysnum = Urag.GetActorRef().GetItemCount(USlibs.libs.piercingKey)
        if loc_keysnum == 0
            Urag.GetActorRef().AddItem(USlibs.libs.piercingKey, 1)
        endif
        Utility.Wait(10) ; Maybe tweak this more to ensure player all bound up before action. Maybe search for something better?
        loc_stripgag = Strip(USlibs.libs.zad_DeviousGag)    
        if loc_stripgag
            StartSex("Blowjob")
        endif
        ;Utility.Wait(1)
        ;while USlibs.libs.IsAnimating(loc_PlayerRef)
        ;    Utility.Wait(1)
        ;endwhile
        loc_stripbelt = Strip(USlibs.libs.zad_DeviousBelt)    
        if loc_stripbelt   
            loc_stripplug = Strip(USlibs.libs.zad_DeviousPlugVaginal)    
            if loc_stripplug
                StartSex("Vaginal")
            endif
        endif
        ;Utility.Wait(1)
        ;while USlibs.libs.IsAnimating(loc_PlayerRef)
        ;    Utility.Wait(1)
        ;endwhile
        loc_stripbelt = Strip(USlibs.libs.zad_DeviousBelt)    
        if loc_stripbelt
            loc_stripplug = Strip(USlibs.libs.zad_DeviousPlugAnal)    
            if loc_stripplug
                StartSex("Anal")
            endif
        endif
        Utility.Wait(1)
        ;while USlibs.libs.IsAnimating(loc_PlayerRef)
        ;    Utility.Wait(1)
        ;endwhile
        
        ; remove Urag's package here
        ActorUtil.ClearPackageOverride(Urag.GetActorRef())
        Urag.GetActorRef().EvaluatePackage()

        GiveReward(PureBlackGooReward)
        if loc_relation < 2
            Urag.GetActorRef().SetRelationshipRank(Player.GetActorRef(), loc_relation + 1)
        endif
        GRQ.Masochism = GRQ.Masochism + 3
        ChosenResearch = 0
    elseif ChosenResearch == 4
        ;USlibs.UDmain.Print("Doing Cursed Goo action.")
        
        ; add here package for Urag to follow player
        ActorUtil.AddPackageOverride(Urag.GetActorRef(),UragPackage,99)
        Urag.GetActorRef().EvaluatePackage()
        
        Player.GetActorRef().AddItem(CursedGoo, 1, true)
        Player.GetActorRef().EquipItem(CursedGoo)
        Utility.Wait(3)

        int loc_i = 3

        while loc_i > 0 && !Player.GetActorRef().WornHasKeyword(USlibs.libs.zad_DeviousGag)
            StartSex("Blowjob")
            loc_i -= 1
        endwhile

        StartSex("Spank")

        Whip()

        ; remove Urag's package here
        ActorUtil.ClearPackageOverride(Urag.GetActorRef())
        Urag.GetActorRef().EvaluatePackage()

        if loc_relation < 3
            Urag.GetActorRef().SetRelationshipRank(Player.GetActorRef(), loc_relation + 1)
        endif
        GiveReward(CursedGooReward)
        GRQ.Masochism = GRQ.Masochism + 5
        ChosenResearch = 0
    elseif ChosenResearch == 5
        ;USlibs.UDmain.Print("Doing Abadon Execution action.")
        Player.GetActorRef().AddItem(ExecutionPotion, 1, true)
        Player.GetActorRef().EquipItem(ExecutionPotion)
        Utility.Wait(10)

        UragScene.Start()
                
        if loc_relation < 4
            Urag.GetActorRef().SetRelationshipRank(Player.GetActorRef(), loc_relation + 1)
        endif
        GiveReward(ExecutionGooReward)
        GRQ.Masochism = GRQ.Masochism + 10
        ChosenResearch = 0
    elseif ChosenResearch == 6
        ;USlibs.UDmain.Print("Doing Abadon Plug action.")
        Player.GetActorRef().AddItem(USlibs.UDlibs.AbadonPlug, 1)
        USlibs.libs.LockDevice(Player.GetActorRef(), USlibs.UDlibs.AbadonPlug)
        Utility.Wait(3)
        Whip()
        GiveReward(PlugReward)
        if loc_relation < 2
            Urag.GetActorRef().SetRelationshipRank(Player.GetActorRef(), loc_relation + 1)
        endif
        GRQ.Masochism = GRQ.Masochism + 3
        ChosenResearch = 0
    elseif ChosenResearch == 7
        USlibs.UDmain.Print("Hit Urag with your Abadon Shout.")
        ;ChosenResearch = 0
    elseif ChosenResearch == 8
        ;USlibs.UDmain.Print("Doing Bondage Cunt action.")
        ;add Bound Cunt outfit here
        GRQE.LockBoundCuntCollar(Urag.GetActorRef())
        GRQE.LockBoundCuntOutfit(Urag.GetActorRef())
        Utility.Wait(3)
        ;Whip()
        StartSex("Vaginal")
        Utility.Wait(1)
        StartSex("Anal")
        Utility.Wait(1)
        GiveReward(BCReward)
        if loc_relation < 3
            Urag.GetActorRef().SetRelationshipRank(Player.GetActorRef(), loc_relation + 1)
        endif
        GRQ.Masochism = GRQ.Masochism + 3
        ChosenResearch = 0
    else
        ChosenResearch = 0
    endif
EndFunction

Function ProcessShout(int aiShoutLevel)
    if ChosenResearch == 7
        int loc_relation = Urag.GetActorRef().GetRelationshipRank(Player.GetActorRef())    
        if aiShoutLevel == 1
            ;USlibs.UDmain.Print("Urag was hit with one-word Abadon Shout.")
            GiveReward(ShoutReward / 3)
            GRQ.Masochism = GRQ.Masochism + 1
        elseif aiShoutLevel == 2
            ;USlibs.UDmain.Print("Urag was hit with two-word Abadon Shout.")
            GiveReward((ShoutReward * 2) / 3)
            GRQ.Masochism = GRQ.Masochism + 2
        elseif aiShoutLevel == 3
            ;USlibs.UDmain.Print("Urag was hit with three-word Abadon Shout.")
            GiveReward(ShoutReward)
            GRQ.Masochism = GRQ.Masochism + 3
        endif
        if loc_relation < 2
            Urag.GetActorRef().SetRelationshipRank(Player.GetActorRef(), loc_relation + 1)
        endif
        ChosenResearch = 0
    endif
EndFunction

Bool Function LeveledItemContains(LeveledItem list, Form target)
	Int size = list.GetNumForms()
	Int i = 0
	While i < size
	  If list.GetNthForm(i) == target
		Return True
	  EndIf
	  i += 1
	EndWhile
	Return False
EndFunction

Function PatchLL(LeveledItem alLL, Form afItem)
    if !LeveledItemContains(alLL, afItem)
        alLL.AddForm(afItem, 1, 1)
        USlibs.UDmain.CLog("Adding form " + afItem + " into LL " + alLL)
    endif
EndFunction

Function PatchLLL(LeveledItem[] alLLL, Form afItem)
    int loc_i
    loc_i = alLLL.Length
    while loc_i > 0
        PatchLL(alLLL[loc_i - 1], afItem)
        loc_i -= 1
    endwhile
EndFunction

; Injects abadon weapons into leveled lists to be used by NPCs
Function AddAbadonWeaponsToLL()
    Form loc_weapon
    loc_weapon = AbadonDagger as Form
    PatchLLL(LLDagger,loc_weapon)
    loc_weapon = AbadonSword as Form
    PatchLLL(LLSword,loc_weapon)
    loc_weapon = AbadonGreatsword as Form
    PatchLLL(LLGreatsword,loc_weapon)
    loc_weapon = AbadonBow as Form
    PatchLLL(LLBow,loc_weapon)
EndFunction

