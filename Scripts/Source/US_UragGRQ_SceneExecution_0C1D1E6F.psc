;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname US_UragGRQ_SceneExecution_0C1D1E6F Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
; link leg cuffs
Armor LegCuffsArmor = USlibs.UDmain.libsp.GetWornRenderedDeviceByKeyword(Game.GetPlayer(), USlibs.libs.zad_DeviousLegCuffs)
UD_CustomLegCuffs_RenderScript LegCuffs = USlibs.UDCDMain.getNPCSlot(Game.GetPlayer()).getDeviceByRender(LegCuffsArmor) as UD_CustomLegCuffs_RenderScript
LegCuffs.TieUp()

Utility.Wait(1)
; pump plug to maximum
;USlibs.UDmain.libsp.InflateAnalPlug(Game.GetPlayer(), 5)
;USlibs.UDmain.libs.InflateAnalPlug(Game.GetPlayer(), 5)
; why these two above are not working - beyond my understanding... although solution below looks much better...
Armor AnalPlugArmor = USlibs.UDmain.libsp.GetWornRenderedDeviceByKeyword(Game.GetPlayer(), USlibs.libs.zad_DeviousPlugAnal)
UD_CustomInflatablePlug_RenderScript AnalPlug = USlibs.UDCDMain.getNPCSlot(Game.GetPlayer()).getDeviceByRender(AnalPlugArmor) as UD_CustomInflatablePlug_RenderScript
AnalPlug.SetHelper(Urag.GetActorRef())
AnalPlug.inflate(false, 5)
AnalPlug.inflatePlug(5)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

US_libs Property USlibs auto

ReferenceAlias Property Urag auto