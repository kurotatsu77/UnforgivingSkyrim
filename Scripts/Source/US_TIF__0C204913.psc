;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname US_TIF__0C204913 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;Nodaba becomes merchant here
AkSpeaker.SetFactionRank(JobMerchant,0)
AkSpeaker.SetFactionRank(NodabaVendor,0)
GRQ.SetObjectiveCompleted(60)
GRQ.CompleteQuest()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property JobMerchant  Auto  

Faction Property NodabaVendor  Auto  

Quest Property GRQ  Auto  
