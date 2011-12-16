local T, C, L = unpack(ShestakUI)
if C.extra_general.lw_announce ~= true then return end

----------------------------------------------------------------------------------------
--	Announce your Lightwell(Light Well Prout by Rahanprout)
----------------------------------------------------------------------------------------
local whisper_baduser = false
local baduse_threshold = 100

local lightwell_announce = CreateFrame("Frame")
lightwell_announce:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
lightwell_announce:SetScript("OnEvent", function(self, _, ...)
	local _, event, _, _, sourceName, _, _, _, destName, _, _, spellID = ...
	if sourceName == UnitName("player") then
		if event == "SPELL_AURA_APPLIED" and spellID == 7001 then
			local santemax = UnitHealthMax(destName)
			local santecurrent = UnitHealth(destName)
			local sante = santemax - santecurrent
			local pourcentagesante = math.floor((santecurrent * 100) / santemax)
			if aLw ~= nil then
				aLw[sourceName] = aLw[sourceName] - 1
				if UnitInParty(destName) or UnitInRaid(destName) then
					if sante > baduse_threshold then
						SendChatMessage(destName.." used my lightwell. ".."("..aLw[sourceName].." charge(s))", "SAY")
					else
						SendChatMessage(destName.." used my lightwell, uselessly. ".."("..aLw[sourceName].." charge(s))", "SAY")
						if whisper_baduser then
							SendChatMessage("You shouldn't have used the lightwell.", "WHISPER", nil, destName)
						end
					end
				end
			end
		elseif event == "SPELL_SUMMON" and spellID == 724 then
			chargesLw = isGlyphed()
			aLw = {}
			aLw[sourceName] = 0
			aLw[sourceName] = chargesLw
			SendChatMessage("Lightwell placed. "..chargesLw.." charges.", "SAY")
		end
	end
end)

function isGlyphed()
	for i = 7, NUM_GLYPH_SLOTS do
		local enabled, _, _, glyphSpellID = GetGlyphSocketInfo(i)
		if enabled and glyphSpellID == 55673 then
			return 15
		end
	end
	return 10
end