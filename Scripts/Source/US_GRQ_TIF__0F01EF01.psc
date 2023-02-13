;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_GRQ_TIF__0F01EF01 Extends TopicInfo Hidden

Ingredient Property ConcBlackGoo  Auto  
US_libs Property USlibs  Auto  
Scene Property HuldaScene Auto
Faction Property US_GRQFaction Auto
Package Property NodabaSandboxPackage Auto
Package Property NodabaSleepPackage Auto
Key Property HubKey Auto

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().EquipItem(ConcBlackGoo)
Utility.Wait(5)
USlibs.USWhip(Game.GetPlayer(),akSpeaker)
Utility.Wait(15)
HuldaScene.Start()
while HuldaScene.IsPlaying()
    Utility.Wait(1)
endwhile
;ActorUtil.AddPackageOverride(akSpeaker, NodabaSandboxPackage, 40)
;ActorUtil.AddPackageOverride(akSpeaker, NodabaSleepPackage, 30)
akSpeaker.addItem(HubKey,1)
Game.GetPlayer().addItem(HubKey,1)
akSpeaker.EvaluatePackage()
Utility.Wait(5)
GetOwningQuest().SetObjectiveCompleted(20)
GetOwningQuest().SetObjectiveDisplayed(20,0)
GetOwningQuest().SetObjectiveDisplayed(30,1)
GetOwningQuest().SetStage(30)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
