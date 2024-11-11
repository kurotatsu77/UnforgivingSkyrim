Scriptname US_GRQ_Alchemy_Quest_script extends Quest  

UnforgivingDevicesMain Property UDmain auto
US_libs Property USlibs auto
;Ingredient Property BlackGoo auto
;US_GooResearch_Script Property GRQ auto
;ObjectReference Property AlStation auto
;MiscObject Property Gold  Auto  
Spell Property MasoSpell auto
Topic Property Reward auto
Package Property RewardFG auto

Function LezSexReward(actor akSpeaker, int aiFameChange = 1)
    LezSex(akSpeaker, aiFameChange)
    ;akSpeaker.Say(Reward)
    ActorUtil.AddPackageOverride(akSpeaker,RewardFG,99)
    akSpeaker.EvaluatePackage()
EndFunction

Function LezWhipReward(actor akSpeaker, int aiFameChange = 1)
    LezWhip(akSpeaker, aiFameChange)
    ;akSpeaker.Say(Reward)
    ActorUtil.AddPackageOverride(akSpeaker,RewardFG,99)
    akSpeaker.EvaluatePackage()
EndFunction

Function LezWhip(actor akSpeaker, int aiFameChange = 1)
    USlibs.USWhip(Game.GetPlayer(), akSpeaker)
    LezSex(akSpeaker, aiFameChange)
EndFunction

Function LezSex(actor akSpeaker, int aiFameChange = 1)
    Actor akPlayer = Game.GetPlayer()
    USlibs.DHLPSuspend() 
    Utility.Wait(3)
    USlibs.UDCDmain.DisableActor(akPlayer)
    Game.SetPlayerAIDriven(true)
    Actor[] loc_SLActors = new Actor[2]
    sslBaseAnimation[] loc_SLAnim    
    loc_SLActors[0] = akPlayer
    loc_SLActors[1] = akSpeaker
 
    If UDmain.libs.SexLab.GetStringVer() == "2.0 P+"
        ;StartScene variant, should be faster and more recent. StartSex is declared as deprecated in P+
        if !UDmain.libs.SexLab.StartScene(akPositions = loc_SLActors, asTags = "Lesbian, Aggressive", akSubmissive = akPlayer)
            UDmain.libs.SexLab.StartScene(akPositions = loc_SLActors, asTags = "Lesbian", akSubmissive = akPlayer)
        endif
    Else ;for OG SL compatibility
        loc_SLAnim = UDmain.libs.SelectValidDDAnimations(loc_SLActors, 2, true, "Lesbian")
        ; fallback to consensual lesbian if nothing found
        If loc_SLAnim.Length == 0
            loc_SLAnim = UDmain.libs.SelectValidDDAnimations(loc_SLActors, 2, false, "Lesbian")
        EndIf
    
        If loc_SLAnim.Length > 0
            UDmain.libs.SexLab.StartSex(Positions = loc_SLActors, Anims = loc_SLAnim, Victim = akPlayer)
        endif
    Endif

    while UDmain.libs.IsAnimating(akPlayer)
        Utility.Wait(1)
    endwhile

    USlibs.UDCDmain.EnableActor(akPlayer)
    Game.SetPlayerAIDriven(false)
    USlibs.DHLPResume()

    int loc_relation = akSpeaker.GetRelationshipRank(akPlayer)
    if loc_relation < 4
        akSpeaker.SetRelationshipRank(akPlayer, loc_relation + 1)
    endif

    MasoSpell.Cast(akPlayer)
    UDmain.Print("You feel strangely invigorated by this encounter!")

    USlibs.IncreaseSLFame(aiMasochist = aiFameChange, aiSlave = aiFameChange, aiSlut = aiFameChange, aiWhore = aiFameChange)
EndFunction