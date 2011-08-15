local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	ShestakUI_Extra personal configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
--	ATTENTION: When saving changes to a file encoded file should be in UTF8
----------------------------------------------------------------------------------------
--	Configuration example:
----------------------------------------------------------------------------------------
-- if T.name == "MegaChar" then
--		C["extra_general"].click_cast = true
-- 		C["extra_general"].move_blizzard = false
--		C["extra_bar"].enable = true
--		C["extra_skins"].blizzard_frames = true
--		C["extra_position"].micro_menu = {"TOPLEFT", UIParent, "TOPLEFT", 2, -2}
-- end
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	Per Class Config (overwrite general)
--	Class need to be UPPERCASE
----------------------------------------------------------------------------------------
if T.class == "DRUID" then

end

----------------------------------------------------------------------------------------
--	Per Character Name Config (overwrite general and class)
--	Name need to be case sensitive
----------------------------------------------------------------------------------------
if T.name == "Чаккноррис" or T.name == "Нупачимучка" or T.name == "Пратифный" or T.name == "Рукалицо"
	or T.name == "Трольпаладин" or T.name == "Чаккерс" or T.name == "Релика" or T.name == "Тинейд" or T.name == "Тупаяшколота" then
	C["extra_general"].light_macro = true
	C["extra_general"].profession_tabs = true
	C["extra_skins"].blizzard_frames = true
	C["extra_skins"].minimap_buttons = true
end

----------------------------------------------------------------------------------------
--	Per Max Character Level Config (overwrite general, class and name)
----------------------------------------------------------------------------------------
if T.level ~= MAX_PLAYER_LEVEL then

end

----------------------------------------------------------------------------------------
--	My Config
----------------------------------------------------------------------------------------
if T.author == true then
	C["extra_general"].move_blizzard = true
	C["extra_general"].profession_tabs = true
	C["extra_skins"].blizzard_frames = true
end