;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname US_TIF__0C1FA6EB Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;dress up here
GRQE.LockBoundCuntCollar(akSpeaker)
GRQE.LockRandomArmRestraint(akSpeaker)
GRQE.LockRandomGag(akSpeaker)
GRQE.GRQ.Masochism = GRQE.GRQ.Masochism + 2
Utility.Wait(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;start lesbian sex scene
US_GRQ_Alchemy_Quest_script OQ = GetOwningQuest() as US_GRQ_Alchemy_Quest_script
OQ.LezSexReward(akSpeaker, 2)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

UnforgivingDevicesMain Property UDmain auto

US_libs Property USlibs auto

Ingredient Property BlackGoo auto

US_GooResearch_Script Property GRQ auto

Topic Property Reward auto

Package Property RewardFG auto

Spell Property MasoSpell auto

US_GRQ_Enchanting_Quest_script Property GRQE auto
