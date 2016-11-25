/datum/gear
	var/display_name       //Name/index. Must be unique.
	var/description        //Description of this gear. If left blank will default to the description of the pathed item.
	var/path               //Path to item.
	var/cost = 1           //Number of points used. Items in general cost 1 point, storage/armor/gloves/special use costs 2 points.
	var/slot               //Slot to equip to.
	var/list/allowed_roles //Roles that can spawn with this item.
	var/whitelisted        //Term to check the whitelist for..
	var/sort_category = "General"

/datum/gear/New()
	..()
	if (!sort_category)
		sort_category = "[slot]"

// Attachments
/datum/gear/armpit
	display_name = "holster, armpit"
	path = /obj/item/clothing/accessory/holster/armpit
	slot = slot_tie
	allowed_roles = list("Captain", "Head of Personnel", "Security Officer", "Warden", "Head of Security","Detective","Forensic Technician")

/datum/gear/hip
	display_name = "holster, hip"
	path = /obj/item/clothing/accessory/holster/hip
	slot = slot_tie
	allowed_roles = list("Captain", "Head of Personnel", "Security Officer", "Warden", "Head of Security", "Detective","Forensic Technician")

/datum/gear/waist
	display_name = "holster, waist"
	path = /obj/item/clothing/accessory/holster/waist
	slot = slot_tie
	allowed_roles = list("Captain", "Head of Personnel", "Security Officer", "Warden", "Head of Security", "Detective","Forensic Technician")

/datum/gear/amulete
	display_name = "basic"
	slot = slot_tie

/datum/gear/amulete/aquila
	display_name = "aquila"
	path = /obj/item/clothing/accessory/amulet/aquila

/datum/gear/accessory/scarf
	display_name = "tie-scarf, black"
	path = /obj/item/clothing/accessory/scarf/black

/datum/gear/accessory/scarf/red
	display_name = "tie-scarf, red"
	path = /obj/item/clothing/accessory/scarf/red

/datum/gear/accessory/scarf/white
	display_name = "tie-scarf, white"
	path = /obj/item/clothing/accessory/scarf/white

/datum/gear/accessory/scarf/green
	display_name = "tie-scarf, green"
	path = /obj/item/clothing/accessory/scarf/green

/datum/gear/accessory/scarf/darkblue
	display_name = "tie-scarf, darkblue"
	path = /obj/item/clothing/accessory/scarf/darkblue

/datum/gear/accessory/scarf/purple
	display_name = "tie-scarf, purple"
	path = /obj/item/clothing/accessory/scarf/purple

/datum/gear/accessory/scarf/yellow
	display_name = "tie-scarf, yellow"
	path = /obj/item/clothing/accessory/scarf/yellow

/datum/gear/accessory/scarf/orange
	display_name = "tie-scarf, orange"
	path = /obj/item/clothing/accessory/scarf/orange

/datum/gear/accessory/scarf/lightblue
	display_name = "tie-scarf, lightblue"
	path = /obj/item/clothing/accessory/scarf/lightblue

/datum/gear/accessory/scarf/zebra
	display_name = "tie-scarf, zebra"
	path = /obj/item/clothing/accessory/scarf/zebra

/datum/gear/accessory/scarf/christmas
	display_name = "tie-scarf, christmas"
	path = /obj/item/clothing/accessory/scarf/christmas

/datum/gear/suspenders
	display_name = "suspenders"
	path = /obj/item/clothing/accessory/suspenders
	slot = slot_tie

/datum/gear/accessory/suitjacket
	display_name = "suit jacket, tan"
	path = /obj/item/clothing/accessory/tan_jacket

/datum/gear/accessory/suitjacket/charcoal
	display_name = "suit jacket, charcoal"
	path = /obj/item/clothing/accessory/charcoal_jacket

/datum/gear/accessory/suitjacket/navy
	display_name = "suit jacket, navy blue"
	path = /obj/item/clothing/accessory/navy_jacket

/datum/gear/accessory/suitjacket/burgundy
	display_name = "suit jacket, burgundy"
	path = /obj/item/clothing/accessory/burgundy_jacket

/datum/gear/accessory/suitjacket/checkered
	display_name = "suit jacket, checkered"
	path = /obj/item/clothing/accessory/checkered_jacket

/datum/gear/accessory/brown_vest
	display_name = "webbing, engineering"
	path = /obj/item/clothing/accessory/storage/brown_vest
	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer","Security Officer","Detective","Head of Security","Warden","Paramedic","Chief Medical Officer","Medical Doctor","Chemist","Forensic Technician")

/datum/gear/accessory/black_vest
	display_name = "webbing, security"
	path = /obj/item/clothing/accessory/storage/black_vest
	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer","Security Officer","Detective","Head of Security","Warden","Paramedic","Chief Medical Officer","Medical Doctor","Chemist","Forensic Technician")

/datum/gear/accessory/white_vest
	display_name = "webbing, medical"
	path = /obj/item/clothing/accessory/storage/white_vest
	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer","Security Officer","Detective","Head of Security","Warden","Paramedic","Chief Medical Officer","Medical Doctor","Chemist","Forensic Technician")

/datum/gear/accessory/brown_drop_pouches
	display_name = "drop pouches, engineering"
	path = /obj/item/clothing/accessory/storage/brown_drop_pouches
	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer","Security Officer","Detective","Head of Security","Warden","Paramedic","Chief Medical Officer","Medical Doctor","Chemist","Forensic Technician")

/datum/gear/accessory/black_drop_pouches
	display_name = "drop pouches, security"
	path = /obj/item/clothing/accessory/storage/black_drop_pouches
	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer","Security Officer","Detective","Head of Security","Warden","Paramedic","Chief Medical Officer","Medical Doctor","Chemist","Forensic Technician")

/datum/gear/accessory/white_drop_pouches
	display_name = "drop pouches, medical"
	path = /obj/item/clothing/accessory/storage/white_drop_pouches
	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer","Security Officer","Detective","Head of Security","Warden","Paramedic","Chief Medical Officer","Medical Doctor","Chemist","Forensic Technician")

/datum/gear/accessory/webbing
	display_name = "webbing, simple"
	path = /obj/item/clothing/accessory/storage/webbing
	cost = 2


// "Useful" items - I'm guessing things that might be used at work?

/datum/gear/briefcase
	display_name = "briefcase"
	path = /obj/item/weapon/storage/briefcase
	sort_category = "utility"
	cost = 2

/datum/gear/clipboard
	display_name = "clipboard"
	path = /obj/item/weapon/clipboard
	sort_category = "utility"

/datum/gear/folder_blue
	display_name = "folder, blue"
	path = /obj/item/weapon/folder/blue
	sort_category = "utility"

/datum/gear/folder_grey
	display_name = "folder, grey"
	path = /obj/item/weapon/folder
	sort_category = "utility"

/datum/gear/folder_red
	display_name = "folder, red"
	path = /obj/item/weapon/folder/red
	sort_category = "utility"

/datum/gear/folder_white
	display_name = "folder, white"
	path = /obj/item/weapon/folder/white
	sort_category = "utility"

/datum/gear/folder_yellow
	display_name = "folder, yellow"
	path = /obj/item/weapon/folder/yellow
	sort_category = "utility"

/datum/gear/paicard
	display_name = "personal AI device"
	path = /obj/item/device/paicard
	sort_category = "utility"
	cost = 2

// The rest of the trash.

/datum/gear/ashtray
	display_name = "ashtray, plastic"
	path = /obj/item/weapon/material/ashtray/plastic
	sort_category = "misc"

/datum/gear/smokingpipe
	display_name = "pipe, smoking"
	path = /obj/item/clothing/mask/smokable/pipe
	sort_category = "misc"

/datum/gear/cornpipe
	display_name = "pipe, corn"
	path = /obj/item/clothing/mask/smokable/pipe/cobpipe
	sort_category = "misc"

/datum/gear/matchbook
	display_name = "matchbook"
	path = /obj/item/weapon/storage/box/matches
	sort_category = "misc"

/datum/gear/zippo
	display_name = "zippo"
	path = /obj/item/weapon/flame/lighter/zippo
	sort_category = "misc"

/*/datum/gear/combitool
	display_name = "combi-tool"
	path = /obj/item/weapon/combitool
	cost = 3*/

/datum/gear/skrell_chain
	display_name = "skrell headtail-wear, female, chain"
	path = /obj/item/clothing/ears/skrell/chain
	sort_category = "ears"
	whitelisted = "Skrell"

/datum/gear/skrell_plate
	display_name = "skrell headtail-wear, male, bands"
	path = /obj/item/clothing/ears/skrell/band
	sort_category = "ears"
	whitelisted = "Skrell"

/datum/gear/skrell_cloth_male
	display_name = "skrell headtail-wear, male, cloth"
	path = /obj/item/clothing/ears/skrell/cloth_male
	sort_category = "ears"
	whitelisted = "Skrell"

/datum/gear/skrell_cloth_female
	display_name = "skrell headtail-wear, female, cloth"
	path = /obj/item/clothing/ears/skrell/cloth_female
	sort_category = "ears"
	whitelisted = "Skrell"

/datum/gear/skrell_xilobeads
	display_name = "skrell xilobeads"
	path = /obj/item/clothing/ears/skrell/xilobeads
	cost = 2
	sort_category = "ears"
	whitelisted = "Skrell"

/datum/gear/pants
	display_name = "Pants, classic jeans"
	path = /obj/item/clothing/under/pants/classicjeans
	slot = slot_w_uniform

/datum/gear/pants/blackjeans
	display_name = "Pants, black"
	path = /obj/item/clothing/under/pants/blackjeans

/datum/gear/pants/white
	display_name = "Pants, white"
	path = /obj/item/clothing/under/pants/white

/datum/gear/pants/red
	display_name = "Pants, red"
	path = /obj/item/clothing/under/pants/red

/datum/gear/pants/black
	display_name = "Pants, black"
	path = /obj/item/clothing/under/pants/black

/datum/gear/pants/track
	display_name = "Pants, track"
	path = /obj/item/clothing/under/pants/track

/datum/gear/pants/tan
	display_name = "Pants, tan"
	path = /obj/item/clothing/under/pants/tan

/datum/gear/pants/jeans
	display_name = "Pants, jeans"
	path = /obj/item/clothing/under/pants/jeans

/datum/gear/pants/khaki
	display_name = "Pants, khaki"
	path = /obj/item/clothing/under/pants/khaki

/datum/gear/pants/camo
	display_name = "Pants, camo"
	path = /obj/item/clothing/under/pants/camo

/datum/gear/aviator
	display_name = "Glasses, aviator"
	path = /obj/item/clothing/glasses/sunglasses/aviator
	cost = 2
	slot = slot_glasses

/datum/gear/varsityred
	display_name = "Varsity jacket, red"
	path = /obj/item/clothing/suit/storage/toggle/varsityred
	cost = 2
	slot = slot_wear_suit

/datum/gear/varsityblue
	display_name = "Varsity jacket, blue"
	path = /obj/item/clothing/suit/storage/toggle/varsityblue
	cost = 2
	slot = slot_wear_suit

/datum/gear/varsityblack
	display_name = "Varsity jacket, black"
	path = /obj/item/clothing/suit/storage/toggle/varsityblack
	cost = 2
	slot = slot_wear_suit

/datum/gear/varsitybrown
	display_name = "Varsity jacket, brown"
	path = /obj/item/clothing/suit/storage/toggle/varsitybrown
	cost = 2
	slot = slot_wear_suit

/datum/gear/flannel
	display_name = "grey flannel"
	path = /obj/item/clothing/suit/storage/flannel
	cost = 2
	slot = slot_wear_suit

/datum/gear/flannelred
	display_name = "red flannel"
	path = /obj/item/clothing/suit/storage/flannel/red
	cost = 2
	slot = slot_wear_suit

/datum/gear/flannelaqua
	display_name = "aqua flannel"
	path = /obj/item/clothing/suit/storage/flannel/aqua
	cost = 2
	slot = slot_wear_suit

// Belt

/datum/gear/fannypack
	display_name = "fannypack, leather"
	path = /obj/item/weapon/storage/belt/fannypack
	cost = 2

/datum/gear/fannypack/red
	display_name = "fannypack, red"
	path = /obj/item/weapon/storage/belt/fannypack/red
	cost = 2

/datum/gear/fannypack/white
	display_name = "fannypack, white"
	path = /obj/item/weapon/storage/belt/fannypack/white
	cost = 2

/datum/gear/fannypack/black
	display_name = "fannypack, black"
	path = /obj/item/weapon/storage/belt/fannypack/black
	cost = 2
