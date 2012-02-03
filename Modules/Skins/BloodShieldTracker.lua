local T, C, L = unpack(ShestakUI)
if C.extra_skins.blood_shield_tracker ~= true or T.class ~= "DEATHKNIGHT" then return end

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
	self.db.profile.pwsbar_border = false
	self.db.profile.illumbar_border = false
	self.db.profile.healthbar_border = false
	self.db.profile.status_bar_scale = 1
	self.db.profile.estheal_bar_scale = 1
	self.db.profile.pwsbar_scale = 1
	self.db.profile.illumbar_scale = 1
	self.db.profile.healthbar_scale = 1
	self.db.profile.status_bar_texture = "Smooth"
	self.db.profile.estheal_bar_texture = "Smooth"
	self.db.profile.pwsbar_texture = "Smooth"
	self.db.profile.illumbar_texture = "Smooth"
	self.db.profile.healthbar_texture = "Smooth"

	local frames = {
		"BloodShieldTracker_StatusBar",
		"BloodShieldTracker_EstimateBar",
		"BloodShieldTracker_Shield_PWS",
		"BloodShieldTracker_Shield_IllumHeal",
		"BloodShieldTracker_HealthBar"
	}

	for i = 1, getn(frames) do
		local frame = _G[frames[i]]
		if frame then
			frame:CreateBackdrop("Default")
			frame.backdrop:Point("TOPLEFT", -2, 2)
			frame.backdrop:Point("BOTTOMRIGHT", 2, -2)

			frame.value:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			frame.value:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)

			if frame.time then
				frame.time:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
				frame.time:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
			end
		end
	end
end)