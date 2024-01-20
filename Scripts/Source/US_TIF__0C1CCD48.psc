;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_TIF__0C1CCD48 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
UragGRQ.GiveReward(UragGRQ.PlugReward)
int loc_num = UragGRQ.Player.GetActorRef().GetItemCount(PlugVag)
if loc_num > 0
    UragGRQ.Player.GetActorRef().RemoveItem(PlugVag, 1)
else
    UragGRQ.Player.GetActorRef().RemoveItem(PlugAnal, 1)
endif
UragGRQ.ControllablePlugsRecipes = true
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

US_UragGRQ_Script Property UragGRQ auto

US_GooResearch_Script Property GRQ  Auto  

Armor Property PlugVag  Auto  

Armor Property PlugAnal  Auto  
