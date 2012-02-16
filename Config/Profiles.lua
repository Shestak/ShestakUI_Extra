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
if T.name == "CharacterName" then

end

----------------------------------------------------------------------------------------
--	Per Max Character Level Config (overwrite general, class and name)
----------------------------------------------------------------------------------------
if T.level ~= MAX_PLAYER_LEVEL then

end

----------------------------------------------------------------------------------------
--	Shestak Config
----------------------------------------------------------------------------------------
if T.author == true then
	C["extra_general"].disenchanting = true
	C["extra_general"].poison = true
	C["extra_general"].item_level = true
	C["extra_general"].skip_cinematic = true
	C["extra_general"].auto_role = true
	C["extra_general"].tab_binder = true
	C["extra_general"].explore_map = true
	C["extra_announce"].lightwell = true
	C["extra_announce"].toy_train = true
	if T.class == "DRUID" then
		C["extra_general"].click_cast = true
		C["extra_general"].buff_automator = true
	end
end

----------------------------------------------------------------------------------------
--	Sw2rT1 Config
----------------------------------------------------------------------------------------
if T.name == "Чаккноррис" or T.name == "Нупачимучка" or T.name == "Пратифный"
or T.name == "Рукалицо" or T.name == "Трольпаладин" or T.name == "Чаккерс"
or T.name == "Релика" or T.name == "Тинейд" or T.name == "Тупаяшколота" then
	C["extra_general"].skip_cinematic = true
	C["extra_general"].disenchanting = true
end

----------------------------------------------------------------------------------------
--	Oz@Runetotem Config
----------------------------------------------------------------------------------------
if T.name == "Oz" and T.realm == "Runetotem" then
	C["extra_general"].move_blizzard = true
	C["extra_general"].arena_calc = true
	C["extra_general"].align = true
	C["extra_skins"].blood_shield_tracker = true
	C["extra_skins"].npcscan = true
	C["extra_skins"].roll_tracker = true
end

----------------------------------------------------------------------------------------
--	ILF7-Virinea Config
----------------------------------------------------------------------------------------
if (T.name == "Мейнстрим" or T.name == "Мейнвульф" or T.name == "Махес" or T.name == "Ночнойшорох"
or T.name == "Виринейка" or T.name == "Вирин" or T.name == "Вириней" or T.name == "Виринеа"
or T.name == "Лунорог" or T.name == "Вирка" or T.name == "Виринка") and T.realm == "Азурегос" then
	C["extra_general"].move_blizzard = true
	C["extra_general"].align = true
	C["extra_general"].color_picker = true
	C["extra_general"].skip_cinematic = true
	C["extra_general"].item_level = true
	C["extra_announce"].battleground = true
	C["extra_announce"].my_fps = true
	C["extra_skins"].atlasloot = true
	if T.name == "Мейнстрим" or T.name == "Мейнвульф" or T.name == "Махес" or T.name == "Ночнойшорох" then
		C["extra_position"].mark_bar = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -225, 160}
		C["extra_general"].mark_bar = true
		C["extra_general"].disenchanting = true
		C["extra_general"].auto_role = true
	elseif T.name == "Виринеа" then
		C["extra_announce"].lightwell = true
	end
end