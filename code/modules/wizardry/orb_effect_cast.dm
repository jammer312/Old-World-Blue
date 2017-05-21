/obj/item/projectile/magic_projectile
	icon = 'icons/obj/projectiles.dmi'
	name="magic_projectile"
	check_armour="magic"
//rewrite to allow launching from objects other than guns
/obj/item/projectile/magic_projectile/launch(atom/target, mob/user, obj/item/launcher, var/target_zone, var/x_offset=0, var/y_offset=0)
	var/turf/curloc = get_turf(user)
	var/turf/targloc = get_turf(target)
	if (!istype(targloc) || !istype(curloc))
		return 1

	firer = user
	def_zone = target_zone

	if(user == target) //Shooting yourself
		user.bullet_act(src, target_zone)
		on_impact(user)
		qdel(src)
		return 0
	if(targloc == curloc) //Shooting something in the same turf
		target.bullet_act(src, target_zone)
		on_impact(target)
		qdel(src)
		return 0

	original = target
	loc = curloc
	starting = curloc
	current = curloc
	yo = targloc.y - curloc.y + y_offset
	xo = targloc.x - curloc.x + x_offset

	shot_from = launcher

	spawn()
		process()

	return 0

/obj/item/projectile/magic_projectile/fire_sparkle
	icon_state = "magicm"
	color="#ed8e12"
	alpha=96
	damage=5
	damage_type=BURN
	dispersion=2
	var/ignition=2
	before_move()
		if(get_turf(loc)==starting)
			return
		new /obj/fire/magic(loc,ignition)
	on_impact(var/atom/A)
		A.fire_act()
		..()

/orb_effect/cast
	activate(atom/target,mob/user,params,power)
		return ..()

/orb_effect/cast/barrage
	var/projectile_type = /obj/item/projectile/magic_projectile
	activate(atom/target,mob/user,params,power=1.0)
		for(var/i = 1 to 3*sqrt(power))
			var/P = new projectile_type
			P:step_delay*=rand(1,4)
			P:ignition*=sqrt(power)
			P:launch(target,user,orb)

/orb_effect/cast/barrage/fiery
	projectile_type = /obj/item/projectile/magic_projectile/fire_sparkle