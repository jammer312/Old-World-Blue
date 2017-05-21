/orb_effect
	var/obj/item/orb/orb
/orb_effect/New(obj/item/orb/host)
	orb=host
/orb_effect/proc/activate()
	return

/obj/item/orb
	name="Energy orb"
	desc="Constantly fluctuating orb of arcane energies."
	icon='icons/obj/orbs.dmi'
	icon_state="test_icon"

	var/mob/creator //one who created orb will be able to hold it even if he's not mage
	var/metastable=0 //if not metastable then it'll collapse if not held in special storage or hand
	var/volatile=0 //will collapse on rough disturbance
	var/mob/holder //one who currently holds it
	var/power=1 //magic constants are fun

	var/summoned=0 //to prevent despawning right at spawn
	var/destroyed=0 //did it collapsed already

	var/cooldown_aura=1
	var/cooldown_hit=1
	var/cooldown_cast=1
	var/cooldown_invocation=1

	//these allow greater flexibility (reusing of effects in other orbs)
	var/aura_type=/orb_effect
	var/hit_type=/orb_effect
	var/cast_type=/orb_effect
	var/invocation_type=/orb_effect
	var/destruction_type=/orb_effect

	var/orb_effect/aura
	var/orb_effect/hit
	var/orb_effect/cast
	var/orb_effect/invocation
	var/orb_effect/destruction
	var/process_delay=2

/obj/item/orb/New(loc,mob/invoker=usr)
	creator=invoker
	aura=new aura_type(src)
	hit=new hit_type(src)
	cast=new cast_type(src)
	invocation=new invocation_type(src)
	destruction=new destruction_type(src)
	spawn()
		while(!destroyed)
			process()
			sleep(process_delay)

/obj/item/orb/proc/effect_aura(delay) //called each process tick
	if(cooldown_aura>0)
		return
	cooldown_aura=initial(cooldown_aura)
	aura.activate(delay)
	return 1

/obj/item/orb/proc/effect_hit(atom/target,mob/user,params) //called when orb is used on something
	if(throwing || volatile || !istype(loc,/mob))
		effect_destruction(target,user,params)
		qdel(src)
		return
	if(cooldown_hit>0)
		if(user)
			user<<"<span class='danger'>\The [src] fizzles uselessly!</span>"
		return
	cooldown_hit=initial(cooldown_hit)
	hit.activate(target,user,params,power)
	return 1

/obj/item/orb/proc/effect_cast(atom/target,mob/user,params) //called when orb is used on something far
	if(cooldown_cast>0)
		if(user)
			user<<"<span class='danger'>\The [src] fizzles uselessly!</span>"
		return
	cooldown_cast=initial(cooldown_cast)
	cast.activate(target,user,params,power)
	return 1

/obj/item/orb/proc/effect_invocation(mob/user,params) //called when orb is activated in hand
	if(cooldown_invocation>0)
		if(user)
			user<<"<span class='danger'>\The [src] fizzles uselessly!</span>"
		return
	cooldown_invocation=initial(cooldown_invocation)
	invocation.activate(user,params)
	return 1

/obj/item/orb/proc/effect_destruction(atom/target,mob/user,params) //called when orb is about to be destroyed
	if(destroyed)
		return
	destruction.activate(target,user,params)
	destroyed=1
	return 1

/obj/item/orb/proc/handle_instability()
	if(!summoned) //don't collapse when being summoned
		return
	if(!src.loc) //idk where it is but probably it shouldn't collapse there
		return
	if(src.throwing)
		return //pretty stabile on-fly
	if(holder&&(holder==creator||holder.mind&&wizards.is_antagonist(holder.mind)))//creator and mages can hold orbs	
		return
	else
		qdel(src)
		return
	if(metastable)
		return
	//TODO: add check for warded container
	qdel(src)

/obj/item/orb/process() // for cooldowns and aura
	if(destroyed)
		qdel(src)
		return
	if(cooldown_aura>0)
		cooldown_aura-=process_delay
	if(cooldown_hit>0)
		cooldown_hit-=process_delay
	if(cooldown_cast>0)
		cooldown_cast-=process_delay
	if(cooldown_invocation>0)
		cooldown_invocation-=process_delay
	if(power>=10)
		power=10
	if(istype(src.loc,/mob))
		holder=src.loc
	else
		holder=null
	handle_instability()
	effect_aura(process_delay)

/obj/item/orb/pickup(mob/user)
	world<<"Picked up"
	holder=user
	handle_instability()
/obj/item/orb/dropped(mob/user)
	world<<"Dropped"
	holder=null
	handle_instability()

/obj/item/orb/Destroy()
	effect_destruction()
	..()

/obj/item/orb/Bump(atom/A)
	effect_hit()
	..()

/obj/item/orb/Bumped(atom/A)
	effect_hit()
	..()


/obj/item/orb/throw_impact(atom/hit_atom, var/speed)
	effect_destruction(hit_atom)
	qdel(src)

/obj/item/orb/afterattack(atom/A, mob/living/user, adjacent, params)
	if(adjacent)
		effect_hit(A,user,params)
	else
		effect_cast(A,user,params)


/obj/item/orb/fiery
	name="Fire orb"
	hit_type=/orb_effect/hit/fire
	cast_type=/orb_effect/cast/barrage/fiery
	destruction_type=/orb_effect/destruction/projectile_explosion/fiery
	aura_type=/orb_effect/aura/charger/fiery
	cooldown_hit=10
	cooldown_cast=10