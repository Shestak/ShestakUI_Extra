﻿local T, C, L, _ = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	ShestakUI_Extra main configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	Announce options
----------------------------------------------------------------------------------------
C["extra_announce"] = {
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
	-- Battleground
	["battleground"] = false,					-- Battleground defence bar for for announce
	["battleground_two_row"] = true,			-- Two row for BG bar
	-- Other
	["mark_bar"] = false,						-- Mark bar
	["switch_spec"] = false,					-- Talent spec bar
}

----------------------------------------------------------------------------------------
--	Skins options(Maybe not work correctly!!!)
----------------------------------------------------------------------------------------
C["extra_skins"] = {
	["adibags"] = false,						-- AdiBags skin(Not Ready)
	["epgp"] = false,							-- EPGP skin(Not Ready)
	["mog_it"] = false,							-- MogIt skin(Not Ready)
	["quartz"] = false,							-- Quartz skin(Not Ready)
	["shield_monitor"] = false,					-- ShieldMonitor skin
}