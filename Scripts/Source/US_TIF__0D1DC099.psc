;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_TIF__0D1DC099 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetStage(300)
GetOwningQuest().SetObjectiveCompleted(30)
GetOwningQuest().SetObjectiveDisplayed(40,0)
GetOwningQuest().SetObjectiveDisplayed(50)

int loc_relation = akSpeaker.GetRelationshipRank(Game.GetPlayer())
if loc_relation < 3
    akSpeaker.SetRelationshipRank(Game.GetPlayer(), loc_relation + 1)
endif
GRQ.Masochism = GRQ.Masochism + 3
USlibs.IncreaseSLFame(aiMasochist = 3, aiSlave = 3, aiSlut = 3, aiWhore = 3)

;eat the goo here and move stages
GooScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property GooScene  Auto  

US_GooResearch_Script Property GRQ auto

US_libs Property USlibs auto