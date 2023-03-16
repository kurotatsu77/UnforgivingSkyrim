;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname US_QF_GooResearch_Quest_0C019DE7 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Hulda
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Hulda Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Hub
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Hub Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Arcadia
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Arcadia Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Nodaba
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Nodaba Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Whiterun
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Whiterun Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveCompleted(10)
SetObjectiveDisplayed(10, False)
SetObjectiveDisplayed(20, True)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE US_GooResearch_Script
Quest __temp = self as Quest
US_GooResearch_Script kmyQuest = __temp as US_GooResearch_Script
;END AUTOCAST
;BEGIN CODE
Actor akNodaba = kmyQuest.Nodaba.GetActorRef()
akNodaba.addItem(kmyQuest.HubKey, 1)
Game.GetPlayer().AddItem(kmyQuest.HubKey, 1)
Game.GetPlayer().AddToFaction(kmyQuest.US_GRQFaction)
ActorUtil.AddPackageOverride(akNodaba,kmyQuest.US_NodabaToHubPackage,99)
akNodaba.EvaluatePackage()
; Utility.Wait(5)
SetObjectiveCompleted(20)
SetObjectiveDisplayed(20, False)
SetObjectiveDisplayed(30, True)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
SetObjectiveDisplayed(10, True)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
