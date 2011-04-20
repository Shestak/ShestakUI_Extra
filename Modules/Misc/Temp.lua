local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	Temporary stuff
----------------------------------------------------------------------------------------
--[[
----------------------------------------------------------------------------------------
--	New combo points for UF
----------------------------------------------------------------------------------------
ComboDisplay = function(self, event, unit)
	if unit == "pet" then return end
	
	local cpoints = self.CPoints
	local cp
	if (UnitHasVehicleUI("player") or UnitHasVehicleUI("vehicle")) then
		cp = GetComboPoints("vehicle", "target")
	else
		cp = GetComboPoints("player", "target")
	end

	for i = 1, MAX_COMBO_POINTS do
		if i <= cp then
			cpoints[i]:SetAlpha(1)
		else
			cpoints[i]:SetAlpha(0.35)
		end
	end
	
	if cpoints[1]:GetAlpha() == 1 then
		for i = 1, MAX_COMBO_POINTS do
			cpoints[i]:Show()
		end
	else
		for i = 1, MAX_COMBO_POINTS do
			cpoints[i]:Hide()
		end
	end
	
	if cpoints[1]:IsShown() then
		if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 19) end
	else
		if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 5) end
	end
end	

self.CPoints = CreateFrame("Frame", nil, self)
self.CPoints:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
self.CPoints:SetWidth(217)
self.CPoints:SetHeight(7)

for i = 1, 5 do					
	self.CPoints[i] = CreateFrame("StatusBar", self:GetName().."_Combo"..i, self.CPoints)
	self.CPoints[i]:SetWidth((217 - 4) / 5)
	self.CPoints[i]:SetHeight(7)
	self.CPoints[i]:SetAlpha(0.35)
	self.CPoints[i]:SetStatusBarTexture(C.media.texture)
	if i == 1 then
		self.CPoints[i]:SetPoint("LEFT", self.CPoints)
	else
		self.CPoints[i]:SetPoint("LEFT", self.CPoints[i-1], "RIGHT", 1, 0)
	end
end

self.CPoints[1]:SetStatusBarColor(0.9, 0.1, 0.1)		
self.CPoints[2]:SetStatusBarColor(0.9, 0.1, 0.1)
self.CPoints[3]:SetStatusBarColor(0.9, 0.9, 0.1)
self.CPoints[4]:SetStatusBarColor(0.9, 0.9, 0.1)
self.CPoints[5]:SetStatusBarColor(0.1, 0.9, 0.1)

self.CPoints.FrameBackdrop = CreateFrame("Frame", nil, self.CPoints[1])
self.CPoints.FrameBackdrop:SetTemplate("Default")
self.CPoints.FrameBackdrop:SetFrameStrata("BACKGROUND")
self.CPoints.FrameBackdrop:Point("TOPLEFT", self.CPoints, -2, 2)
self.CPoints.FrameBackdrop:Point("BOTTOMRIGHT", self.CPoints, 2, -2)

self.CPoints.Override = ComboDisplay

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
f:SetScript("OnEvent", OnEvent)

----------------------------------------------------------------------------------------
--	Skin addons icons on minimap
----------------------------------------------------------------------------------------
local function SkinButton(f)
	if f:GetObjectType() ~= "Button" then return end

	f:SetPushedTexture(nil)
	f:SetHighlightTexture(nil)
	f:SetDisabledTexture(nil)
	f:Size(24, 24)

	for i = 1, f:GetNumRegions() do
		local region = select(i, f:GetRegions())
		if region:GetObjectType() == "Texture" then
			local tex = region:GetTexture()

			if tex:find("Border") or tex:find("Background") then
				region:SetTexture(nil)
			else
				region:ClearAllPoints()
				region:Point("TOPLEFT", f, "TOPLEFT", 2, -2)
				region:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
				region:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			end
		end
	end

	f:SetTemplate("ClassColor")
end

local x = CreateFrame("Frame")
x:RegisterEvent("PLAYER_LOGIN")
x:SetScript("OnEvent", function(self, event)

	for i = 1, Minimap:GetNumChildren() do
		SkinButton(select(i, Minimap:GetChildren()))
	end

	self = nil
end)]]