//Procedures in this file: Robotic limbs attachment, meat limbs attachment
//////////////////////////////////////////////////////////////////
//						LIMB SURGERY							//
//////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
//	 generic limb surgery step datum
//////////////////////////////////////////////////////////////////
/datum/surgery_step/limb/
	priority = 3 // Must be higher than /datum/surgery_step/internal
	can_infect = 0

/datum/surgery_step/limb/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if (!hasorgans(target))
		return 0
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if (affected)
		return 0
	var/datum/organ_description/OD = target.species.has_limbs["[target_zone]"]
	return !isnull(OD)

//////////////////////////////////////////////////////////////////
//	 limb attachment surgery step
//////////////////////////////////////////////////////////////////
/datum/surgery_step/limb/attach
	allowed_tools = list(/obj/item/organ/external = 100)

	min_duration = 50
	max_duration = 70

	tool_quality(obj/item/tool)
		for (var/T in allowed_tools)
			if (istype(tool,T))
				return allowed_tools[T]
		return 0

/datum/surgery_step/limb/attach/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/E = tool
	user.visible_message(
		"[user] starts attaching [E.name] to [target]'s [E.amputation_point].",
		"You start attaching [E.name] to [target]'s [E.amputation_point]."
	)

/datum/surgery_step/limb/attach/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/E = tool
	user.visible_message(
		SPAN_NOTE("[user] has attached [target]'s [E.name] to the [E.amputation_point]."),
		SPAN_NOTE("You have attached [target]'s [E.name] to the [E.amputation_point].")
	)
	user.drop_from_inventory(E)
	E.install(target)
	E.status |= ORGAN_CUT_AWAY


/datum/surgery_step/limb/attach/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/E = tool
	user.visible_message(
		SPAN_WARN("[user]'s hand slips, damaging [target]'s [E.amputation_point]!"),
		SPAN_WARN("Your hand slips, damaging [target]'s [E.amputation_point]!")
	)
	target.apply_damage(10, BRUTE, null, sharp=1)

//////////////////////////////////////////////////////////////////
//	 limb connecting surgery step
//////////////////////////////////////////////////////////////////
/datum/surgery_step/limb/connect
	allowed_tools = list(
		/obj/item/weapon/hemostat = 100,
		/obj/item/stack/cable_coil = 75,
		/obj/item/device/assembly/mousetrap = 20
	)
	can_infect = 1

	min_duration = 100
	max_duration = 120

/datum/surgery_step/limb/connect/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/E = target.get_organ(target_zone)
	return E && !E.is_stump() && (E.status & ORGAN_CUT_AWAY)

/datum/surgery_step/limb/connect/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/E = target.get_organ(target_zone)
	user.visible_message(
		"[user] starts connecting tendons and muscles in [target]'s [E.amputation_point] with [tool].",
		"You start connecting tendons and muscle in [target]'s [E.amputation_point]."
	)

/datum/surgery_step/limb/connect/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/E = target.get_organ(target_zone)
	user.visible_message(
		SPAN_NOTE("[user] has connected tendons and muscles in [target]'s [E.amputation_point] with [tool]."),
		SPAN_NOTE("You have connected tendons and muscles in [target]'s [E.amputation_point] with [tool].")
	)
	E.status &= ~ORGAN_CUT_AWAY
	target.update_body()
	target.updatehealth()
	target.UpdateDamageIcon()

/datum/surgery_step/limb/connect/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/E = target.get_organ(target_zone)
	user.visible_message(
		SPAN_WARN("[user]'s hand slips, damaging [target]'s [E.amputation_point]!"),
		SPAN_WARN("Your hand slips, damaging [target]'s [E.amputation_point]!")
	)
	target.apply_damage(10, BRUTE, null, sharp=1)

//////////////////////////////////////////////////////////////////
//	 robotic limb attachment surgery step
//////////////////////////////////////////////////////////////////

/datum/surgery_step/limb/prosthesis
	allowed_tools = list(/obj/item/prosthesis = 100)

	min_duration = 80
	max_duration = 100

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		if(..())
			var/obj/item/prosthesis/p = tool
			if (p.part)
				if (!(target_zone in p.part))
					return 0
			return isnull(target.get_organ(target_zone))

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		user.visible_message(
			"[user] starts attaching \the [tool] to [target].",
			"You start attaching \the [tool] to [target]."
		)

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/prosthesis/L = tool
		user.visible_message(
			SPAN_NOTE("[user] has attached \the [tool] to [target]."),
			SPAN_NOTE("You have attached \the [tool] to [target].")
		)

		if(L.part)
			for(var/part_name in L.part)
				if(target.get_organ(part_name))
					continue
				var/datum/organ_description/organ_data = target.species.has_limbs[part_name]
				if(!organ_data)
					continue
				var/new_limb_type = L.part[part_name]
				new new_limb_type(target, organ_data)

		target.update_body()
		target.updatehealth()
		target.UpdateDamageIcon()

		qdel(tool)

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		user.visible_message(
			SPAN_WARN("[user]'s hand slips, damaging [target]'s flesh!"),
			SPAN_WARN("Your hand slips, damaging [target]'s flesh!")
		)
		target.apply_damage(10, BRUTE, null, sharp=1)
