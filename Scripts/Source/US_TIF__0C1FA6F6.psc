;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_TIF__0C1FA6F6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
US_UragGRQ_Script UragGRQ
UragGRQ = GetOwningQuest() as US_UragGRQ_Script
UragGRQ.GiveReward(UragGRQ.BCReward)
UragGRQ.BoundCunt = true
UragGRQ.ChosenResearch = 8
UragGRQ.DoResearch()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
