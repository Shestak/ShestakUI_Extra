local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	Temporary stuff
----------------------------------------------------------------------------------------
--[[
----------------------------------------------------------------------------------------
--	Delete "Set Focus"/"Clear Focus" from unit dropdown menu
----------------------------------------------------------------------------------------
do
	for k, v in pairs(UnitPopupMenus) do
		for x, i in pairs(UnitPopupMenus[k]) do
			if i == "SET_FOCUS" or i == "CLEAR_FOCUS" then
				table.remove(UnitPopupMenus[k], x)
			end
		end
	end
end

----------------------------------------------------------------------------------------
--	
----------------------------------------------------------------------------------------
local f = CreateFrame("Frame", nil, UIParent)
--local displayVersion = tonumber("3.0.5")

local function OnEvent(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" or event == "GUILD_ROSTER_UPDATE" then
		if IsInGuild() then
			SendAddonMessage("ShestakUI_Version", T.version, "GUILD")
		end
	elseif event == "RAID_ROSTER_UPDATE" then
		SendAddonMessage("ShestakUI_Version", T.version, "RAID")
	elseif event == "PARTY_MEMBERS_CHANGED" then
		SendAddonMessage("ShestakUI_Version", T.version, "PARTY")
	end

	if event == "CHAT_MSG_ADDON" then
		local prefix, msg, chan, sender = ...

		--if prefix == "ShestakUI_Version" and sender ~= UnitName("player") then
		if prefix == "ShestakUI_Version" then
			--if displayVersion < T.version then
				DEFAULT_CHAT_FRAME:AddMessage("Boom!!!", 1, 0, 0)
			--end
		end
	end
end

f:RegisterEvent("CHAT_MSG_ADDON")
f:RegisterEvent("GUILD_ROSTER_UPDATE")
f:RegisterEvent("RAID_ROSTER_UPDATE")
f:RegisterEvent("PARTY_MEMBERS_CHANGED")
f:SetScript("OnEvent", OnEvent)]]