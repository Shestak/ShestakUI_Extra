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
--	Skins options (Maybe not work correctly!!!)
----------------------------------------------------------------------------------------
C["extra_skins"] = {
	["barber_shop"] = false,					-- BarberShop skin
	["macro_frame"] = false,					-- Macro Frame skin
	["spellbook"] = false,						-- Spellbook skin
	["character_frame"] = false,				-- Character Frame skin
	["auction_house"] = false,					-- Auction House skin
	["talent_frame"] = false,					-- Talent Frame skin
	["blood_shield_tracker"] = false,			-- BloodShieldTracker skin
	["combustion_helper"] = false,				-- CombustionHelper skin
	["roll_tracker"] = false,					-- RollTracker skin
	["tiny_dps"] = false,						-- TinyDPS skin
	["recount"] = false,						-- Recount skin
	["skada"] = false,							-- Skada skin
	["shield_monitor"] = false,					-- ShieldMonitor skin
	["minimap_buttons"] = true,					-- Skin addons icons on minimap
	["cool_line"] = false,						-- CoolLine skin
}

----------------------------------------------------------------------------------------
--	Position options
----------------------------------------------------------------------------------------
C["extra_position"] = {
	["micro_menu"] = {"TOPLEFT", UIParent, "TOPLEFT", 2, -2},		-- Micro menu
	["arena_calc"] = {"CENTER", UIParent, "CENTER", 0, 0},			-- Arena calculator
	["switch_spec"] = {"CENTER", UIParent, "CENTER", 0, -200},		-- Talent spec panel
	["mark_bar"] = {"CENTER", UIParent, "CENTER", 100, 50},			-- Mark bar
}