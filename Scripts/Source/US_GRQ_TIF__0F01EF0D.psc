;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_GRQ_TIF__0F01EF0D Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().RemoveItem(Gold,2000)
GetOwningQuest().SetObjectiveCompleted(40)
GetOwningQuest().SetObjectiveDisplayed(40,0)
GetOwningQuest().SetObjectiveDisplayed(50,1)
GetOwningQuest().SetStage(50)
RLog.Enable()
RLog.StartTimer()
;force TP Nodaba to the hub, eat this, you damn navmesh!
US_GooResearch_Script OQ = GetOwningQuest() as US_GooResearch_Script
Actor akNodaba = OQ.Nodaba.GetActorRef()
akNodaba.Moveto(RLog)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property Gold  Auto  
US_GRQ_RLogScript Property RLog Auto
