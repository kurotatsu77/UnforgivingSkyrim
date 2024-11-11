;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname US_GRQ_TIF__0C0894C5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;eat the conc goo
Game.GetPlayer().EquipItem(ConcBlackGoo)
Utility.Wait(3)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;start the whipping and aggresive sex scene

GRQ.Masochism = GRQ.Masochism + 3
GetOwningQuest().SetStage(3000)
GetOwningQuest().SetObjectiveCompleted(20)
GetOwningQuest().SetObjectiveDisplayed(30)
AlStation.Enable()

US_GRQ_Alchemy_Quest_script OQ = GetOwningQuest() as US_GRQ_Alchemy_Quest_script
OQ.LezWhip(akSpeaker, 3)

;akSpeaker.Say(Deliver)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

UnforgivingDevicesMain Property UDmain auto

US_libs Property USlibs auto

Ingredient Property ConcBlackGoo auto

US_GooResearch_Script Property GRQ auto

ObjectReference Property AlStation auto

Topic Property Deliver auto

Spell Property MasoSpell auto
