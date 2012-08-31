﻿local T, C, L, _ = unpack(ShestakUI)
if C.extra_skins.tiny_dps ~= true then return end

----------------------------------------------------------------------------------------
--	TinyDPS skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("TinyDPS") then return end

	tdps.width = 221
	tdps.barHeight = 12
	tdps.spacing = 3
	tdps.border = {0, 0, 0, 0}
	tdps.backdrop = {0, 0, 0, 0}
	tdps.barbackdrop = {0, 0, 0, 0}
	tdps.swapColor = true
	tdps.showMinimapButton = false
	tdps.layout = 11
	tdpsVisibleBars = 7
	tdpsFont.name = C.font.stylization_font
	tdpsFont.size = C.font.stylization_font_size
	tdpsFont.outline = C.font.stylization_font_style
	tdpsFont.shadow = 0
	tdpsTextOffset = 0

	if tdpsStatusBar then
		tdpsStatusBar:SetStatusBarTexture(C.media.texture)

		local TDPSBar = CreateFrame("Frame", "TDPSBar", tdpsStatusBar)
		TDPSBar:SetPoint("TOPLEFT", tdpsStatusBar, "TOPLEFT", -2, 2)
		TDPSBar:SetPoint("BOTTOMRIGHT", tdpsStatusBar, "BOTTOMRIGHT", 2, -2)
		TDPSBar:SetTemplate("Default")
		TDPSBar:SetFrameStrata("BACKGROUND")
	end
end)