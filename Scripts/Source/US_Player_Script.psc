Scriptname US_Player_Script extends ReferenceAlias  

US_libs Property USlibs auto

Event OnPlayerLoadGame()
    USlibs.OnGameReload()
EndEvent

