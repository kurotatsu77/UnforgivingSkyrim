;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_TIF__0C18AFE2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
UragGRQ.GiveReward(UragGRQ.ConcBlackGooReward / 2)
UragGRQ.Player.GetActorRef().RemoveItem(ConBlackGoo, 1)
UragGRQ.ConcGoo = true
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

US_UragGRQ_Script Property UragGRQ auto

Ingredient Property ConBlackGoo  Auto  
