local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	ShestakUI_Extra main configuration file
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	General options
----------------------------------------------------------------------------------------
C["extra_general"] = {
	["click_cast"] = false,						-- Click2cast mod
	["move_blizzard"] = false,					-- Move Blizzard frames
	["arena_calc"] = false,						-- Arena calculator(/calc)
	["align"] = false,							-- Grid on screen(/align)
	["fps_announce"] = false,					-- Announce fps in guild chat(!fps)
	["buff_automator"] = false,					-- Personal buff automator
	["switch_spec"] = false,					-- Talent spec panel
	["mark_bar"] = false,						-- Mark bar
	["color_picker"] = false,					-- Improved ColorPickerFrame
	["archaeology"] = false,					-- Archaeology artifacts and cooldown
	["bg_announce"] = false,					-- Battleground defence announce
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
	["atlasloot"] = false,						-- AtlasLoot skin
	["blood_shield_tracker"] = false,			-- BloodShieldTracker skin
	["combustion_helper"] = false,				-- CombustionHelper skin
	["cool_line"] = false,						-- CoolLine skin
	["dominos"] = false,						-- Dominos skin(Not Ready)
	["epgp"] = false,							-- EPGP skin(Not Ready)
	["face_shooter"] = false,					-- FaceShooter skin
	["mfclip"] = false,							-- MFClip skin
	["npcscan"] = false,						-- NPCScan skin
	["roll_tracker"] = false,					-- RollTracker skin
	["shield_monitor"] = false,					-- ShieldMonitor skin
	["skada"] = false,							-- Skada skin(Not Ready)
	["tiny_dps"] = false,						-- TinyDPS skin
}