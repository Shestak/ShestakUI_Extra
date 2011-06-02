local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	Position options
----------------------------------------------------------------------------------------
C["extra_position"] = {
	["micro_menu"] = {"TOPLEFT", UIParent, "TOPLEFT", 2, -2},		-- Micro menu
	["arena_calc"] = {"CENTER", UIParent, "CENTER", 0, 0},			-- Arena calculator
	["switch_spec"] = {"CENTER", UIParent, "CENTER", 0, -200},		-- Talent spec panel
	["mark_bar"] = {"CENTER", UIParent, "CENTER", 100, 50},			-- Mark bar
	["extra_bar"] = {"BOTTOM", UIParent, "BOTTOM", 0, 100},			-- Extra bar
	["archaeology"] = {"BOTTOMRIGHT", Minimap, "TOPRIGHT", 1, 5},	-- Archaeology frame
}