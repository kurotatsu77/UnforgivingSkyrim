Scriptname US_Urag_Script extends ReferenceAlias  
{script to respond to being struck by shouts}

MagicEffect Property AbadonShoutEffect  Auto  

Spell Property AbadonSpell1 Auto

Spell Property AbadonSpell2 Auto

Spell Property AbadonSpell3 Auto

US_UragGRQ_Script Property UragGRQ auto

Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect) ; can't get magnitude here?
	if akCaster == Game.GetPlayer()
		if akEffect == AbadonShoutEffect
			;GetOwningQuest().setstage(25)
		endif
	endif
endEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
    ;Debug.Trace("We were hit by " + akAggressor)
    Spell loc_spell = akSource as Spell
    if loc_spell == AbadonSpell1
        UragGRQ.ProcessShout(1)
    elseif loc_spell == AbadonSpell2
        UragGRQ.ProcessShout(2)
    elseif loc_spell == AbadonSpell3
        UragGRQ.ProcessShout(3)
    endif
EndEvent
