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
	["item_count"] = true,						-- Item count in tooltip 
	["switch_spec"] = false,					-- Talent spec panel
	["mark_bar"] = false,						-- Mark bar
	["color_picker"] = true,					-- Improved ColorPickerFrame
}

----------------------------------------------------------------------------------------
--	Extra ActionBar options
----------------------------------------------------------------------------------------
C["extra_bar"] = {
	["enable"] = false,							-- 
	["button_size"] = 30,						-- 
	["button_space"] = 3,						-- 
	["vertical"] = false,						-- 
}

----------------------------------------------------------------------------------------
--	Skins options (Maybe not work correctly!!!)
----------------------------------------------------------------------------------------
C["extra_skins"] = {
	["blizzard_frames"] = true,					-- Blizzard frames skin
	["blood_shield_tracker"] = false,			-- BloodShieldTracker skin
	["combustion_helper"] = false,				-- CombustionHelper skin
	["roll_tracker"] = false,					-- RollTracker skin
	["tiny_dps"] = false,						-- TinyDPS skin
	["recount"] = false,						-- Recount skin
	["skada"] = false,							-- Skada skin
	["shield_monitor"] = false,					-- ShieldMonitor skin
	["minimap_buttons"] = true,					-- Skin addons icons on minimap
	["cool_line"] = false,						-- CoolLine skin
	["mfclip"] = false,							-- MFClip skin
}

----------------------------------------------------------------------------------------
--	Position options
----------------------------------------------------------------------------------------
C["extra_position"] = {
	["micro_menu"] = {"TOPLEFT", UIParent, "TOPLEFT", 2, -2},		-- Micro menu
	["arena_calc"] = {"CENTER", UIParent, "CENTER", 0, 0},			-- Arena calculator
	["switch_spec"] = {"CENTER", UIParent, "CENTER", 0, -200},		-- Talent spec panel
	["mark_bar"] = {"CENTER", UIParent, "CENTER", 100, 50},			-- Mark bar
	["extra_bar"] = {"BOTTOM", UIParent, "BOTTOM", 0, 100},			-- Extra bar
}