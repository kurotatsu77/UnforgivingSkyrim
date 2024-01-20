;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_TIF__0C180DD5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Player.GetActorRef().EquipItem(BlackGoo)

;improve standing up to 1
int loc_relation = akSpeaker.GetRelationshipRank(Player.GetActorRef())
if loc_relation < 1
    akSpeaker.SetRelationshipRank(Player.GetActorRef(), loc_relation + 1)
endif

;sexlab call
USlibs.DHLPSuspend() 
Utility.Wait(3)
USlibs.UDCDmain.DisableActor(Player.GetActorRef())
Game.SetPlayerAIDriven(true)

;USlibs.USWhip(Player.GetActorRef(), akSpeaker)

Actor[] loc_SLActors = new Actor[2]
sslBaseAnimation[] loc_SLAnim    
loc_SLActors[0] = Player.GetActorRef()
loc_SLActors[1] = akSpeaker

; A bit of randomness for the sake of variety
if Utility.randomInt(1,2) == 1
    loc_SLAnim = UDmain.libs.SexLab.GetAnimationsByTag(2, "Aggressive", "MF", RequireAll=true)
else
    loc_SLAnim = UDmain.libs.SelectValidDDAnimations(loc_SLActors, 2, true, "MF")
endif
; fallback to consensual MF if nothing found
If loc_SLAnim.Length == 0
    loc_SLAnim = UDmain.libs.SelectValidDDAnimations(loc_SLActors, 2, false, "MF")
EndIf

If loc_SLAnim.Length > 0
    UDmain.libs.SexLab.StartSex(Positions = loc_SLActors, Anims = loc_SLAnim, Victim = Player.GetActorRef())
endif

while UDmain.libs.IsAnimating(Player.GetActorRef())
    Utility.Wait(1)
endwhile

USlibs.UDCDmain.EnableActor(Player.GetActorRef())
Game.SetPlayerAIDriven(false)
USlibs.DHLPResume()

MasoSpell.Cast(Player.GetActorRef())
UDmain.Print("You feel strangely invigorated by this encounter!")

;trap disable
DDBookCase.TrapOn = false
Player.GetRef().AddItem(DDBookCaseKey, 1)

GetOwningQuest().SetStage(3000)
GetOwningQuest().SetObjectiveCompleted(20)
GetOwningQuest().SetObjectiveDisplayed(40)
UragGRQ.Start()
UragGRQ.StartTimer()

GRQ.Masochism = GRQ.Masochism + 2
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property Player  Auto  

ReferenceAlias Property Urag  Auto  

Ingredient Property BlackGoo  Auto  

US_DDBookCase_Script Property DDBookCase auto

US_libs Property USlibs auto

UnforgivingDevicesMain Property UDmain auto

Spell Property MasoSpell auto
US_UragGRQ_Script Property UragGRQ  Auto  

US_GooResearch_Script Property GRQ  Auto  

Key Property DDBookCaseKey auto
