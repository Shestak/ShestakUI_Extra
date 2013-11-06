local T, C, L, _ = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	ShestakUI_Extra personal configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
--	ATTENTION: When saving changes to a file encoded file should be in UTF8
----------------------------------------------------------------------------------------
--	Configuration example:
----------------------------------------------------------------------------------------
-- if T.name == "MegaChar" then
--		C["extra_general"].buff_automator = true
--		C["extra_bar"].enable = true
--		C["extra_skins"].mfclip = true
--		C["extra_position"].mark_bar = {"CENTER", UIParent, "CENTER", 100, 50}
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
--	Oz@Pozzo dell'Eternità Config
----------------------------------------------------------------------------------------
if T.name == "Oz" and T.realm == "Pozzo dell'Eternità" then
	C["extra_position"].extra_bar = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -237, 24}
	C["extra_bar"].enable = true
	C["extra_bar"].mouseover = true
end
