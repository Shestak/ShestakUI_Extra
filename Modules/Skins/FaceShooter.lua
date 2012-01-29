local T, C, L = unpack(ShestakUI)
if C.extra_skins.face_shooter ~= true or T.class ~= "HUNTER" or T.level < 80 then return end

----------------------------------------------------------------------------------------
--	FaceShooter skin
----------------------------------------------------------------------------------------
local FSSkin = CreateFrame("Frame")
FSSkin:RegisterEvent("PLAYER_LOGIN")
FSSkin:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("FaceShooter") then return end

	button1Mover.str:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
	button1Mover.str:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	button2Mover.str:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
	button2Mover.str:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)

	if ttlMover then
		ttlMover.str:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		ttlMover.str:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		ttlFrame.str:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		ttlFrame.str:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	end

	button1Button.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	button2Button.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	if not button1Button.texture.b then
		button1Button.texture.b = CreateFrame("Frame", nil, button1Button)
		button1Button.texture.b:SetTemplate("Default")
		button1Button.texture.b:SetFrameStrata("BACKGROUND")
		button1Button.texture.b:Point("TOPLEFT", button1Button.texture, "TOPLEFT", -2, 2)
		button1Button.texture.b:Point("BOTTOMRIGHT", button1Button.texture, "BOTTOMRIGHT", 2, -2)
	end

	if not button2Button.texture.b then
		button2Button.texture.b = CreateFrame("Frame", nil, button1Button)
		button2Button.texture.b:SetTemplate("Default")
		button2Button.texture.b:SetFrameStrata("BACKGROUND")
		button2Button.texture.b:Point("TOPLEFT", button2Button.texture, "TOPLEFT", -2, 2)
		button2Button.texture.b:Point("BOTTOMRIGHT", button2Button.texture, "BOTTOMRIGHT", 2, -2)
	end
end)