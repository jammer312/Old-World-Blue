/obj/item/orb
	name="Energy orb"
	desc="Constantly fluctuating orb of arcane energies."
	icon='icons/obj/orbs.dmi'
	icon_state='test_icon'

	var/creator //one who created orb will be able to hold it even if he's not mage
	var/stable=0 //if not stable then it'll collapse if not held in special storage or hand

	var/cooldown_aura=0
	var/cooldown_hit=0
	var/cooldown_cast=0
	var/cooldown_invocation=0

/obj/item/orb/New(loc,creator)
	processing_objects.Add(src)

/obj/item/orb/process() // for cooldowns and aura
	if(cooldown_aura>0)
		cooldown_aura-=1
	if(cooldown_hit>0)
		cooldown_hit-=1
	if(cooldown_cast>0)
		cooldown_cast-=1
	if(cooldown_invocation>0)
		cooldown_invocation-=1
	effect_aura()

/obj/item/orb/proc/effect_aura() //called each process tick
	if(cooldown_aura>0)
		return
	return 1
/obj/item/orb/proc/effect_hit(/atom/target) //called when orb is used on something
	if(cooldown_hit>0)
		return
	return 1
/obj/item/orb/proc/effect_cast(/atom/target) //called when orb is used on something far
	if(cooldown_cast>0)
		return
	return 1
/obj/item/orb/proc/effect_invocation() //called when orb is activated in hand
	if(cooldown_invocation>0)
		return
	return 1
/obj/item/orb/proc/effect_destruction() //called when orb is about to be destroyed
	return
