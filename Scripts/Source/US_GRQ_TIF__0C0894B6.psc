;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_GRQ_TIF__0C0894B6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetStage(3100)
GetOwningQuest().SetObjectiveCompleted(30)
GetOwningQuest().CompleteQuest()
int loc_relation = akSpeaker.GetRelationshipRank(Game.GetPlayer())
if loc_relation < 4
    akSpeaker.SetRelationshipRank(Game.GetPlayer(), loc_relation + 1)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
