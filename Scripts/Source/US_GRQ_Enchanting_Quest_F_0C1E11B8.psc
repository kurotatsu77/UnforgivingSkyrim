;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname US_GRQ_Enchanting_Quest_F_0C1E11B8 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
Utility.Wait(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
;remove belt and plugs
US_GRQ_Enchanting_Quest_script OQ
OQ = GetOwningQuest() as US_GRQ_Enchanting_Quest_script
OQ.UnlockBeltPlugs(Farengar.GetActorRef())
Utility.Wait(1)
OQ.StartSex(Farengar.GetActorRef())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
;remove collar, and lock the BoundCunt one if possible
US_GRQ_Enchanting_Quest_script OQ
OQ = GetOwningQuest() as US_GRQ_Enchanting_Quest_script
OQ.LockBoundCuntCollar(Farengar.GetActorRef())
Utility.Wait(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
;add goo
Game.GetPlayer().EquipItem(ConcGoo)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Ingredient Property ConcGoo  Auto  

ReferenceAlias Property Farengar  Auto  
