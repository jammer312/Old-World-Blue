//allows some interesting behaviour
//it's somewhat cheaty way of doing damage by storing projectile and hitting target with it every time you need to
/obj/item/projectile/magic_hitter
	name="Magic missile"
	check_armour="magic"
	var/spec_effect_type
	proc/spawn_effect(loc,power)
		if(spec_effect_type)
			new spec_effect_type(loc)
	New(loc)
		shot_from=loc

/orb_effect/hit
	var/hitter_type=/obj/item/projectile/magic_hitter
	var/obj/item/projectile/magic_hitter/hitter

/orb_effect/hit/New(obj/item/orb/host)
	hitter=new hitter_type(orb)
	..()

/orb_effect/hit/activate(atom/target,mob/user,params)
	var/target_turf=get_turf(target)
	hitter.firer=user
	var/tmp_power=1.0
	if(orb&&orb.power)
		tmp_power=orb.power
	hitter.spawn_effect(target_turf,tmp_power)
	for(var/obj/O in target_turf)
		O.bullet_act(hitter)
	for(var/mob/living/M in target_turf)
		hitter.attack_mob(M, 1)
	return ..()

/orb_effect/hit/fire
	hitter_type=/obj/item/projectile/magic_hitter/fire_wave

/obj/item/projectile/magic_hitter/fire_wave
	var/ignition=4
	damage=15
	damage_type=BURN
	spec_effect_type=/obj/fire/magic
	spawn_effect(loc,power)
		if(spec_effect_type)
			new spec_effect_type(loc,ignition*sqrt(power))