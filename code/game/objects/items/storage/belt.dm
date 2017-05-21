/obj/item/storage/belt
	name = "belt"
	desc = "Can hold various things."
	icon = 'icons/inv_slots/belts/icon.dmi'
	icon_state = "utility"
	storage_slots = 14
	max_storage_space = 21
	max_w_class = ITEM_SIZE_NORMAL
	slot_flags = SLOT_BELT
	attack_verb = list("whipped", "lashed", "disciplined")
	var/show_above_suit = 0

/obj/item/storage/belt/verb/toggle_layer()
	set name = "Switch Belt Layer"
	set category = "Object"

	if(show_above_suit == -1)
		usr << "<span class='notice'>\The [src] cannot be worn above your suit!</span>"
		return
	show_above_suit = !show_above_suit
	update_icon()

/obj/item/storage/belt/update_icon()
	if(ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_belt()
	overlays.Cut()
	..()
	for(var/obj/item/I in src)
		overlays += I.item_state

/obj/item/storage/belt/utility
	name = "tool-belt" //Carn: utility belt is nicer, but it bamboozles the text parsing.
	desc = "Can hold various tools."
	icon_state = "utility"
	can_hold = list(
		///obj/item/weapon/combitool,
		/obj/item/weapon/crowbar,
		/obj/item/weapon/screwdriver,
		/obj/item/weapon/weldingtool,
		/obj/item/weapon/wirecutters,
		/obj/item/weapon/wrench,
		/obj/item/device/multitool,
		/obj/item/device/flashlight,
		/obj/item/stack/cable_coil,
		/obj/item/device/t_scanner,
		/obj/item/device/analyzer,
		/obj/item/clothing/glasses,
		/obj/item/clothing/gloves,
		/obj/item/device/pda,
		/obj/item/device/megaphone,
		/obj/item/taperoll/engineering,
		/obj/item/device/radio/headset,
		/obj/item/device/robotanalyzer,
		/obj/item/weapon/material/minihoe,
		/obj/item/weapon/material/hatchet,
		/obj/item/device/analyzer/plant_analyzer,
		/obj/item/weapon/extinguisher/mini
		)


/obj/item/storage/belt/utility/full/New()
	..()
	new /obj/item/weapon/screwdriver(src)
	new /obj/item/weapon/wrench(src)
	new /obj/item/weapon/weldingtool(src)
	new /obj/item/weapon/crowbar(src)
	new /obj/item/weapon/wirecutters(src)
	new /obj/item/stack/cable_coil(src,30,pick("red","yellow","orange"))


/obj/item/storage/belt/utility/atmostech/New()
	..()
	new /obj/item/weapon/screwdriver(src)
	new /obj/item/weapon/wrench(src)
	new /obj/item/weapon/weldingtool(src)
	new /obj/item/weapon/crowbar(src)
	new /obj/item/weapon/wirecutters(src)
	new /obj/item/device/t_scanner(src)



/obj/item/storage/belt/medical
	name = "medical belt"
	desc = "Can hold various medical equipment."
	icon_state = "medical"
	can_hold = list(
		/obj/item/device/healthanalyzer,
		/obj/item/weapon/dnainjector,
		/obj/item/weapon/reagent_containers/dropper,
		/obj/item/weapon/reagent_containers/glass/beaker,
		/obj/item/weapon/reagent_containers/pill,
		/obj/item/weapon/reagent_containers/syringe,
		/obj/item/weapon/flame/lighter/zippo,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/device/radio/headset,
		/obj/item/device/pda,
		/obj/item/device/megaphone,
		/obj/item/device/flashlight/pen,
		/obj/item/clothing/mask/surgical,
		/obj/item/clothing/head/surgery,
		/obj/item/clothing/gloves,
		/obj/item/weapon/reagent_containers/hypospray,
		/obj/item/clothing/glasses,
		/obj/item/weapon/crowbar,
		/obj/item/device/flashlight,
		/obj/item/weapon/extinguisher/mini
		)

/obj/item/storage/belt/medical/emt
	name = "EMT utility belt"
	desc = "A sturdy black webbing belt with attached pouches."
	icon_state = "emsbelt"

/obj/item/storage/belt/security
	name = "security belt"
	desc = "Can hold security gear like handcuffs and flashes."
	icon_state = "security"
	can_hold = list(
		/obj/item/weapon/grenade,
		/obj/item/weapon/reagent_containers/spray/pepper,
		/obj/item/weapon/handcuffs,
		/obj/item/device/flash,
		/obj/item/clothing/glasses,
		/obj/item/ammo_casing/shotgun,
		/obj/item/ammo_magazine,
		/obj/item/weapon/reagent_containers/food/snacks/donut,
		/obj/item/weapon/melee/baton,
		/obj/item/weapon/gun/energy/taser,
		/obj/item/weapon/flame/lighter,
		/obj/item/device/flashlight,
		/obj/item/device/pda,
		/obj/item/device/radio/headset,
		/obj/item/clothing/gloves,
		/obj/item/device/hailer,
		/obj/item/device/megaphone,
		/obj/item/weapon/melee,
		/obj/item/clothing/accessory/badge,
		/obj/item/weapon/gun/projectile/sec,
		/obj/item/taperoll
		)

/obj/item/storage/belt/detective
	name = "forensic utility belt"
	desc = "A belt for holding forensics equipment."
	icon_state = "security"
	storage_slots = 7
	can_hold = list(
		/obj/item/device/taperecorder,
		/obj/item/clothing/glasses,
		/obj/item/device/flashlight,
		/obj/item/weapon/reagent_containers/spray/luminol,
		/obj/item/weapon/sample,
		/obj/item/weapon/forensics/sample_kit/powder,
		/obj/item/weapon/forensics/swab,
		/obj/item/device/uv_light,
		/obj/item/weapon/forensics/sample_kit,
		/obj/item/weapon/photo,
		/obj/item/device/camera_film,
		/obj/item/device/camera,
		/obj/item/weapon/autopsy_scanner,
		/obj/item/device/mass_spectrometer,
		/obj/item/clothing/accessory/badge,
		/obj/item/device/reagent_scanner,
		/obj/item/weapon/reagent_containers/dropper,
		/obj/item/weapon/reagent_containers/syringe,
		/obj/item/device/pda,
		/obj/item/device/hailer,
		/obj/item/device/megaphone,
		/obj/item/device/radio/headset,
		/obj/item/clothing/gloves,
		/obj/item/taperoll,
		/obj/item/weapon/reagent_containers/spray/pepper,
		/obj/item/weapon/handcuffs,
		/obj/item/device/flash,
		/obj/item/weapon/flame/lighter,
		/obj/item/weapon/reagent_containers/food/snacks/donut/,
		/obj/item/ammo_magazine,
		/obj/item/weapon/gun/projectile/colt/detective
		)

/obj/item/storage/belt/soulstone
	name = "soul stone belt"
	desc = "Designed for ease of access to the shards during a fight, as to not let a single enemy spirit slip away"
	icon_state = "soulstone"
	storage_slots = 6
	can_hold = list(/obj/item/device/soulstone)

/obj/item/storage/belt/soulstone/full/New()
	..()
	new /obj/item/device/soulstone(src)
	new /obj/item/device/soulstone(src)
	new /obj/item/device/soulstone(src)
	new /obj/item/device/soulstone(src)
	new /obj/item/device/soulstone(src)
	new /obj/item/device/soulstone(src)


/obj/item/storage/belt/champion
	name = "championship belt"
	desc = "Proves to the world that you are the strongest!"
	icon_state = "champion"
	storage_slots = 1
	can_hold = list(
		/obj/item/clothing/mask/luchador
		)

/obj/item/storage/belt/security/tactical
	name = "combat belt"
	desc = "Can hold security gear like handcuffs and flashes, with more pouches for more storage."
	icon_state = "swatbelt"
	storage_slots = 9
	max_storage_space = 28

/obj/item/storage/belt/security/batman
	name = "batbelt"
	desc = "For all your crime-fighting bat needs."
	icon_state = "bmbelt"
	storage_slots = 7
	max_storage_space = 28
	can_hold = list(
		/obj/item/weapon/grenade,
		/obj/item/weapon/reagent_containers/spray/pepper,
		/obj/item/weapon/handcuffs,
		/obj/item/device/flash,
		/obj/item/clothing/glasses,
		/obj/item/ammo_casing/shotgun,
		/obj/item/ammo_magazine,
		/obj/item/weapon/reagent_containers/food/snacks/donut/,
		/obj/item/weapon/melee/baton,
		/obj/item/weapon/gun/energy/taser,
		/obj/item/weapon/flame/lighter,
		/obj/item/clothing/glasses/hud/security,
		/obj/item/device/flashlight,
		/obj/item/device/pda,
		/obj/item/device/radio/headset,
		/obj/item/device/hailer,
		/obj/item/device/megaphone,
		/obj/item/weapon/melee,
		/obj/item/weapon/gun/projectile/sec,
		/obj/item/taperoll
		)

/obj/item/storage/belt/fannypack
	name = "fannypack"
	desc = "A dorky fannypack for keeping small items in."
	icon_state = "fannypack_leather"
	storage_slots = 3
	max_w_class = ITEM_SIZE_SMALL

/obj/item/storage/belt/fannypack/black
	name = "black fannypack"
	icon_state = "fannypack_black"

/obj/item/storage/belt/fannypack/red
	name = "red fannypack"
	icon_state = "fannypack_red"

/obj/item/storage/belt/fannypack/white
	name = "white fannypack"
	icon_state = "fannypack_white"

/obj/item/storage/belt/janitor
	name = "janitorial belt"
	desc = "A belt used to hold most janitorial supplies."
	icon_state = "janibelt"
	storage_slots = 7
	max_w_class = ITEM_SIZE_NORMAL
	can_hold = list(
		/obj/item/clothing/glasses,
		/obj/item/device/flashlight,
		/obj/item/weapon/grenade,
		/obj/item/device/pda,
		/obj/item/device/radio/headset,
		/obj/item/clothing/gloves,
		/obj/item/clothing/mask/surgical, //sterile mask,
		/obj/item/device/assembly/mousetrap,
		/obj/item/weapon/light/bulb,
		/obj/item/weapon/light/tube,
		/obj/item/weapon/flame/lighter,
		/obj/item/device/megaphone,
		/obj/item/weapon/reagent_containers/spray,
		/obj/item/weapon/soap
		)