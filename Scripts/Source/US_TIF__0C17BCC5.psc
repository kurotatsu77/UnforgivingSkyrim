;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_TIF__0C17BCC5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Player.GetReference().RemoveItem(DDBook, 1)
Nodaba.GetReference().AddItem(DDBook, 1)
int loc_relation = akSpeaker.GetRelationshipRank(Player.GetActorRef())
if loc_relation < 4
    akSpeaker.SetRelationshipRank(Player.GetActorRef(), loc_relation + 1)
endif
;improve research speed by 50%
RLog.ResearchPointsPerDay = Math.floor((RLog.ResearchPointsPerDay * 1.5) + 0.5)
GetOwningQuest().SetObjectiveCompleted(40)
GetOwningQuest().SetStage(3100)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Book Property DDBook  Auto  

ReferenceAlias Property Player  Auto  

ReferenceAlias Property Nodaba  Auto  

US_GRQ_RLogScript Property RLog auto
