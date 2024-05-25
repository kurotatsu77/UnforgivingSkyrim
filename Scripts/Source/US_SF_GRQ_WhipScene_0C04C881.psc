;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname US_SF_GRQ_WhipScene_0C04C881 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
Actor akNodaba = Nodaba.GetActorRef()
USlibs.USWhip(Game.GetPlayer(), akNodaba, HuldaScene)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Game.GetPlayer().EquipItem(ConcBlackGoo)
GRQ.Masochism = GRQ.Masochism + 3
USlibs.IncreaseSLFame(aiMasochist = 3, aiSlave = 3, aiSlut = 3, aiWhore = 3)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

US_Libs Property USLibs Auto
Ingredient Property ConcBlackGoo Auto
ReferenceAlias Property Nodaba  Auto
Scene Property HuldaScene  Auto  
US_GooResearch_Script Property GRQ auto