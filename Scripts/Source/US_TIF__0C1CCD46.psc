;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_TIF__0C1CCD46 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
UragGRQ.GiveReward(UragGRQ.PlugReward)
int loc_num = UragGRQ.Player.GetActorRef().GetItemCount(PlugVagGreat)
if loc_num > 0
    UragGRQ.Player.GetActorRef().RemoveItem(PlugVagGreat, 1)
else
    loc_num = UragGRQ.Player.GetActorRef().GetItemCount(PlugAnalGreat)
    if loc_num > 0
        UragGRQ.Player.GetActorRef().RemoveItem(PlugAnalGreat, 1)
    else
        loc_num = UragGRQ.Player.GetActorRef().GetItemCount(PlugVagGrand)
        if loc_num > 0
            UragGRQ.Player.GetActorRef().RemoveItem(PlugVagGrand, 1)
        else
            UragGRQ.Player.GetActorRef().RemoveItem(PlugAnalGrand, 1)
        endif
    endif
endif
UragGRQ.ChargablePlugsRecipes = true
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

US_UragGRQ_Script Property UragGRQ auto

US_GooResearch_Script Property GRQ  Auto  

Armor Property PlugVagGrand  Auto  

Armor Property PlugAnalGrand  Auto  

Armor Property PlugVagGreat  Auto  

Armor Property PlugAnalGreat  Auto  

