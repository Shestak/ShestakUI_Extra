local T, C, L = unpack(ShestakUI)
if C.extra_announce.says_thanks ~= true then return end

----------------------------------------------------------------------------------------
--	Says thanks for some spells(by Unknown)
----------------------------------------------------------------------------------------
local SayThanks = CreateFrame("Frame")

local ST_Buffs = {
	[1] = 85767,	-- Dark Intent
	[2] = 54648,	-- Focus Magic
	[3] = 29166,	-- Innervate
}

SayThanks:SetScript("OnEvent", function(...)
	local args = {...}
	for i, v in ipairs(ST_Buffs) do
		if args[14] == v and args[11] == T.name and (args[4] == "SPELL_AURA_APPLIED" or args[4] == "SPELL_AURA_REFRESH") then
			SendChatMessage("Спасибо за "..GetSpellLink(args[14])..", "..args[7], "WHISPER", nil, args[7])
			DEFAULT_CHAT_FRAME:AddMessage(GetSpellLink(args[14]).." получено от: "..(args[7] or UNKNOWN))
		end
	end
end)
SayThanks:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")