local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	ShestakUI_Extra main configuration file
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	General options
----------------------------------------------------------------------------------------
C["extra_general"] = {
	["click_cast"] = false,						-- Click2cast mod
	["move_blizzard"] = true,					-- Move Blizzard frames
	["micro_menu"] = false,						-- Micro menu
	["micro_menu_mouse"] = false,				-- Micro menu on mouseover
	["arena_calc"] = true,						-- Arena calculator(/calc)
	["align"] = true,							-- Grid on screen(/align)
	["fps_announce"] = true,					-- Announce fps in guild chat(!fps)
	["buff_automator"] = false,					-- Personal buff automator
	["switch_spec"] = false,					-- Talent spec panel
	["mark_bar"] = false,						-- Mark bar
	["color_picker"] = true,					-- Improved ColorPickerFrame
}

----------------------------------------------------------------------------------------
--	Extra ActionBar options
----------------------------------------------------------------------------------------
C["extra_bar"] = {
	["enable"] = false,							-- Enable extra actionbar
	["button_size"] = 30,						-- Buttons size
	["button_space"] = 3,						-- Buttons space
	["vertical"] = false,						-- Vertical orientation
}

----------------------------------------------------------------------------------------
--	Skins options (Maybe not work correctly!!!)
----------------------------------------------------------------------------------------
C["extra_skins"] = {
	["blizzard_frames"] = false,				-- Blizzard frames skin
	["minimap_buttons"] = false,				-- Skin addons icons on minimap
	["blood_shield_tracker"] = false,			-- BloodShieldTracker skin
	["combustion_helper"] = false,				-- CombustionHelper skin
	["roll_tracker"] = false,					-- RollTracker skin
	["tiny_dps"] = false,						-- TinyDPS skin
	["skada"] = false,							-- Skada skin
	["shield_monitor"] = false,					-- ShieldMonitor skin
	["cool_line"] = false,						-- CoolLine skin
	["mfclip"] = false,							-- MFClip skin
}