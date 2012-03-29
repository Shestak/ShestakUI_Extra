local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	ShestakUI_Extra main configuration file
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	General options
----------------------------------------------------------------------------------------
C["extra_general"] = {
	["click_cast"] = false,						-- Click2Cast mod
	["move_blizzard"] = false,					-- Move Blizzard frames
	["arena_calc"] = false,						-- Arena calculator(/calc)
	["align"] = false,							-- Grid on screen(/align)
	["buff_automator"] = false,					-- Personal buff automator
	["switch_spec"] = false,					-- Talent spec panel
	["mark_bar"] = false,						-- Mark bar
	["color_picker"] = false,					-- Improved ColorPickerFrame
	["archaeology"] = false,					-- Archaeology artifacts and cooldown
	["skip_cinematic"] = false,					-- Skip cinematics/movies
	["disenchanting"] = false,					-- One-click Milling, Prospecting and Disenchanting
	["poison"] = false,							-- One-click poison enchant
	["item_level"] = false,						-- Item level on slot buttons
	["auto_role"] = false,						-- Auto set role
	["tab_binder"] = false,						-- Auto change Tab key to only target enemy players
	["explore_map"] = false,					-- Tracking completion of the Explorer and Lore Master achievements in WorldMap
	["map_boss_count"] = false,					-- Show boss count in WorldMap
	["instance_lock"] = false,					-- Your instance lock status in tooltip
	["item_transmogrify"] = false,				-- Displays items can not be transmogrified
	["healer_icon"] = false,					-- Show healer icon on all enemy healers nameplate in battlegrounds
	["damage_meter_spam"] = false,				-- Merge damage meter spam in one line-link
}

----------------------------------------------------------------------------------------
--	Announce options
----------------------------------------------------------------------------------------
C["extra_announce"] = {
	-- Battleground
	["battleground"] = false,					-- Battleground defence announce
	["battleground_two_row"] = true,			-- Two row for BG panel
	-- Flask and Food
	["flask_food"] = false,						-- Announce the usage of flasks and food
	["flask_food_auto"] = false,				-- Auto announce when ReadyCheck(if enable, announce to raid channel)
	["flask_food_raid"] = false,				-- Announce to raid channel
	-- Other
	["my_fps"] = false,							-- Announce fps in guild chat(!fps)
	["lightwell"] = false,						-- Announce your Lightwell
	["toy_train"] = false,						-- Announce Toy Train set
	["bad_tank"] = false,						-- Announce taunt from not tanks
}

----------------------------------------------------------------------------------------
--	Extra Bars options
----------------------------------------------------------------------------------------
C["extra_bar"] = {
	-- ActionBar
	["enable"] = false,							-- Enable extra actionbar
	["show_grid"] = true,						-- Show empty action bar buttons
	["button_size"] = 30,						-- Buttons size
	["button_space"] = 3,						-- Buttons space
	["style"] = "4*3",							-- Buttons style(1*12|12*1|6*2|4*3)
	["mouseover"] = false,						-- Show bar on mouseover
	-- MicroMenu
	["micro_menu"] = false,						-- Enable micro menu
	["micro_menu_mouse"] = false,				-- Micro menu on mouseover
}

----------------------------------------------------------------------------------------
--	Skins options(Maybe not work correctly!!!)
----------------------------------------------------------------------------------------
C["extra_skins"] = {
	["adibags"] = false,						-- AdiBags skin(Not Ready)
	["atlasloot"] = false,						-- AtlasLoot skin
	["blood_shield_tracker"] = false,			-- BloodShieldTracker skin
	["capping"] = false,						-- Capping skin
	["cool_line"] = false,						-- CoolLine skin
	["dominos"] = false,						-- Dominos skin(Not Ready)
	["epgp"] = false,							-- EPGP skin(Not Ready)
	["face_shooter"] = false,					-- FaceShooter skin
	["mage_mana_bar"] = false,					-- MageManaBar skin
	["mage_nuggets"] = false,					-- MageNuggets skin
	["mfclip"] = false,							-- MFClip skin
	["mog_it"] = false,							-- MogIt skin(Not Ready)
	["my_role_play"] = false,					-- MyRolePlay skin
	["npcscan"] = false,						-- NPCScan skin
	["nug_running"] = false,					-- NugRunning skin
	["overachiever"] = false,					-- Overachiever skin(Not Ready)
	["preform_av"] = false,						-- PreformAVEnabler skin
	["roll_tracker"] = false,					-- RollTracker skin
	["shield_monitor"] = false,					-- ShieldMonitor skin
	["skada"] = false,							-- Skada skin(Not Ready)
	["tiny_dps"] = false,						-- TinyDPS skin
}