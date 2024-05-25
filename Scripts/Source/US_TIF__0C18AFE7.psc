;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_TIF__0C18AFE7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
UragGRQ.GiveReward(UragGRQ.ConcBlackGooReward * 2)
UragGRQ.Player.GetActorRef().EquipItem(ConcBlackGoo)
UragGRQ.ConcGoo = true
UragGRQ.Whip()
GRQ.Masochism = GRQ.Masochism + 3
UragGRQ.USlibs.IncreaseSLFame(aiMasochist = 3, aiSlave = 3, aiSlut = 0, aiWhore = 0)
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

Ingredient Property ConcBlackGoo  Auto  
