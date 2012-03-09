﻿local T, C, L = unpack(ShestakUI)
if C.extra_announce.battleground ~= true then return end

----------------------------------------------------------------------------------------
--	Battleground Defence Announcer(by Azmara)
----------------------------------------------------------------------------------------
local curmapid = GetCurrentMapAreaID()

-- Create Main Button Frame
local buttonframe = CreateFrame("Frame", "BGAnnouncerButtonFrame", UIParent)
buttonframe:CreatePanel("Invisible", 313, 20, unpack(C.extra_position.bg_announce))
if C.extra_announce.battleground_two_row == true then
	buttonframe:Size(156, 43)
end
buttonframe:Hide()
buttonframe:SetFrameStrata("BACKGROUND")
tinsert(T.MoverFrames, buttonframe)

-- Button 1
local button1 = CreateFrame("Button", "BGAnnouncerButton1", buttonframe, "SecureActionButtonTemplate")
button1:CreatePanel("Transparent", 50, 20, "TOPLEFT", buttonframe, "TOPLEFT", 0, 0)
button1:SetFrameLevel(buttonframe:GetFrameLevel() + 1)
button1:SetFrameStrata("MEDIUM")
button1:SetAttribute("type", "macro")
button1:SetAttribute("macrotext", "/bg "..L_EXTRA_ANNOUNCE_BG_LIGHT..GetMinimapZoneText())

local button1_text = button1:CreateFontString(nil, "OVERLAY")
button1_text:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
button1_text:Point("CENTER", 0, 0)
button1_text:SetText("Low")
button1:SetScript("OnEnter", T.SetModifiedBackdrop)
button1:SetScript("OnLeave", T.SetOriginalBackdrop)

-- Button 2
local button2 = CreateFrame("Button", "BGAnnouncerButton2", buttonframe, "SecureActionButtonTemplate")
button2:CreatePanel("Transparent", 50, 20, "LEFT", button1, "RIGHT", 3, 0)
button2:SetFrameLevel(buttonframe:GetFrameLevel() + 1)
button2:SetFrameStrata("MEDIUM")
button2:SetAttribute("type", "macro")
button2:SetAttribute("macrotext", "/bg "..L_EXTRA_ANNOUNCE_BG_MEDIUM..GetMinimapZoneText())

local button2_text = button2:CreateFontString(nil, "OVERLAY")
button2_text:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
button2_text:Point("CENTER", 0, 0)
button2_text:SetText("Med")
button2:SetScript("OnEnter", T.SetModifiedBackdrop)
button2:SetScript("OnLeave", T.SetOriginalBackdrop)

-- Button 3
local button3 = CreateFrame("Button", "BGAnnouncerButton3", buttonframe, "SecureActionButtonTemplate")
button3:CreatePanel("Transparent", 50, 20, "LEFT", button2, "RIGHT", 3, 0)
button3:SetFrameLevel(buttonframe:GetFrameLevel() + 1)
button3:SetFrameStrata("MEDIUM")
button3:SetAttribute("type", "macro")
button3:SetAttribute("macrotext", "/bg "..L_EXTRA_ANNOUNCE_BG_HEAVY..GetMinimapZoneText())

local button3_text = button3:CreateFontString(nil, "OVERLAY")
button3_text:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
button3_text:Point("CENTER", 0, 0)
button3_text:SetText("High")
button3:SetScript("OnEnter", T.SetModifiedBackdrop)
button3:SetScript("OnLeave", T.SetOriginalBackdrop)

-- Button 4
local button4 = CreateFrame("Button", "BGAnnouncerButton4", buttonframe, "SecureActionButtonTemplate")
button4:CreatePanel("Transparent", 50, 20, "LEFT", button3, "RIGHT", 3, 0)
if C.extra_announce.battleground_two_row == true then
	button4:Point("TOPLEFT", button1, "BOTTOMLEFT", 0, -3)
end
button4:SetFrameLevel(buttonframe:GetFrameLevel() + 1)
button4:SetFrameStrata("MEDIUM")
button4:SetAttribute("type", "macro")
button4:SetAttribute("macrotext", "/say "..L_EXTRA_ANNOUNCE_BG_FOCUS.."%t")

local button4_text = button4:CreateFontString(nil, "OVERLAY")
button4_text:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
button4_text:Point("CENTER", 0, 0)
button4_text:SetText("Focus")
button4:SetScript("OnEnter", T.SetModifiedBackdrop)
button4:SetScript("OnLeave", T.SetOriginalBackdrop)

-- Button 5
local button5 = CreateFrame("Button", "BGAnnouncerButton5", buttonframe, "SecureActionButtonTemplate")
button5:CreatePanel("Transparent", 50, 20, "LEFT", button4, "RIGHT", 3, 0)
button5:SetFrameLevel(buttonframe:GetFrameLevel() + 1)
button5:SetFrameStrata("MEDIUM")
button5:SetAttribute("type", "macro")
button5:SetAttribute("macrotext", "/say "..L_EXTRA_ANNOUNCE_BG_STEALTH)

local button5_text = button5:CreateFontString(nil, "OVERLAY")
button5_text:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
button5_text:Point("CENTER", 0, 0)
button5_text:SetText("Hidden")
button5:SetScript("OnEnter", T.SetModifiedBackdrop)
button5:SetScript("OnLeave", T.SetOriginalBackdrop)

-- Button 6
local button6 = CreateFrame("Button", "BGAnnouncerButton6", buttonframe, "SecureActionButtonTemplate")
button6:CreatePanel("Transparent", 50, 20, "LEFT", button5, "RIGHT", 3, 0)
button6:SetFrameLevel(buttonframe:GetFrameLevel() + 1)
button6:SetFrameStrata("MEDIUM")
button6:SetAttribute("type", "macro")
button6:SetAttribute("macrotext", "/bg "..L_EXTRA_ANNOUNCE_BG_CLEAR..GetMinimapZoneText())

local button6_text = button6:CreateFontString(nil, "OVERLAY")
button6_text:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
button6_text:Point("CENTER", 0, 0)
button6_text:SetText("Secure")
button6:SetScript("OnEnter", T.SetModifiedBackdrop)
button6:SetScript("OnLeave", T.SetOriginalBackdrop)

local UpdateZone = CreateFrame("Frame")
local function OnEvent(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		local inInstance, instanceType = IsInInstance()
		if inInstance and instanceType == "pvp" then
			buttonframe:Show()
		else
			buttonframe:Hide()
		end
	end

	button1:SetAttribute("macrotext", "/bg "..L_EXTRA_ANNOUNCE_BG_LIGHT..GetMinimapZoneText())
	button2:SetAttribute("macrotext", "/bg "..L_EXTRA_ANNOUNCE_BG_MEDIUM..GetMinimapZoneText())
	button3:SetAttribute("macrotext", "/bg "..L_EXTRA_ANNOUNCE_BG_HEAVY..GetMinimapZoneText())
	button6:SetAttribute("macrotext", "/bg "..L_EXTRA_ANNOUNCE_BG_CLEAR..GetMinimapZoneText())
end

UpdateZone:RegisterEvent("PLAYER_ENTERING_WORLD")
UpdateZone:RegisterEvent("ZONE_CHANGED")
UpdateZone:RegisterEvent("ZONE_CHANGED_NEW_AREA")
UpdateZone:SetScript("OnEvent", OnEvent)