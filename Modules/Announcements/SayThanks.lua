﻿local T, C, L = unpack(ShestakUI)
if C.extra_announce.says_thanks ~= true then return end

----------------------------------------------------------------------------------------
--	Says thanks for some spells(SaySapped by Bitbyte, modified by m2jest1c)
----------------------------------------------------------------------------------------
local SayThanks = CreateFrame("Frame")

local ST_Buffs = {
	[29166] = true,	-- Innervate
}

SayThanks:SetScript("OnEvent", function(_, event, _, applied, _, _, buffer, _, _, _, player, _, _, spell, ...)
	for key, value in pairs(ST_Buffs) do
		if spell == key and value == true and player == T.name and buffer ~= T.name and applied == "SPELL_AURA_APPLIED" then
			SendChatMessage(L_EXTRA_ANNOUNCE_SS_THANKS..GetSpellLink(spell)..", "..buffer, "WHISPER", nil, buffer)
			DEFAULT_CHAT_FRAME:AddMessage(GetSpellLink(spell)..L_EXTRA_ANNOUNCE_SS_RECEIVED..buffer)
		end
	end
end)
SayThanks:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")