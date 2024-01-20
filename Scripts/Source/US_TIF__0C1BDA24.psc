;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_TIF__0C1BDA24 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int loc_num = Player.GetActorRef().GetItemCount(AbadonGem)
UragGRQ.GiveReward((loc_num * 4), true)
Player.GetActorRef().RemoveItem(AbadonGem, loc_num)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property Player  Auto  

MiscObject Property AbadonGem  Auto  

US_UragGRQ_Script Property UragGRQ auto

