;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname US_GRQ_TIF__0C0894C3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;start lesbian sex scene

GetOwningQuest().SetStage(2000)
GetOwningQuest().SetObjectiveCompleted(20)
GetOwningQuest().SetObjectiveDisplayed(30)
Game.GetPlayer().RemoveItem(Gold,1000)
AlStation.Enable()
GRQ.Masochism = GRQ.Masochism + 1

US_GRQ_Alchemy_Quest_script OQ = GetOwningQuest() as US_GRQ_Alchemy_Quest_script
OQ.LezSex(akSpeaker, 1)

;akSpeaker.Say(Deliver)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;eat black goo
Game.GetPlayer().EquipItem(BlackGoo)
Utility.Wait(1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

;UnforgivingDevicesMain Property UDmain auto

;US_libs Property USlibs auto

Ingredient Property BlackGoo auto

US_GooResearch_Script Property GRQ auto

ObjectReference Property AlStation auto

MiscObject Property Gold  Auto  

Topic Property Deliver auto

;Spell Property MasoSpell auto
