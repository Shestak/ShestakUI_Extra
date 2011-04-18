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
	local barSpacing = T.Scale(1, 1)
	local borderWidth = T.Scale(2, 2)

	-- Used to strip unecessary options from the in-game config
	local function StripOptions(options)
		options.baroptions.args.bartexture = options.windowoptions.args.height
		options.baroptions.args.bartexture.order = 12
		options.baroptions.args.bartexture.max = 1
		options.baroptions.args.barspacing = nil
		options.titleoptions.args.texture = nil
		options.titleoptions.args.bordertexture = nil
		options.titleoptions.args.thickness = nil
		options.titleoptions.args.margin = nil
		options.titleoptions.args.color = nil
		options.windowoptions = nil
		options.baroptions.args.barfont = nil
		options.titleoptions.args.font = nil
	end

	local barmod = Skada.displays["bar"]
	barmod.AddDisplayOptions_ = barmod.AddDisplayOptions
	barmod.AddDisplayOptions = function(self, win, options)
		self:AddDisplayOptions_(win, options)
		StripOptions(options)
	end

	for k, options in pairs(Skada.options.args.windows.args) do
		if options.type == "group" then
			StripOptions(options.args)
		end
	end

	-- Size height correctly
	barmod.AdjustBackgroundHeight = function(self,win)
		local numbars = 0
		if win.bargroup:GetBars() ~= nil then
			if win.db.background.height == 0 then
				for name, bar in pairs(win.bargroup:GetBars()) do if bar:IsShown() then numbars = numbars + 1 end end
			else
				numbars = win.db.barmax
			end
			if win.db.enabletitle then numbars = numbars + 1 end
			if numbars < 1 then numbars = 1 end
			local height = numbars * (win.db.barheight + barSpacing) + barSpacing + borderWidth
			if win.bargroup.bgframe:GetHeight() ~= height then
				win.bargroup.bgframe:SetHeight(height)
			end
		end
	end

	-- Override settings from in-game GUI
	local titleBG = {
		bgFile = C.media.texture,
		tile = false,
		tileSize = 0
	}

	barmod.ApplySettings_ = barmod.ApplySettings
	barmod.ApplySettings = function(self, win)
		win.db.enablebackground = false
		win.db.background.borderthickness = borderWidth
		barmod:ApplySettings_(win)

		if win.db.enabletitle then
			win.bargroup.button:SetBackdrop(titleBG)
		end
		
		win.bargroup:SetTexture(C.media.texture)
		win.bargroup:SetSpacing(barSpacing)
		win.bargroup:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		--win.bargroup:SetShadowColor(0, 0, 0, C.font.stylization_font_shadow and 1 or 0)
		win.bargroup:SetFrameLevel(5)
		
		win.overlay = CreateFrame("Frame", nil, win.bargroup)
		win.overlay:SetTemplate("Default")
		win.overlay:SetFrameStrata("BACKGROUND")
		win.overlay:SetPoint("TOPLEFT", -2, 2)
		win.overlay:SetPoint("BOTTOMRIGHT", 2, -2)
		
		local titlefont = CreateFont("TitleFont"..win.db.name)
		titlefont:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		titlefont:SetShadowColor(0, 0, 0, C.font.stylization_font_shadow and 1 or 0)
		
		win.bargroup.button:SetNormalFontObject(titlefont)
		win.bargroup.button:SetBackdropColor(unpack(C.media.border_color))
		--[[if win.bargroup.bgframe then
			win.bargroup.bgframe:SetTemplate("Transparent")
			if win.db.reversegrowth then
				win.bargroup.bgframe:SetPoint("BOTTOM", win.bargroup.button, "BOTTOM", 0, -1 * (win.db.enabletitle and 2 or 1))
			else
				win.bargroup.bgframe:SetPoint("TOP", win.bargroup.button, "TOP", 0, 1 * (win.db.enabletitle and 2 or 1))
			end
		end]]
		
		self:AdjustBackgroundHeight(win)
		win.bargroup:SetMaxBars(win.db.barmax)
		win.bargroup:SortBars()
	end

	local windows = {}

	-- Update pre-existing displays
	for _, window in ipairs(Skada:GetWindows()) do
		window:UpdateDisplay()
		tinsert(windows, window)
	end
end)