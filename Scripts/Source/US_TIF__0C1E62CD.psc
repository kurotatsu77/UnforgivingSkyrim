;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname US_TIF__0C1E62CD Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
US_GRQ_Enchanting_Quest_script OQ
OQ = GetOwningQuest() as US_GRQ_Enchanting_Quest_script
OQ.UnlockBeltPlugs(akSpeaker)
Utility.Wait(2)
OQ.StartSex(akSpeaker)
OQ.USlibs.DHLPResume()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
US_GRQ_Enchanting_Quest_script OQ
OQ = GetOwningQuest() as US_GRQ_Enchanting_Quest_script
OQ.USlibs.DHLPSuspend()
Game.GetPlayer().AddItem(Gold,1000)
Game.GetPlayer().AddItem(ConcGoo,1)
Game.GetPlayer().EquipItem(ConcGoo)
GRQ.Masochism = GRQ.Masochism + 3
OQ.USlibs.IncreaseSLFame(aiMasochist = 3, aiSlave = 3, aiSlut = 3, aiWhore = 3)
Utility.Wait(5)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

US_GooResearch_Script Property GRQ auto

Ingredient Property ConcGoo  Auto  

MiscObject Property Gold  Auto  
