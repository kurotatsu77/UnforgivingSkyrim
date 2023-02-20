;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_GRQ_TIF__0F01EF01 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().EquipItem(ConcBlackGoo)
Utility.Wait(5)
USlibs.USWhip(Game.GetPlayer(),akSpeaker)
;Utility.Wait(15)
USlibs.UDCDmain.DisableActor(Game.GetPlayer())
Utility.Wait(1)
USlibs.UDCDmain.EnableActor(Game.GetPlayer())
Utility.Wait(1)
HuldaScene.Start()
while HuldaScene.IsPlaying()
    Utility.Wait(1)
endwhile
;ActorUtil.AddPackageOverride(akSpeaker, NodabaSandboxPackage, 40)
;ActorUtil.AddPackageOverride(akSpeaker, NodabaSleepPackage, 30)
ActorUtil.AddPackageOverride(akSpeaker, NodabaHubTravelPackage, 99)
akSpeaker.addItem(HubKey,1)
Game.GetPlayer().addItem(HubKey,1)
Game.GetPlayer().AddToFaction(US_GRQFaction)
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

Ingredient Property ConcBlackGoo  Auto  
US_libs Property USlibs  Auto  
Scene Property HuldaScene Auto
Faction Property US_GRQFaction Auto
Package Property NodabaSandboxPackage Auto
Package Property NodabaSleepPackage Auto
Package Property NodabaHubTravelPackage  Auto  
Key Property HubKey Auto
