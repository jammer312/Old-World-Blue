/spell/summoning
	name="summon spell"
	school="summons"
	spell_flags=0 //no clothes by default
	range=0
	var/obj/item/item_to_summon = /obj/item //type of summoned item
	duration=0 //if not 0 then will deleted after duration
	charge_max = 2000 //200 seconds to recharge for now. 

/spell/summoning/choose_targets(mob/user = usr)
	return list(user)

/spell/summoning/proc/summon_act(var/O)
	return

/spell/summoning/cast(var/list/targets, mob/user)
	if(!targets)
		return
	for(var/mob/T in targets)
		var/summoned=new item_to_summon
		if(!summoned)
			return
		if(T.put_in_hands(summoned))
			T<<"[summoned] appears right in your hand"
		else
			T<<"[summoned] appears right in front of you"
		summon_act(summoned)
		if(duration)
			spawn(duration)
				if(summoned)
					qdel(summoned)





/spell/summoning/orb
	name="summon orb"
	item_to_summon=/obj/item/orb

/spell/summoning/orb/test
	name="summon test orb"
	item_to_summon=/obj/item/orb/fiery
	summon_act(var/O)
		O:summoned=1