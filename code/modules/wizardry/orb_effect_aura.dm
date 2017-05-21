/orb_effect/aura
	activate(var/delay)
		return ..()

/orb_effect/aura/charger
	var/potency=0.025
	proc/condition()
		return
	activate(var/delay=1)
		if(condition())
			orb.power+=potency*delay

/orb_effect/aura/charger/fiery
	condition()
		return orb.holder&&istype(orb.holder,/mob/living)&&orb.holder:on_fire