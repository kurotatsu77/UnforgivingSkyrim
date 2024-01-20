;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_GRQ_TIF__0C0894CD Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;whip player
USlibs.DHLPSuspend() 
USlibs.UDCDmain.DisableActor(Game.GetPlayer())
Game.SetPlayerAIDriven(true)

USlibs.USWhip(Game.GetPlayer(), akSpeaker)
USlibs.UDCDmain.EnableActor(Game.GetPlayer())

Game.SetPlayerAIDriven(false)
USlibs.DHLPResume()

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

US_libs Property USlibs auto