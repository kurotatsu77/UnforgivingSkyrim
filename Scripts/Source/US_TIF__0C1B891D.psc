;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_TIF__0C1B891D Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
UragGRQ.GiveReward(UragGRQ.ConcBlackGooReward * 4)
UragGRQ.DragonNutsRecipes = true
Player.GetActorRef().RemoveItem(DragonNuts, 1)
Player.GetActorRef().RemoveItem(CookedNuts, 1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

US_UragGRQ_Script Property UragGRQ auto


ReferenceAlias Property Player  Auto  

Ingredient Property DragonNuts  Auto  

Ingredient Property CookedNuts  Auto  
