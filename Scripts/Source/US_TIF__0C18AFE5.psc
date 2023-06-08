;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_TIF__0C18AFE5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
UragGRQ.GiveReward(UragGRQ.ConcBlackGooReward)
UragGRQ.Player.GetActorRef().EquipItem(ConcBlackGoo)
UragGRQ.ConcGoo = true
GRQ.Masochism = GRQ.Masochism + 1
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

US_UragGRQ_Script Property UragGRQ auto

US_GooResearch_Script Property GRQ  Auto  

Ingredient Property ConcBlackGoo  Auto  
