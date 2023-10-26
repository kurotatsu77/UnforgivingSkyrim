;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_TIF__0C1E62D5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;start sex here
GRQ.Masochism = GRQ.Masochism + 1
US_GRQ_Enchanting_Quest_script OQ
OQ = GetOwningQuest() as US_GRQ_Enchanting_Quest_script
OQ.UnlockBeltPlugs(akSpeaker)
Utility.Wait(2)
OQ.StartSex(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

US_GooResearch_Script Property GRQ auto

