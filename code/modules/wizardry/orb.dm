/obj/item/orb
	name="Energy orb"
	desc="Constantly fluctuating orb of arcane energies."
	icon='icons/obj/orbs.dmi'
	icon_state='test_icon'

	var/creator //one who created orb will be able to hold it even if he's not mage
	var/metastable=0 //if not metastable then it'll collapse if not held in special storage or hand
	var/volatile=1 //will collapse on disturbance
	var/holder //one who currently holds it

	var/destroyed=false //did it collapsed already

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
	handle_instability()
	effect_aura()

/obj/item/orb/pickup(mob/user)
	holder=user

/obj/item/orb/handle_instability()
	if(metastable)
		return
	if(!src.loc) //idk where it is but probably it shouldn't collapse there
		return
	if(src.loc==holder)
		if(holder==creator||holder.mind&&wizards.is_antagonist(holder.mind))//creator and mages can hold orbs
			return
	//TODO: add check for warded container
	effect_destruction()

/obj/item/orb/proc/delete()
	effect_destruction()
	..()

/obj/item/orb/proc/Bump(atom/A)
	..()
	effect_hit()

/obj/item/orb/proc/throw_impact(atom/hit_atom, var/speed)
	effect_destruction(atom)

/obj/item/orb/proc/effect_aura() //called each process tick
	if(cooldown_aura>0)
		return
	cooldown_aura=initial(cooldown_aura)
	return 1
/obj/item/orb/proc/effect_hit(/atom/target) //called when orb is used on something
	if(volatile)
		effect_destruction(target)
		return
	if(cooldown_hit>0)
		return
	cooldown_hit=initial(cooldown_hit)
	return 1
/obj/item/orb/proc/effect_cast(/atom/target) //called when orb is used on something far
	if(cooldown_cast>0)
		return
	cooldown_cast=initcast)
	return 1
/obj/item/orb/proc/effect_invocation() //called when orb is activated in hand
	if(cooldown_invocation>0)
		return
	cooldown_invocation=initial(cooldown_invocation)
	return 1
/obj/item/orb/proc/effect_destruction(/atom/target) //called when orb is about to be destroyed
	if(destroyed)
		return
	destroyed=true
	return 1
