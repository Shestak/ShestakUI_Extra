local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	ShestakUI_Extra main configuration file
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	General options
----------------------------------------------------------------------------------------
C["extra_general"] = {
	["click_cast"] = false,						-- Simple click2cast spell binder
	["move_blizzard"] = false,					-- Move Blizzard frames
	["arena_calc"] = false,						-- Arena calculator(/calc)
	["align"] = false,							-- Grid on screen(/align)
	["buff_automator"] = false,					-- Personal buff automator
	["color_picker"] = false,					-- Improved ColorPickerFrame
	["archaeology"] = false,					-- Archaeology artifacts and cooldown
	["disenchanting"] = false,					-- One-click Milling, Prospecting and Disenchanting
	["instance_lock"] = false,					-- Your instance lock status in tooltip
	["item_transmogrify"] = false,				-- Displays items can not be transmogrified
	["healer_icon"] = false,					-- Show healer icon on all enemy healers nameplate in battlegrounds
	["damage_meter_spam"] = false,				-- Merge damage meter spam in one line-link
	["sum_buyouts"] = false,					-- Sum upp all current auctions
}

----------------------------------------------------------------------------------------
--	Chat options
----------------------------------------------------------------------------------------
C["extra_chat"] = {
	["nick_alert_enable"] = false,				-- Enable nick alert warning sound
	["nick_alert_names"] = {					-- Abbreviations and nicks of your name(full name of your character does not need to enter)
		UnitName("player"),						-- You do not need to make all the exact names of your characters
		--"YourNickOrName1",
		--"YourNickOrName2",
		--"YourNickOrName3",
	},
	["nick_alert_sound"] = "Sound\\Event Sounds\\Wisp\\WispPissed1.wav",
}

----------------------------------------------------------------------------------------
--	Announce options
----------------------------------------------------------------------------------------
C["extra_announce"] = {
	-- Battleground
	["battleground"] = false,					-- Battleground defence announce
	["battleground_two_row"] = true,			-- Two row for BG panel
	-- Other
	["my_fps"] = false,							-- Announce fps in guild chat(!fps)
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
	-- Other
	["mark_bar"] = false,						-- Mark bar
	["switch_spec"] = false,					-- Talent spec panel
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
	["flyout_button"] = false,					-- FlyoutButtonCustom skin
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