;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_TIF__0D1DC0A8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().RemoveItem(Gold,5000)
GetOwningQuest().SetStage(1000)
GetOwningQuest().SetObjectiveCompleted(40)
GetOwningQuest().SetObjectiveDisplayed(100)
EnStation.Enable()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property Gold  Auto  

ObjectReference Property EnStation  Auto  
