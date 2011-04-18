local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	ShestakUI_Extra main configuration file
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	General options
----------------------------------------------------------------------------------------
C["extra_general"] = {
	["click_cast"] = false,							-- 
	["move_blizzard"] = true,						-- Move Blizzard frames
	["micro_menu"] = false,							-- Micro menu
	["arena_calc"] = true,							-- Arena calculator(/calc)
	["align"] = true,								-- (/align)
	["fps_announce"] = true,						-- Announce fps in guild chat(!fps)
	["buff_automator"] = false,						-- 
	["item_count"] = true,							-- Item count in tooltip 
	["switch_spec"] = false,						-- Talent spec panel
}

----------------------------------------------------------------------------------------
--	Skins options (Maybe not work correctly!!!)
----------------------------------------------------------------------------------------
C["extra_skins"] = {
	["blood_shield_tracker"] = false,				-- BloodShieldTracker skin
	["combustion_helper"] = false,					-- CombustionHelper skin
	["roll_tracker"] = false,						-- RollTracker skin
	["tiny_dps"] = false,							-- TinyDPS skin
	["recount"] = false,							-- Recount skin
	["skada"] = false,								-- Skada skin
}

----------------------------------------------------------------------------------------
--	Position options
----------------------------------------------------------------------------------------
C["extra_position"] = {
	["micro_menu"] = {"TOPLEFT", UIParent, "TOPLEFT", 2, -2},		-- Micro menu
	["arena_calc"] = {"CENTER", UIParent, "CENTER", 0, 0},			-- Arena calculator
	["switch_spec"] = {"CENTER", UIParent, "CENTER", 0, -200},		-- Talent spec panel
}