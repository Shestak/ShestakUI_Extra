﻿local T, C, L, _ = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	Position options
--	BACKUP THIS FILE BEFORE UPDATING!
----------------------------------------------------------------------------------------
C["extra_position"] = {
	["arena_calc"] = {"CENTER", UIParent, "CENTER", 0, 0},			-- Arena calculator
	["switch_spec"] = {"CENTER", UIParent, "CENTER", 0, -200},		-- Talent spec panel
	["mark_bar"] = {"CENTER", UIParent, "CENTER", 100, 50},			-- Mark bar
	["extra_bar"] = {"BOTTOM", ActionBarAnchor, "TOP", 0, 3},		-- Extra bar
	["archaeology"] = {"BOTTOMRIGHT", Minimap, "TOPRIGHT", 2, 5},	-- Archaeology frame
	["bg_announce"] = {"CENTER", UIParent, "CENTER", 0, 0},			-- BG announce panel
	["tank_announce"] = {"BOTTOMRIGHT", Minimap, "TOPRIGHT", 2, 5},	-- Tank announce panel
}