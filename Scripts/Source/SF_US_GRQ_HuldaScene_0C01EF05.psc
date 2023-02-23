;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname SF_US_GRQ_HuldaScene_0C01EF05 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
USlibs.UDCDmain.EnableActor(Game.GetPlayer())
Game.SetPlayerAIDriven(false)
GetOwningQuest().setstage(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
USlibs.UDCDmain.DisableActor(Game.GetPlayer())
Game.SetPlayerAIDriven(true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

US_Libs Property USLibs Auto
Ingredient Property ConcBlackGoo Auto
ReferenceAlias Property Nodaba  Auto
