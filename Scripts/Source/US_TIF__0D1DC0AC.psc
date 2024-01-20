;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_TIF__0D1DC0AC Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetStage(3000)
GetOwningQuest().SetObjectiveCompleted(50)
GetOwningQuest().SetObjectiveDisplayed(100)
EnStation.Enable()
int loc_relation = akSpeaker.GetRelationshipRank(Game.GetPlayer())
if loc_relation < 3
    akSpeaker.SetRelationshipRank(Game.GetPlayer(), loc_relation + 1)
endif

GRQ.Masochism = GRQ.Masochism + 5

;add set here and start sex
US_GRQ_Enchanting_Quest_script OQ
OQ = GetOwningQuest() as US_GRQ_Enchanting_Quest_script
OQ.USlibs.DHLPSuspend()
OQ.LockBoundCuntOutfit(akSpeaker)
OQ.UnlockBeltPlugs(akSpeaker)
OQ.StartSex(akSpeaker)
OQ.USlibs.DHLPResume()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property EnStation  Auto  

US_GooResearch_Script Property GRQ auto
