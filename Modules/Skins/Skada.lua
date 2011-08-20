local T, C, L = unpack(ShestakUI)
if C.extra_skins.skada ~= true then return end

----------------------------------------------------------------------------------------
--	Skada skin
----------------------------------------------------------------------------------------
local SkadaSkin = CreateFrame("Frame")
SkadaSkin:RegisterEvent("PLAYER_LOGIN")
SkadaSkin:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("Skada") then return end

	local Skada = Skada
	local barSpacing = T.Scale(1)
	local barmod = Skada.displays["bar"]

	-- Override settings from in-game GUI
	local titleBG = {
		bgFile = C.media.texture,
		tile = false,
		tileSize = 0
	}

	barmod.ApplySettings_ = barmod.ApplySettings
	barmod.ApplySettings = function(self, win)
		barmod.ApplySettings_(self, win)

		local skada = win.bargroup

		local titlefont = CreateFont("TitleFont"..win.db.name)
		titlefont:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		titlefont:SetShadowColor(0, 0, 0, C.font.stylization_font_shadow and 1 or 0)

		if win.db.enabletitle then
			skada.button:SetNormalFontObject(titlefont)
			skada.button:SetBackdrop(titleBG)
			skada.button:SetBackdropColor(unpack(C.media.border_color))
		end

		skada:SetTexture(C.media.texture)
		skada:SetSpacing(barSpacing)
		skada:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		--skada.timerLabel:SetShadowColor(0, 0, 0, C.font.stylization_font_shadow and 1 or 0)
		skada:SetFrameLevel(5)

		skada:SetBackdrop(nil)
		if not skada.backdrop then
			skada:CreateBackdrop('Transparent')
		end
		skada.backdrop:ClearAllPoints()
		skada.backdrop:Point('TOPLEFT', win.bargroup.button or win.bargroup, 'TOPLEFT', -2, 2)
		skada.backdrop:Point('BOTTOMRIGHT', win.bargroup, 'BOTTOMRIGHT', 2, -2)
	end

	-- Update pre-existing displays
	for _, window in ipairs(Skada:GetWindows()) do
		window:UpdateDisplay()
	end
end)