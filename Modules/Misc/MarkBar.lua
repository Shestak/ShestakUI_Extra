﻿local T, C, L = unpack(ShestakUI)
if C.extra_general.mark_bar ~= true then return end

----------------------------------------------------------------------------------------
--	Mark Bar(by Smelly)
----------------------------------------------------------------------------------------
local button_width = T.Scale(30)
local button_height = T.Scale(30)

local MarkBarBG = CreateFrame("Frame", "MarkBarBackground", UIParent)
MarkBarBG:CreatePanel("Default", (button_width * 4) + 9, (button_height * 3) - 4, unpack(C.extra_position.mark_bar))
MarkBarBG:SetBackdropColor(0, 0, 0, 0)
MarkBarBG:SetBackdropBorderColor(0, 0, 0, 0)
MarkBarBG:SetFrameLevel(0)
MarkBarBG:Hide()

local icon = CreateFrame("Button", "Icon", MarkBarBG)
local mark = CreateFrame("Button", "Menu", MarkBarBG)
for i = 1, 8 do
	mark[i] = CreateFrame("Button", "mark"..i, MarkBarBG)
	mark[i]:CreatePanel("Transparent", button_width, button_height, "LEFT", MarkBarBG, "LEFT", 0, 0)
	if i == 1 then
		mark[i]:SetPoint("TOPLEFT", MarkBarBG, "TOPLEFT", 0, 0)
	elseif i == 5 then
		mark[i]:SetPoint("TOP", mark[1], "BOTTOM", 0, -3)
	else
		mark[i]:SetPoint("LEFT", mark[i-1], "RIGHT", 3, 0)
	end
	mark[i]:EnableMouse(true)
	mark[i]:SetScript("OnEnter", T.SetModifiedBackdrop)
	mark[i]:SetScript("OnLeave", T.SetOriginalBackdrop)
	mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", i) end)
	
	icon[i] = CreateFrame("Button", "icon"..i, MarkBarBG)
	icon[i]:SetNormalTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	icon[i]:Size(25, 25)
	icon[i]:Point("CENTER", mark[i])
	
	-- Set up each button
	if i == 1 then 
		icon[i]:GetNormalTexture():SetTexCoord(0, 0.25, 0, 0.25)
	elseif i == 2 then
		icon[i]:GetNormalTexture():SetTexCoord(0.25, 0.5, 0, 0.25)
	elseif i == 3 then
		icon[i]:GetNormalTexture():SetTexCoord(0.5, 0.75, 0, 0.25)
	elseif i == 4 then
		icon[i]:GetNormalTexture():SetTexCoord(0.75, 1, 0, 0.25)
	elseif i == 5 then
		icon[i]:GetNormalTexture():SetTexCoord(0, 0.25, 0.25, 0.5)
	elseif i == 6 then
		icon[i]:GetNormalTexture():SetTexCoord(0.25, 0.5, 0.25, 0.5)
	elseif i == 7 then
		icon[i]:GetNormalTexture():SetTexCoord(0.5, 0.75, 0.25, 0.5)
	elseif i == 8 then
		icon[i]:GetNormalTexture():SetTexCoord(0.75, 1, 0.25, 0.5)
	end
end

-- Create Button for clear target
local ClearTargetButton = CreateFrame("Button", "ClearTargetButton", MarkBarBackground)
ClearTargetButton:CreatePanel("Transparent", (button_width * 4) + 9, 20, "TOPLEFT", mark[5], "BOTTOMLEFT", 0, -3)
ClearTargetButton:SetScript("OnEnter", ButtonEnter)
ClearTargetButton:SetScript("OnLeave", ButtonLeave)
ClearTargetButton:SetScript("OnMouseUp", function() SetRaidTarget("target", 0) end)
ClearTargetButton:SetFrameStrata("HIGH")

ClearTargetButtonText = T.SetFontString(ClearTargetButton, C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
ClearTargetButtonText:SetText(L_EXTRA_BUTTON_CLEAR)
ClearTargetButtonText:SetPoint("CENTER")

-- Check if we are Raid Leader or Raid Officer / Party
local function CheckRaidStatus()
	local inInstance, instanceType = IsInInstance()
	local partyMembers = GetNumPartyMembers()
 
	if not UnitInRaid("player") and partyMembers >= 1 then return true
	elseif UnitIsRaidOfficer("player") then return true
	elseif not inInstance or instanceType == "pvp" or instanceType == "arena" then return false
	end
end

-- Automatically show/hide the frame if we have Raid Leader or Raid Officer or in Party
local LeadershipCheck = CreateFrame("Frame")
LeadershipCheck:RegisterEvent("RAID_ROSTER_UPDATE")
LeadershipCheck:RegisterEvent("PARTY_MEMBERS_CHANGED")
LeadershipCheck:RegisterEvent("PLAYER_ENTERING_WORLD")
LeadershipCheck:SetScript("OnEvent", function(self, event)
	if CheckRaidStatus() then
		MarkBarBackground:Show()
	else
		MarkBarBackground:Hide()
	end
end)