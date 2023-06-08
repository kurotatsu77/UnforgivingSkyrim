;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_TIF__0C180DD3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Player.GetRef().RemoveItem(Gold, 100)
Player.GetRef().AddItem(DDBook, 1)
GetOwningQuest().SetStage(2000)
GetOwningQuest().SetObjectiveCompleted(20)
GetOwningQuest().SetObjectiveDisplayed(30)
UragGRQ.Start()
UragGRQ.StartTimer()
Player.GetActorRef().EquipItem(BlackGoo)
GRQ.Masochism = GRQ.Masochism + 1
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property Player  Auto  

MiscObject Property Gold  Auto  

Book Property DDBook  Auto  

US_UragGRQ_Script Property UragGRQ  Auto  

US_GooResearch_Script Property GRQ  Auto  

Ingredient Property BlackGoo  Auto  
