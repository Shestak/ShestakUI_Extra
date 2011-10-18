local T, C, L = unpack(ShestakUI)
if C.extra_skins.blood_shield_tracker ~= true then return end

----------------------------------------------------------------------------------------
--	BloodShieldTracker skin
----------------------------------------------------------------------------------------
local BSTSkin = CreateFrame("Frame")
BSTSkin:RegisterEvent("PLAYER_LOGIN")
BSTSkin:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("BloodShieldTracker") then return end

	self.db = LibStub("AceDB-3.0"):New("BloodShieldTrackerDB", defaults, "Default")

	self.db.profile.status_bar_border = false
	self.db.profile.estheal_bar_border = false
	self.db.profile.status_bar_scale = 1
	self.db.profile.estheal_bar_scale = 1
	self.db.profile.status_bar_texture = "Smooth"
	self.db.profile.estheal_bar_texture = "Smooth"

	local ShieldTrackerStatusBar = CreateFrame("Frame", "ShieldTrackerStatusBar", BloodShieldTracker_StatusBar)
	ShieldTrackerStatusBar:SetPoint("TOPLEFT", BloodShieldTracker_StatusBar, "TOPLEFT", -2, 2)
	ShieldTrackerStatusBar:SetPoint("BOTTOMRIGHT", BloodShieldTracker_StatusBar, "BOTTOMRIGHT", 2, -2)
	ShieldTrackerStatusBar:SetTemplate("Default")
	ShieldTrackerStatusBar:SetFrameStrata("BACKGROUND")

	local ShieldTrackerDamageBar = CreateFrame("Frame", "ShieldTrackerDamageBar", BloodShieldTracker_DamageBar)
	ShieldTrackerDamageBar:SetPoint("TOPLEFT", BloodShieldTracker_DamageBar, "TOPLEFT", -2, 2)
	ShieldTrackerDamageBar:SetPoint("BOTTOMRIGHT", BloodShieldTracker_DamageBar, "BOTTOMRIGHT", 2, -2)
	ShieldTrackerDamageBar:SetTemplate("Default")
	ShieldTrackerDamageBar:SetFrameStrata("BACKGROUND")

	BloodShieldTracker_StatusBar.value:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
	BloodShieldTracker_StatusBar.value:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)

	BloodShieldTracker_DamageBar.value:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
	BloodShieldTracker_DamageBar.value:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)

	BloodShieldTracker_StatusBar.time:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
	BloodShieldTracker_StatusBar.time:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
end)