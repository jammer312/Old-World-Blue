/orb_effect/destruction
	activate(atom/target,mob/user,params,power)
		return ..()

/orb_effect/destruction/projectile_explosion
	var/projectile_type=/obj/item/projectile/magic_projectile/
	var/defrange=3
	var/prob_per_turf_inversed=3
	activate(atom/target,mob/user=usr,params,power=1.0)
		if(!target)
			target=get_turf(orb)
		var/extrange=defrange*sqrt(power)
		var/targets=list()
		for(var/turf/T in orange(target,extrange))
			if(!(rand(1,prob_per_turf_inversed)-1))
				targets+=T
		for(var/T in targets)
			var/P = new projectile_type
			prepare(P,power)
			P:launch(T,user,orb)
	proc/prepare(var/obj/item/projectile/magic_projectile/P,power)
		return
/orb_effect/destruction/projectile_explosion/fiery
	projectile_type=/obj/item/projectile/magic_projectile/fire_sparkle
	prepare(var/obj/item/projectile/magic_projectile/fire_sparkle/P,power)
		P:step_delay*=rand(1,4)
		P:ignition*=sqrt(power)
