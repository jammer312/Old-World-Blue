/obj/machinery/autolathe
	name = "autolathe"
	desc = "It produces items using metal and glass."
	icon_state = "autolathe"
	density = 1
	anchored = 1
	use_power = 1
	idle_power_usage = 10
	active_power_usage = 2000
	circuit = /obj/item/weapon/circuitboard/autolathe

	var/tmp/list/machine_recipes
	var/list/stored_material =  list(DEFAULT_WALL_MATERIAL = 0, "glass" = 0)
	var/list/storage_capacity = list(DEFAULT_WALL_MATERIAL = 0, "glass" = 0)
	var/show_category = "All"
	var/current_color = "#ffffff"

	var/hacked = 0
	var/disabled = 0
	var/shocked = 0
	var/tmp/busy = 0

	var/mat_efficiency = 1
	var/build_time = 50

	var/tmp/datum/wires/autolathe/wires = null


/obj/machinery/autolathe/New()
	..()
	wires = new(src)

/obj/machinery/autolathe/proc/update_recipe_list()
	if(!machine_recipes)
		machine_recipes = autolathe_recipes

/obj/machinery/autolathe/interact(mob/user as mob)

	update_recipe_list()

	if(..() || (disabled && !panel_open))
		user << "<span class='danger'>\The [src] is disabled!</span>"
		return

	if(shocked)
		shock(user, 50)

	var/dat = "<style>span.box{display: inline-block; width: 20px; height: 10px; border:1px solid #000;}\
			   span.deficiency{color: red}</style>"
	dat += "<center><h1>Autolathe Control Panel</h1><hr/>"

	if(!disabled)
		dat += "<table width = '100%'>"
		var/material_top = ""
		var/material_bottom = ""

		for(var/material in stored_material)

			material_top += "<td width = '25%' align = center><b>"
			material_top += "<a href='?src=\ref[src];remove_material=[material]'>[material]</a>"
			material_top += "</b></td>"
			material_bottom += "<td width = '25%' align = center>[stored_material[material]]<b>/[storage_capacity[material]]</b></td>"

		dat += "<tr>[material_top]</tr><tr>[material_bottom]</tr></table><hr>"
		dat += "<b>Current color:</b> <a href='?src=\ref[src];color=set'><span class='box' style='background-color:[current_color];'></span></a><hr><br>"
		dat += "<h2>Printable Designs</h2><h3>Showing: <a href='?src=\ref[src];change_category=1'>[show_category]</a>.</h3></center><table width = '100%'>"

		var/index = 0
		for(var/datum/autolathe/recipe/R in machine_recipes)
			index++
			if(R.hidden && !hacked || (show_category != "All" && show_category != R.category))
				continue
			var/can_make = 1
			var/material_string = ""
			var/multiplier_string = ""
			var/max_sheets
			var/comma
			if(!R.resources || !R.resources.len)
				material_string = "No resources required.</td>"
			else
				//Make sure it's buildable and list requires resources.
				for(var/material in R.resources)
					var/sheets = round(stored_material[material]/round(R.resources[material]*mat_efficiency))
					if(isnull(max_sheets) || max_sheets > sheets)
						max_sheets = sheets
					if(!comma)
						comma = 1
					else
						material_string += ", "
					if(!isnull(stored_material[material]) && stored_material[material] < round(R.resources[material]*mat_efficiency))
						can_make = 0
						material_string += "<span class='deficiency'>[round(R.resources[material] * mat_efficiency)] [material]</span>"
					else
						material_string += "[round(R.resources[material] * mat_efficiency)] [material]"
				material_string += ".<br></td>"
				//Build list of multipliers for sheets.
				if(R.is_stack)
					if(max_sheets && max_sheets > 0)
						multiplier_string  += "<br>"
						for(var/i = 5;i<=max_sheets;i*=2) //5,10,20,40...
							multiplier_string  += "<a href='?src=\ref[src];make=[index];multiplier=[i]'>\[x[i]\]</a>"
						multiplier_string += "<a href='?src=\ref[src];make=[index];multiplier=[max_sheets]'>\[x[max_sheets]\]</a>"


			dat += "<tr><td width = 180>[R.hidden ? "<font color = 'red'>*</font>" : ""]<b>[can_make ? "<a href='?src=\ref[src];make=[index];multiplier=1'>" : ""][R.name][can_make ? "</a>" : ""]</b>[R.hidden ? "<font color = 'red'>*</font>" : ""][multiplier_string]</td><td align = right>[material_string]</tr>"

		dat += "</table><hr>"
	//Hacking.
	if(panel_open)
		dat += "<h2>Maintenance Panel</h2>"
		dat += wires.GetInteractWindow()

		dat += "<hr>"

	user << browse(dat, "window=autolathe")
	onclose(user, "autolathe")

/obj/machinery/autolathe/attackby(var/obj/item/O as obj, var/mob/user as mob)

	if(busy)
		user << "<span class='notice'>\The [src] is busy. Please wait for completion of previous operation.</span>"
		return

	if(default_deconstruction_screwdriver(user, O))
		updateUsrDialog()
		return
	if(default_deconstruction_crowbar(user, O))
		return
	if(default_part_replacement(user, O))
		return

	if(stat)
		return

	if(panel_open)
		//Don't eat multitools or wirecutters used on an open lathe.
		if(istype(O, /obj/item/device/multitool) || istype(O, /obj/item/weapon/wirecutters))
			attack_hand(user)
			return

	if(O.loc != user && !(istype(O,/obj/item/stack)))
		return 0

	if(is_robot_module(O))
		return 0

	//Resources are being loaded.
	var/obj/item/eating = O
	if(!eating.matter)
		user << "\The [eating] does not contain significant amounts of useful materials and cannot be accepted."
		return

	var/filltype = 0       // Used to determine message.
	var/total_used = 0     // Amount of material used.
	var/mass_per_sheet = 0 // Amount of material constituting one sheet.

	for(var/material in eating.matter)

		if(isnull(stored_material[material]) || isnull(storage_capacity[material]))
			continue

		if(stored_material[material] >= storage_capacity[material])
			continue

		var/total_material = eating.matter[material]

		//If it's a stack, we eat multiple sheets.
		if(istype(eating,/obj/item/stack))
			var/obj/item/stack/stack = eating
			total_material *= stack.get_amount()

		if(stored_material[material] + total_material > storage_capacity[material])
			total_material = storage_capacity[material] - stored_material[material]
			filltype = 1
		else
			filltype = 2

		stored_material[material] += total_material
		total_used += total_material
		mass_per_sheet += eating.matter[material]

	if(!filltype)
		user << "<span class='notice'>\The [src] is full. Please remove material from the autolathe in order to insert more.</span>"
		return
	else if(filltype == 1)
		user << "You fill \the [src] to capacity with \the [eating]."
	else
		user << "You fill \the [src] with \the [eating]."

	flick("autolathe_o", src) // Plays metal insertion animation. Work out a good way to work out a fitting animation. ~Z

	if(istype(eating,/obj/item/stack))
		var/obj/item/stack/stack = eating
		stack.use(max(1, round(total_used/mass_per_sheet))) // Always use at least 1 to prevent infinite materials.
	else
		user.remove_from_mob(O)
		qdel(O)

	updateUsrDialog()
	return

/obj/machinery/autolathe/attack_hand(mob/user as mob)
	user.set_machine(src)
	interact(user)

/obj/machinery/autolathe/Topic(href, href_list)

	if(..())
		return

	usr.set_machine(src)
	add_fingerprint(usr)

	if(busy)
		usr << "<span class='notice'>The autolathe is busy. Please wait for completion of previous operation.</span>"
		return

	if(href_list["remove_material"])
		var/material = href_list["remove_material"]
		if(!material in stored_material)
			return
		var/amount = input(usr, "How many stacks you want eject?") as null|num
		if(amount < 1 || !in_range(usr,src) || usr.stat || usr.restrained())
			return
		//convert list to units
		amount *= SHEET_MATERIAL_AMOUNT
		if(stored_material[material] < amount)
			amount = round(stored_material, SHEET_MATERIAL_AMOUNT)
			if(amount < SHEET_MATERIAL_AMOUNT)
				return
		stored_material[material] -= amount
		create_material_stack(material, amount, src.loc)

	if(href_list["change_category"])
		var/choice = input("Which category do you wish to display?") as null|anything in autolathe_categories+"All"
		if(!choice) return
		show_category = choice

	if(href_list["color"])
		var/new_color = input(usr, "Choose new color:", "Items color", current_color) as color|null
		if(new_color) current_color = new_color

	if(href_list["make"] && machine_recipes)

		var/index = text2num(href_list["make"])
		var/multiplier = text2num(href_list["multiplier"])
		var/datum/autolathe/recipe/making

		if(index > 0 && index <= machine_recipes.len)
			making = machine_recipes[index]

		//Exploit detection, not sure if necessary after rewrite.
		if(!making || multiplier < 0 || multiplier > 100)
			log_game("EXPLOIT : [key_name(usr)] tried to exploit an autolathe to duplicate an item!", src)
			return

		busy = 1
		update_use_power(2)

		var/list/required = making.resources
		for(var/material in required)
			required[material] *= mat_efficiency

		//Check if we still have the materials.
		for(var/material in required)
			if(!isnull(stored_material[material]))
				if(stored_material[material] < required[material] * multiplier)
					return

		//Consume materials.
		for(var/material in required)
			if(!isnull(stored_material[material]))
				stored_material[material] = max(0, stored_material[material] - required[material] * multiplier)

		//Fancy autolathe animation.
		flick("autolathe_n", src)

		sleep(build_time)

		busy = 0
		update_use_power(1)

		//Sanity check.
		if(!making || !src) return

		//Create the desired item.
		var/obj/item/I = new making.path(loc)
		if(multiplier > 1 && istype(I, /obj/item/stack))
			var/obj/item/stack/S = I
			S.amount = multiplier
		if(istype(I))
			for(var/material in required)
				I.matter[material] = required[material] * 0.75

		if(istype(I, /obj/item/weapon/light))
			I:brightness_color = current_color

	updateUsrDialog()

/obj/machinery/autolathe/update_icon()
	icon_state = (panel_open ? "autolathe_t" : "autolathe")

//Updates overall lathe storage size.
/obj/machinery/autolathe/RefreshParts()
	..()
	var/mb_rating = 0
	var/man_rating = 0
	for(var/obj/item/weapon/stock_parts/matter_bin/MB in component_parts)
		mb_rating += MB.rating
	for(var/obj/item/weapon/stock_parts/manipulator/M in component_parts)
		man_rating += M.rating

	storage_capacity[DEFAULT_WALL_MATERIAL] = mb_rating  * 25000
	storage_capacity["glass"] = mb_rating  * 12500
	build_time = 50 / man_rating
	mat_efficiency = 1.1 - man_rating * 0.3// Normally, price is 1.25 the amount of material, so this shouldn't go higher than 0.8. Maximum rating of parts is 3

/obj/machinery/autolathe/dismantle()

	for(var/mat in stored_material)
		create_material_stack(mat, stored_material[mat], get_turf(src))
	..()
	return 1
