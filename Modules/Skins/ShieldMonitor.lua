local T, C, L = unpack(ShestakUI)
if C.extra_skins.shield_monitor ~= true then return end

----------------------------------------------------------------------------------------
--	ShieldMonitor skin
----------------------------------------------------------------------------------------
local SMSkin = CreateFrame("Frame")
SMSkin:RegisterEvent("PLAYER_LOGIN")
SMSkin:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("shieldmonitor") then return end
	
	Shieldmonitor_Options.scale = 1
	
	shieldmonitor_Frame:SetTemplate("Default")
	
	shieldmonitor_Bar:SetStatusBarTexture(C.media.texture)
	shieldmonitor_Bar:SetHeight(16)
	shieldmonitor_Bar:ClearAllPoints()
	shieldmonitor_Bar:SetPoint("TOPRIGHT", shieldmonitor_Frame, "TOPRIGHT", -2, -2)
	
	shieldmonitor_FrameIcon1:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	
	shieldmonitor_FrameDuration:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
	shieldmonitor_FrameDuration:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	shieldmonitor_FrameDuration:ClearAllPoints()
	shieldmonitor_FrameDuration:SetPoint("LEFT", shieldmonitor_Frame, "LEFT", 22, 0)
	
	shieldmonitor_BarText:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
	shieldmonitor_BarText:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	shieldmonitor_BarText:SetPoint("CENTER", shieldmonitor_Bar, "CENTER", 0, 0)
end)