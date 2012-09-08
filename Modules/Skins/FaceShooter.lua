﻿local T, C, L, _ = unpack(ShestakUI)
if C.extra_skins.face_shooter ~= true or T.class ~= "HUNTER" or T.level < 80 then return end

----------------------------------------------------------------------------------------
--	FaceShooter skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("FaceShooter") then return end

	if ttlMover then
		ttlMover.str:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		ttlMover.str:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		ttlFrame.str:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		ttlFrame.str:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	end

	button1Mover.str:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
	button1Mover.str:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)

	button1Button.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	if not button1Button.b then
		button1Button:Hide()
		button1Button.b = CreateFrame("Frame", nil, button1Button)
		button1Button.b:SetTemplate("Default")
		button1Button.b:SetFrameStrata("BACKGROUND")
		button1Button.b:Point("TOPLEFT", button1Button, "TOPLEFT", -2, 2)
		button1Button.b:Point("BOTTOMRIGHT", button1Button, "BOTTOMRIGHT", 2, -2)
	end

	if button2Mover then
		button2Mover.str:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		button2Mover.str:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)

		button2Button.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)

		if not button2Button.b then
			button2Button:Hide()
			button2Button.b = CreateFrame("Frame", nil, button2Button)
			button2Button.b:SetTemplate("Default")
			button2Button.b:SetFrameStrata("BACKGROUND")
			button2Button.b:Point("TOPLEFT", button2Button, "TOPLEFT", -2, 2)
			button2Button.b:Point("BOTTOMRIGHT", button2Button, "BOTTOMRIGHT", 2, -2)
		end
	end
end)