;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_TIF__0C1BDA34 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
UragGRQ.GiveReward(UragGRQ.PlugReward * 3)
int loc_num = UragGRQ.Player.GetActorRef().GetItemCount(PlugVag)
if loc_num > 0
    UragGRQ.USlibs.libs.LockDevice(UragGRQ.Player.GetActorRef(), PlugVag)
else
    UragGRQ.USlibs.libs.LockDevice(UragGRQ.Player.GetActorRef(), PlugAnal)
endif
UragGRQ.AbadonPlug = true
UragGRQ.Whip()
GRQ.Masochism = GRQ.Masochism + 3
int loc_relation = akSpeaker.GetRelationshipRank(UragGRQ.Player.GetActorRef())
if loc_relation < 2
    akSpeaker.SetRelationshipRank(UragGRQ.Player.GetActorRef(), loc_relation + 1)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

US_UragGRQ_Script Property UragGRQ auto

US_GooResearch_Script Property GRQ  Auto  

Armor Property PlugVag  Auto  

Armor Property PlugAnal  Auto  
