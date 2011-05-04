local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	Blizzard Frames skin
----------------------------------------------------------------------------------------
local function SkinScrollBar(texture)
	if _G[texture.."BG"] then _G[texture.."BG"]:SetTexture(nil) end
	_G[texture.."Top"]:SetTexture(nil)
	_G[texture.."Bottom"]:SetTexture(nil)
	_G[texture.."Middle"]:SetTexture(nil)
end

-- Tab Regions
local tabs = {
	"LeftDisabled",
	"MiddleDisabled",
	"RightDisabled",
	"Left",
	"Middle",
	"Right",
}

local function SkinTab(tab)
	if not tab then return end
	for _, object in pairs(tabs) do
		local tex = _G[tab:GetName()..object]
		tex:SetTexture(nil)
	end
	tab:GetHighlightTexture():SetTexture(nil)
	tab.backdrop = CreateFrame("Frame", nil, tab)
	tab.backdrop:SetTemplate("Transparent")
	tab.backdrop:SetFrameLevel(tab:GetFrameLevel() - 1)
	tab.backdrop:Point("TOPLEFT", 10, -3)
	tab.backdrop:Point("BOTTOMRIGHT", -10, 3)
end

local function SkinNextPrevButton(btn, horizonal)
	btn:SetTemplate("Default")
	btn:Size(btn:GetWidth() - 7, btn:GetHeight() - 7)

	if horizonal then
		btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.72, 0.65, 0.29, 0.65, 0.72)
		btn:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.8, 0.65, 0.35, 0.65, 0.8)
		btn:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)
	else
		btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.81, 0.65, 0.29, 0.65, 0.81)
		btn:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.81, 0.65, 0.35, 0.65, 0.81)
		if btn:GetDisabledTexture() then
			btn:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)
		end
	end
	btn:GetNormalTexture():ClearAllPoints()
	btn:GetNormalTexture():Point("TOPLEFT", 2, -2)
	btn:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
	btn:GetPushedTexture():SetAllPoints(btn:GetNormalTexture())
	btn:GetDisabledTexture():SetAllPoints(btn:GetNormalTexture())
	btn:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)
	btn:GetHighlightTexture():SetAllPoints(btn:GetNormalTexture())
end

local function SkinRotateButton(btn)
	btn:SetTemplate("Default")
	btn:Size(btn:GetWidth() - 14, btn:GetHeight() - 14)

	btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.65, 0.69, 0.29, 0.69, 0.65)
	btn:GetPushedTexture():SetTexCoord(0.3, 0.29, 0.3, 0.65, 0.69, 0.29, 0.69, 0.65)
	btn:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)

	btn:GetNormalTexture():ClearAllPoints()
	btn:GetNormalTexture():Point("TOPLEFT", 2, -2)
	btn:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
	btn:GetPushedTexture():SetAllPoints(btn:GetNormalTexture())
	btn:GetHighlightTexture():SetAllPoints(btn:GetNormalTexture())
end

local function SkinEditBox(frame)
	if _G[frame.."Left"] then _G[frame.."Left"]:Kill() end
	if _G[frame.."Middle"] then _G[frame.."Middle"]:Kill() end
	if _G[frame.."Right"] then _G[frame.."Right"]:Kill() end
	_G[frame]:CreateBackdrop("Default")
end

local function SkinDropDownBox(frame)
	local button = _G[frame:GetName().."Button"]

	frame:StripTextures()
	frame:Width(155)

	_G[frame:GetName().."Text"]:ClearAllPoints()
	_G[frame:GetName().."Text"]:Point("RIGHT", button, "LEFT", -2, 0)

	button:ClearAllPoints()
	button:Point("RIGHT", frame, "RIGHT", -10, 3)

	SkinNextPrevButton(button, true)

	frame:CreateBackdrop("Default")
	frame.backdrop:Point("TOPLEFT", 20, -2)
	frame.backdrop:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
end

local function SkinCheckBox(frame)
	frame:StripTextures()
	frame:CreateBackdrop("Default")
	frame.backdrop:Point("TOPLEFT", 4, -4)
	frame.backdrop:Point("BOTTOMRIGHT", -4, 4)

	frame:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	frame:SetDisabledTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
end

local SkinBlizz = CreateFrame("Frame")
SkinBlizz:RegisterEvent("ADDON_LOADED")
SkinBlizz:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") then return end
	
	-- Talent Trees
	if addon == "Blizzard_TalentUI" and C.extra_skins.talent_frame == true then
		-- Player Talents
		local buttons = {
			"PlayerTalentFrameToggleSummariesButton",
			"PlayerTalentFrameActivateButton",
		}
		PlayerTalentFrameToggleSummariesButton:Point("BOTTOM", PlayerTalentFrame, "BOTTOM", 0, 5)

		for i = 1, #buttons do
			_G[buttons[i]]:StripTextures()
			_G[buttons[i]]:SkinButton()
		end

		local StripAllTextures = {
			"PlayerTalentFrame",
			"PlayerTalentFrameInset",
			"PlayerTalentFrameTalents",
			"PlayerTalentFramePanel1",
			"PlayerTalentFramePanel2",
			"PlayerTalentFramePanel3",
			"PlayerTalentFramePanel1HeaderIcon",
			"PlayerTalentFramePanel2HeaderIcon",
			"PlayerTalentFramePanel3HeaderIcon",
			"PlayerTalentFramePetTalents",
			"PlayerTalentFramePetPanel"
		}

		for _, object in pairs(StripAllTextures) do
			_G[object]:StripTextures()
		end

		local KillTextures = {
			"PlayerTalentFramePanel1InactiveShadow",
			"PlayerTalentFramePanel2InactiveShadow",
			"PlayerTalentFramePanel3InactiveShadow",
			"PlayerTalentFramePanel1Arrow",
			"PlayerTalentFramePanel2Arrow",
			"PlayerTalentFramePanel3Arrow",
			"PlayerTalentFramePetPanelArrow",
			"PlayerTalentFramePanel1SummaryRoleIcon",
			"PlayerTalentFramePanel2SummaryRoleIcon",
			"PlayerTalentFramePanel3SummaryRoleIcon",
			"PlayerTalentFramePetShadowOverlay",
		}

		for _, texture in pairs(KillTextures) do
			_G[texture]:Kill()
		end

		PlayerTalentFrame:SetTemplate("Transparent")
		PlayerTalentFramePanel1:CreateBackdrop("Transparent")
		PlayerTalentFramePanel1.backdrop:Point("TOPLEFT", PlayerTalentFramePanel1, "TOPLEFT", 3, -3)
		PlayerTalentFramePanel1.backdrop:Point("BOTTOMRIGHT", PlayerTalentFramePanel1, "BOTTOMRIGHT", -3, 3)
		PlayerTalentFramePanel2:CreateBackdrop("Transparent")
		PlayerTalentFramePanel2.backdrop:Point("TOPLEFT", PlayerTalentFramePanel2, "TOPLEFT", 3, -3)
		PlayerTalentFramePanel2.backdrop:Point("BOTTOMRIGHT", PlayerTalentFramePanel2, "BOTTOMRIGHT", -3, 3)
		PlayerTalentFramePanel3:CreateBackdrop("Transparent")
		PlayerTalentFramePanel3.backdrop:Point("TOPLEFT", PlayerTalentFramePanel3, "TOPLEFT", 3, -3)
		PlayerTalentFramePanel3.backdrop:Point("BOTTOMRIGHT", PlayerTalentFramePanel3, "BOTTOMRIGHT", -3, 3)
		--SkinCloseButton(PlayerTalentFrameCloseButton, PlayerTalentFrame)

		function talentpairs(inspect, pet)
			local tab, tal = 1, 0
			return function()
				tal = tal + 1
				if tal>GetNumTalents(tab, inspect, pet) then
					tal = 1
					tab = tab + 1
				end
				if tab <= GetNumTalentTabs(inspect, pet) then
					return tab, tal
				end
			end
		end

		-- Skin Talent Buttons
		local function TalentButtons(self, first, i, j)
			local button = _G["PlayerTalentFramePanel"..i.."Talent"..j]
			local icon = _G["PlayerTalentFramePanel"..i.."Talent"..j.."IconTexture"]

			if first then
				button:StripTextures()
			end

			if icon then
				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				icon:ClearAllPoints()
				icon:SetAllPoints()
				button:SetFrameLevel(button:GetFrameLevel() + 1)
				button:CreateBackdrop("Default", true)
			end
		end

		local function TalentSummaryButtons(self, first, active, i, j)
			if active then
				button = _G["PlayerTalentFramePanel"..i.."SummaryActiveBonus1"]
				icon = _G["PlayerTalentFramePanel"..i.."SummaryActiveBonus1Icon"]
			else
				button = _G["PlayerTalentFramePanel"..i.."SummaryBonus"..j]
				icon = _G["PlayerTalentFramePanel"..i.."SummaryBonus"..j.."Icon"]
			end

			if first then
				button:StripTextures()
			end

			if icon then
				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button:SetFrameLevel(button:GetFrameLevel() + 1)
				local frame = CreateFrame("Frame", nil, button)
				frame:CreateBackdrop("Default", true)
				frame:SetFrameLevel(button:GetFrameLevel() - 1)
				frame:ClearAllPoints()
				frame:Point("TOPLEFT", icon, "TOPLEFT", 0, 0)
				frame:Point("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 0, 0)
			end
		end

		for i = 1, 2 do
			local tab = _G["PlayerSpecTab"..i]
			if tab then
				local a = tab:GetRegions()
				a:Hide()
				tab:StripTextures()
				tab:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
				tab:GetNormalTexture():ClearAllPoints()

				tab:GetNormalTexture():Point("TOPLEFT", 4, -2)
				tab:GetNormalTexture():Point("BOTTOMRIGHT", 0, 2)

				tab:CreateBackdrop("Default")
				tab.backdrop:ClearAllPoints()
				tab.backdrop:Point("TOPLEFT",tab:GetNormalTexture(),"TOPLEFT", -2, 2)
				tab.backdrop:Point("BOTTOMRIGHT",tab:GetNormalTexture(),"BOTTOMRIGHT", 2, -2)
				tab:StyleButton(true)
			end
		end

		local function TalentSummaryClean(i)
			frame = _G["PlayerTalentFramePanel"..i.."Summary"]
			frame:CreateBackdrop("Default")
			frame:SetFrameLevel(frame:GetFrameLevel() + 1)
			local a, b, _, d, _, _, _, _, _, _, _, _, m, _ = frame:GetRegions()
			a:Hide()
			b:Hide()
			d:Hide()
			m:Hide()
		end

		local function TalentHeaderIcon(self, first, i)
			local button = _G["PlayerTalentFramePanel"..i.."HeaderIcon"]
			local icon = _G["PlayerTalentFramePanel"..i.."HeaderIconIcon"]
			local panel = _G["PlayerTalentFramePanel"..i]
			local g = select(7, button:GetRegions())

			if first then
				button:StripTextures()
			end

			if icon then
				pointsSpent = select(5, GetTalentTabInfo(i))
				g:ClearAllPoints()
				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button:SetFrameLevel(button:GetFrameLevel() + 1)
				button:ClearAllPoints()
				button:Point("TOPLEFT",panel,"TOPLEFT", 4, -4)
				local frame = CreateFrame("Frame",nil, button)
				frame:CreateBackdrop("Default", true)
				frame:SetFrameLevel(button:GetFrameLevel() + 1)
				frame:ClearAllPoints()
				frame:Point("TOPLEFT", icon, "TOPLEFT", 0, 0)
				frame:Point("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 0, 0)
			end
		end		

		for i = 1, 3 do
			TalentSummaryClean(i)
			TalentHeaderIcon(nil, true, i)
			for j = 1, 2 do
				TalentSummaryButtons(nil, true, true, i, j)
				TalentSummaryButtons(nil, true, false, i, j)
			end
		end

		for tab, talent in talentpairs() do
			TalentButtons(nil, true, tab, talent)
		end

		for i = 1, 3 do
			SkinTab(_G["PlayerTalentFrameTab"..i])
		end

		-- Pet Talents
		SkinRotateButton(PlayerTalentFramePetModelRotateLeftButton)
		SkinRotateButton(PlayerTalentFramePetModelRotateRightButton)
		PlayerTalentFramePetModelRotateLeftButton:Point("BOTTOM", PlayerTalentFramePetModel, "BOTTOM", -4, 4)
		PlayerTalentFramePetModelRotateRightButton:Point("TOPLEFT", PlayerTalentFramePetModelRotateLeftButton, "TOPRIGHT", 4, 0)
		PlayerTalentFramePetPanel:CreateBackdrop("Transparent")
		PlayerTalentFramePetPanel.backdrop:Point("TOPLEFT", PlayerTalentFramePetPanel, "TOPLEFT", 3, -3)
		PlayerTalentFramePetPanel.backdrop:Point("BOTTOMRIGHT", PlayerTalentFramePetPanel, "BOTTOMRIGHT", -3, 3)
		PlayerTalentFramePetModel:CreateBackdrop("Transparent")
		PlayerTalentFramePetModel.backdrop:Point("TOPLEFT", PlayerTalentFramePetModel, "TOPLEFT")
		PlayerTalentFramePetModel.backdrop:Point("BOTTOMRIGHT", PlayerTalentFramePetModel, "BOTTOMRIGHT")

		local function PetHeaderIcon(self, first)
			local button = _G["PlayerTalentFramePetPanelHeaderIcon"]
			local icon = _G["PlayerTalentFramePetPanelHeaderIconIcon"]
			local panel = _G["PlayerTalentFramePetPanel"]
			local d = select(4, button:GetRegions())

			if first then
				button:StripTextures()
			end

			if icon then
				d:ClearAllPoints()
				pointsSpent = select(5, GetTalentTabInfo(1, Partycheck, true, 1))
				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button:SetFrameLevel(button:GetFrameLevel() + 1)
				button:ClearAllPoints()
				button:Point("TOPLEFT",panel,"TOPLEFT", 5, -5)
				local frame = CreateFrame("Frame",nil, button)
				frame:CreateBackdrop("Default", true)
				frame:SetFrameLevel(button:GetFrameLevel() + 1)
				frame:ClearAllPoints()
				frame:Point("TOPLEFT", icon, "TOPLEFT", 0, 0)
				frame:Point("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 0, 0)
			end
		end

		local function PetInfoIcon(self, first)
			local button = _G["PlayerTalentFramePetInfo"]
			local icon = _G["PlayerTalentFramePetIcon"]
			local panel = _G["PlayerTalentFramePetModel"]

			PlayerTalentFramePetDiet:Hide()

			local petFoodList = {GetPetFoodTypes()}
			if #petFoodList > 0 then
				diet = petFoodList[1]
			else
				diet = "None"
			end

			if first then
				button:StripTextures()
			end

			if icon then
				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button:SetFrameLevel(button:GetFrameLevel() +1)
				button:ClearAllPoints()
				button:Point("BOTTOMLEFT",panel,"TOPLEFT", 0, 10)
				local frame = CreateFrame("Frame",nil, button)
				frame:CreateBackdrop("Default", true)
				frame:SetFrameLevel(button:GetFrameLevel() + 1)
				frame:ClearAllPoints()
				frame:Point("TOPLEFT", icon, "TOPLEFT", 0, 0)
				frame:Point("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 0, 0)
			end
		end	

		local function PetTalentButtons(self, first, i)
			local button = _G["PlayerTalentFramePetPanelTalent"..i]
			local icon = _G["PlayerTalentFramePetPanelTalent"..i.."IconTexture"]

			if first then
				button:StripTextures()
			end

			if icon then
				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				icon:ClearAllPoints()
				icon:SetAllPoints()
				button:SetFrameLevel(button:GetFrameLevel() + 1)
				button:CreateBackdrop("Default", true)
			end
		end	

		PetInfoIcon(nil, true)
		PetHeaderIcon(nil, true)
		for i = 1, GetNumTalents(1, false, true) do
			PetTalentButtons(nil, true, i)
		end
	end

	if addon == "Blizzard_GlyphUI" and C.extra_skins.talent_frame == true then
		-- Glyph Tab
		GlyphFrameSparkleFrame:CreateBackdrop("Default")
		GlyphFrameSparkleFrame.backdrop:Point("TOPLEFT", GlyphFrameSparkleFrame, "TOPLEFT", 3, -3)
		GlyphFrameSparkleFrame.backdrop:Point("BOTTOMRIGHT", GlyphFrameSparkleFrame, "BOTTOMRIGHT", -3, 3)
		SkinEditBox("GlyphFrameSearchBox")
		SkinDropDownBox(GlyphFrameFilterDropDown, 212)

		for i = 1, 3 do
			_G["GlyphFrameHeader"..i]:StripTextures()
		end

		local function Glyphs(self, first, i)
			local button = _G["GlyphFrameScrollFrameButton"..i]
			local icon = _G["GlyphFrameScrollFrameButton"..i.."Icon"]

			if first then
				button:StripTextures()
			end

			if icon then
				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button:SkinButton()
			end
		end

		for i = 1, 10 do
			Glyphs(nil, true, i)
		end

		local a = select(1, GlyphFrameClearInfoFrame:GetRegions())
		a:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		local frame = CreateFrame("Frame", nil, GlyphFrameClearInfoFrame)
		frame:CreateBackdrop("Default", true)
		frame:SetFrameLevel(GlyphFrameClearInfoFrame:GetFrameLevel())
		frame:ClearAllPoints()
		frame:Point("TOPLEFT", a, "TOPLEFT", 0, 0)
		frame:Point("BOTTOMRIGHT", a, "BOTTOMRIGHT", 0, 0)

		local scrollbars = {
			"GlyphFrameScrollFrameScrollBar",
		}

		for _, texture in pairs(scrollbars) do
			SkinScrollBar(texture)
		end

		local StripAllTextures = {
			"GlyphFrameScrollFrame",
			"GlyphFrameSideInset",
			"GlyphFrameScrollFrameScrollChild",
		}

		for _, object in pairs(StripAllTextures) do
			_G[object]:StripTextures()
		end

	end

	-- Auction House
	if addon == "Blizzard_AuctionUI" and C.extra_skins.auction_house == true then
		AuctionFrame:StripTextures(true)
		AuctionFrame:SetTemplate("Transparent")

		AuctionFrameCloseButton:Point("TOPRIGHT", AuctionFrame, 4, 5)

		BrowseFilterScrollFrame:StripTextures()
		BrowseScrollFrame:StripTextures()
		AuctionsScrollFrame:StripTextures()
		BidScrollFrame:StripTextures()

		SkinDropDownBox(BrowseDropDown)
		SkinDropDownBox(PriceDropDown)
		SkinDropDownBox(DurationDropDown)

		SkinCheckBox(IsUsableCheckButton)
		SkinCheckBox(ShowOnPlayerCheckButton)

		-- Dress Up Frame
		AuctionDressUpFrame:StripTextures()
		AuctionDressUpFrame:SetTemplate("Transparent")
		AuctionDressUpFrame:Point("TOPLEFT", AuctionFrame, "TOPRIGHT", 2, 0)
		AuctionDressUpFrameResetButton:SkinButton()
		AuctionDressUpFrameCloseButton:StripTextures()
		AuctionDressUpFrameCloseButton:SetNormalTexture(AuctionFrameCloseButton:GetNormalTexture():GetTexture())
		AuctionDressUpFrameCloseButton:SetPushedTexture(AuctionFrameCloseButton:GetPushedTexture():GetTexture())
		AuctionDressUpFrameCloseButton:SetHighlightTexture(AuctionFrameCloseButton:GetHighlightTexture():GetTexture())
		AuctionDressUpFrameCloseButton:SetDisabledTexture(AuctionFrameCloseButton:GetDisabledTexture():GetTexture())

		SkinRotateButton(AuctionDressUpModelRotateLeftButton)
		SkinRotateButton(AuctionDressUpModelRotateRightButton)
		AuctionDressUpModelRotateRightButton:Point("TOPLEFT", AuctionDressUpModelRotateLeftButton, "TOPRIGHT", 4, 0)

		-- Progress Frame
		AuctionProgressFrame:StripTextures()
		AuctionProgressFrame:SetTemplate("Transparent")
		AuctionProgressFrameCancelButton:StyleButton()
		AuctionProgressFrameCancelButton:SetTemplate("Default")
		AuctionProgressFrameCancelButton:SetHitRectInsets(0, 0, 0, 0)
		AuctionProgressFrameCancelButton:GetNormalTexture():ClearAllPoints()
		AuctionProgressFrameCancelButton:GetNormalTexture():Point("TOPLEFT", 2, -2)
		AuctionProgressFrameCancelButton:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
		AuctionProgressFrameCancelButton:GetNormalTexture():SetTexCoord(0.67, 0.37, 0.61, 0.26)
		AuctionProgressFrameCancelButton:Size(28, 28)
		AuctionProgressFrameCancelButton:Point("LEFT", AuctionProgressBar, "RIGHT", 8, 0)

		AuctionProgressBarIcon:SetTexCoord(0.67, 0.37, 0.61, 0.26)

		local backdrop = CreateFrame("Frame", nil, AuctionProgressBarIcon:GetParent())
		backdrop:Point("TOPLEFT", AuctionProgressBarIcon, "TOPLEFT", -2, 2)
		backdrop:Point("BOTTOMRIGHT", AuctionProgressBarIcon, "BOTTOMRIGHT", 2, -2)
		backdrop:SetTemplate("Default")
		AuctionProgressBarIcon:SetParent(backdrop)

		AuctionProgressBarText:ClearAllPoints()
		AuctionProgressBarText:SetPoint("CENTER")

		AuctionProgressBar:StripTextures()
		AuctionProgressBar:CreateBackdrop("Default")
		AuctionProgressBar:SetStatusBarTexture(C.media.texture)
		AuctionProgressBar:SetStatusBarColor(1, 1, 0)

		SkinNextPrevButton(BrowseNextPageButton)
		SkinNextPrevButton(BrowsePrevPageButton)

		local buttons = {
			"BrowseBidButton",
			"BidBidButton",
			"BrowseBuyoutButton",
			"BidBuyoutButton",
			"BrowseCloseButton",
			"BidCloseButton",
			"BrowseSearchButton",
			"AuctionsCreateAuctionButton",
			"AuctionsCancelAuctionButton",
			"AuctionsCloseButton",
			"BrowseResetButton",
			"AuctionsStackSizeMaxButton",
			"AuctionsNumStacksMaxButton",
		}

		for _, button in pairs(buttons) do
			_G[button]:SkinButton()
		end

		-- Fix Button Positions
		AuctionsCancelAuctionButton:Point("RIGHT", AuctionsCloseButton, "LEFT", -4, 0)
		BidBuyoutButton:Point("RIGHT", BidCloseButton, "LEFT", -4, 0)
		BidBidButton:Point("RIGHT", BidBuyoutButton, "LEFT", -4, 0)
		BrowseBuyoutButton:Point("RIGHT", BrowseCloseButton, "LEFT", -4, 0)
		BrowseBidButton:Point("RIGHT", BrowseBuyoutButton, "LEFT", -4, 0)
		AuctionsItemButton:StripTextures()
		AuctionsItemButton:StyleButton()
		AuctionsItemButton:SetTemplate("Default", true)
		BrowseResetButton:Point("TOPLEFT", AuctionFrameBrowse, "TOPLEFT", 81, -74)
		BrowseSearchButton:Point("TOPRIGHT", AuctionFrameBrowse, "TOPRIGHT", 25, -34)

		AuctionsItemButton:SetScript("OnUpdate", function()
			if AuctionsItemButton:GetNormalTexture() then
				AuctionsItemButton:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
				AuctionsItemButton:GetNormalTexture():ClearAllPoints()
				AuctionsItemButton:GetNormalTexture():Point("TOPLEFT", 2, -2)
				AuctionsItemButton:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
			end
		end)

		local sorttabs = {
			"BrowseQualitySort",
			"BrowseLevelSort",
			"BrowseDurationSort",
			"BrowseHighBidderSort",
			"BrowseCurrentBidSort",
			"BidQualitySort",
			"BidLevelSort",
			"BidDurationSort",
			"BidBuyoutSort",
			"BidStatusSort",
			"BidBidSort",
			"AuctionsQualitySort",
			"AuctionsDurationSort",
			"AuctionsHighBidderSort",
			"AuctionsBidSort",
		}

		for _, sorttab in pairs(sorttabs) do
			_G[sorttab.."Left"]:Kill()
			_G[sorttab.."Middle"]:Kill()
			_G[sorttab.."Right"]:Kill()
		end

		for i = 1, 3 do
			SkinTab(_G["AuctionFrameTab"..i])
		end

		for i = 1, NUM_FILTERS_TO_DISPLAY do
			local tab = _G["AuctionFilterButton"..i]
			tab:StripTextures()
			tab:StyleButton()
		end

		local editboxs = {
			"BrowseName",
			"BrowseMinLevel",
			"BrowseMaxLevel",
			"BrowseBidPriceGold",
			"BrowseBidPriceSilver",
			"BrowseBidPriceCopper",
			"BidBidPriceGold",
			"BidBidPriceSilver",
			"BidBidPriceCopper",
			"AuctionsStackSizeEntry",
			"AuctionsNumStacksEntry",
			"StartPriceGold",
			"StartPriceSilver",
			"StartPriceCopper",
			"BuyoutPriceGold",
			"BuyoutPriceSilver",
			"BuyoutPriceCopper"
		}

		for _, editbox in pairs(editboxs) do
			SkinEditBox(editbox)
			_G[editbox]:SetTextInsets(1, 1, -1, 1)
			if editbox:find("Silver") or editbox:find("Copper") then
				_G[editbox].backdrop:Point("BOTTOMRIGHT", -12, -2)
			end
		end
		BrowseMaxLevel:Point("LEFT", BrowseMinLevel, "RIGHT", 8, 0)
		AuctionsStackSizeEntry.backdrop:SetAllPoints()
		AuctionsNumStacksEntry.backdrop:SetAllPoints()

		for i = 1, NUM_BROWSE_TO_DISPLAY do
			local button = _G["BrowseButton"..i]
			local icon = _G["BrowseButton"..i.."Item"]

			_G["BrowseButton"..i.."ItemIconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			_G["BrowseButton"..i.."ItemIconTexture"]:ClearAllPoints()
			_G["BrowseButton"..i.."ItemIconTexture"]:Point("TOPLEFT", 2, -2)
			_G["BrowseButton"..i.."ItemIconTexture"]:Point("BOTTOMRIGHT", -2, 2)

			icon:StyleButton()
			--TODO: Find a better method to ensure that the icon:GetNormalTexture doesn't return after clicking
			icon:HookScript("OnUpdate", function() icon:GetNormalTexture():Kill() end)

			icon:CreateBackdrop("Default")
			icon.backdrop:SetAllPoints()

			button:StripTextures()
			button:StyleButton()
			_G["BrowseButton"..i.."Highlight"] = button:GetHighlightTexture()
			button:GetHighlightTexture():ClearAllPoints()
			button:GetHighlightTexture():Point("TOPLEFT", icon, "TOPRIGHT", 2, 0)
			button:GetHighlightTexture():SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 5)
			button:GetPushedTexture():SetAllPoints(button:GetHighlightTexture())
		end

		for i = 1, NUM_AUCTIONS_TO_DISPLAY do
			local button = _G["AuctionsButton"..i]
			local icon = _G["AuctionsButton"..i.."Item"]

			_G["AuctionsButton"..i.."ItemIconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			_G["AuctionsButton"..i.."ItemIconTexture"].SetTexCoord = T.dummy
			_G["AuctionsButton"..i.."ItemIconTexture"]:ClearAllPoints()
			_G["AuctionsButton"..i.."ItemIconTexture"]:Point("TOPLEFT", 2, -2)
			_G["AuctionsButton"..i.."ItemIconTexture"]:Point("BOTTOMRIGHT", -2, 2)

			icon:StyleButton()
			icon:HookScript("OnUpdate", function() icon:GetNormalTexture():Kill() end)

			icon:CreateBackdrop("Default")
			icon.backdrop:SetAllPoints()

			button:StripTextures()
			button:StyleButton()
			_G["AuctionsButton"..i.."Highlight"] = button:GetHighlightTexture()
			button:GetHighlightTexture():ClearAllPoints()
			button:GetHighlightTexture():Point("TOPLEFT", icon, "TOPRIGHT", 2, 0)
			button:GetHighlightTexture():SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 5)
			button:GetPushedTexture():SetAllPoints(button:GetHighlightTexture())
		end

		for i = 1, NUM_BIDS_TO_DISPLAY do
			local button = _G["BidButton"..i]
			local icon = _G["BidButton"..i.."Item"]

			_G["BidButton"..i.."ItemIconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			_G["BidButton"..i.."ItemIconTexture"]:ClearAllPoints()
			_G["BidButton"..i.."ItemIconTexture"]:Point("TOPLEFT", 2, -2)
			_G["BidButton"..i.."ItemIconTexture"]:Point("BOTTOMRIGHT", -2, 2)

			icon:StyleButton()
			icon:HookScript("OnUpdate", function() icon:GetNormalTexture():Kill() end)

			icon:CreateBackdrop("Default")
			icon.backdrop:SetAllPoints()

			button:StripTextures()
			button:StyleButton()
			_G["BidButton"..i.."Highlight"] = button:GetHighlightTexture()
			button:GetHighlightTexture():ClearAllPoints()
			button:GetHighlightTexture():Point("TOPLEFT", icon, "TOPRIGHT", 2, 0)
			button:GetHighlightTexture():SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 5)
			button:GetPushedTexture():SetAllPoints(button:GetHighlightTexture())
		end
	end

	-- BarberShop
	if addon == "Blizzard_BarbershopUI" and C.extra_skins.barber_shop == true then
		local buttons = {
			"BarberShopFrameOkayButton",
			"BarberShopFrameCancelButton",
			"BarberShopFrameResetButton",
		}
		BarberShopFrameOkayButton:Point("RIGHT", BarberShopFrameSelector4, "BOTTOM", 2, -50)

		for i = 1, #buttons do
			_G[buttons[i]]:StripTextures()
			_G[buttons[i]]:SkinButton()
		end

		for i = 1, 4 do
			local f = _G["BarberShopFrameSelector"..i]
			local f2 = _G["BarberShopFrameSelector"..i-1]
			SkinNextPrevButton(_G["BarberShopFrameSelector"..i.."Prev"])
			SkinNextPrevButton(_G["BarberShopFrameSelector"..i.."Next"])

			if i ~= 1 then
				f:ClearAllPoints()
				f:Point("TOP", f2, "BOTTOM", 0, -3)
			end

			if f then
				f:StripTextures()
			end
		end

		BarberShopFrameSelector1:ClearAllPoints()
		BarberShopFrameSelector1:Point("TOP", 0, -12)

		BarberShopFrameResetButton:ClearAllPoints()
		BarberShopFrameResetButton:Point("BOTTOM", 0, 12)

		BarberShopFrame:StripTextures()
		BarberShopFrame:SetTemplate("Transparent")
		BarberShopFrame:Size(BarberShopFrame:GetWidth() - 30, BarberShopFrame:GetHeight() - 56)

		BarberShopFrameMoneyFrame:StripTextures()
		BarberShopFrameMoneyFrame:CreateBackdrop()
		BarberShopFrameBackground:Kill()

		BarberShopBannerFrameBGTexture:Kill()
		BarberShopBannerFrame:Kill()
	end

	-- Macro Frame
	if addon == "Blizzard_MacroUI" and C.extra_skins.macro_frame == true then
		local buttons = {
			"MacroDeleteButton",
			"MacroNewButton",
			"MacroExitButton",
			"MacroEditButton",
			"MacroFrameTab1",
			"MacroFrameTab2",
			"MacroPopupOkayButton",
			"MacroPopupCancelButton",
		}

		for i = 1, #buttons do
			_G[buttons[i]]:StripTextures()
			_G[buttons[i]]:SkinButton()
		end

		for i = 1, 2 do
			tab = _G[format("MacroFrameTab%s", i)]
			tab:Height(22)
		end
		MacroFrameTab1:Point("TOPLEFT", MacroFrame, "TOPLEFT", 85, -39)
		MacroFrameTab2:Point("LEFT", MacroFrameTab1, "RIGHT", 4, 0)

		-- General
		MacroFrame:StripTextures()
		--MacroFrame:SetTemplate("Transparent")
		local MacroBG = CreateFrame("Frame", "MacroBG", MacroFrame)
		MacroBG:CreatePanel("Transparent", 360, 470, "TOPLEFT", MacroFrame, "TOPLEFT", 0, -12)
		MacroFrame:SetFrameStrata("DIALOG")
		MacroFrameTextBackground:StripTextures()
		MacroFrameTextBackground:CreateBackdrop()
		MacroButtonScrollFrame:CreateBackdrop()
		MacroPopupFrame:StripTextures()
		MacroPopupFrame:SetTemplate("Transparent")
		MacroPopupScrollFrame:StripTextures()
		MacroPopupScrollFrame:CreateBackdrop()
		MacroPopupScrollFrame.backdrop:Point("TOPLEFT", 51, 2)
		MacroPopupScrollFrame.backdrop:Point("BOTTOMRIGHT", -4, 4)
		MacroPopupEditBox:CreateBackdrop()
		MacroPopupEditBox:StripTextures()
		MacroFrameCloseButton:Point("TOPRIGHT", MacroBG, 4, 5)

		-- Reposition edit button
		MacroEditButton:ClearAllPoints()
		MacroEditButton:Point("BOTTOMLEFT", MacroFrameSelectedMacroButton, "BOTTOMRIGHT", 10, 0)

		-- Regular scroll bar
		SkinScrollBar("MacroButtonScrollFrame")

		MacroPopupFrame:HookScript("OnShow", function(self)
			self:ClearAllPoints()
			self:Point("TOPLEFT", MacroFrame, "TOPRIGHT", -21, -12)
		end)

		-- Big icon
		MacroFrameSelectedMacroButton:StripTextures()
		MacroFrameSelectedMacroButton:StyleButton(true)
		MacroFrameSelectedMacroButton:GetNormalTexture():SetTexture(nil)
		MacroFrameSelectedMacroButton:SetTemplate("Default")
		MacroFrameSelectedMacroButtonIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		MacroFrameSelectedMacroButtonIcon:ClearAllPoints()
		MacroFrameSelectedMacroButtonIcon:Point("TOPLEFT", 2, -2)
		MacroFrameSelectedMacroButtonIcon:Point("BOTTOMRIGHT", -2, 2)

		-- Moving text
		MacroFrameCharLimitText:ClearAllPoints()
		MacroFrameCharLimitText:Point("BOTTOM", MacroFrameTextBackground, 0, -70)

		-- Skin all buttons
		for i = 1, MAX_ACCOUNT_MACROS do
			local b = _G["MacroButton"..i]
			local t = _G["MacroButton"..i.."Icon"]
			local pb = _G["MacroPopupButton"..i]
			local pt = _G["MacroPopupButton"..i.."Icon"]

			if b then
				b:StripTextures()
				b:StyleButton(true)

				b:SetTemplate("Default", true)
			end

			if t then
				t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				t:ClearAllPoints()
				t:Point("TOPLEFT", 2, -2)
				t:Point("BOTTOMRIGHT", -2, 2)
			end

			if pb then
				pb:StripTextures()
				pb:StyleButton(true)

				pb:SetTemplate("Default")
			end

			if pt then
				pt:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				pt:ClearAllPoints()
				pt:Point("TOPLEFT", 2, -2)
				pt:Point("BOTTOMRIGHT", -2, 2)
			end
		end
	end
	
	-- Stuff not in Blizzard load-on-demand
	if addon == "ShestakUI_Extra" then
		-- Spellbook
		if  C.extra_skins.spellbook == true then
			do
				local StripAllTextures = {
					"SpellBookFrame",
					"SpellBookFrameInset",
					"SpellBookSpellIconsFrame",
					"SpellBookSideTabsFrame",
					"SpellBookPageNavigationFrame",
				}

				local KillTextures = {
					"SpellBookPage1",
					"SpellBookPage2",
				}

				for _, object in pairs(StripAllTextures) do
					_G[object]:StripTextures()
				end

				for _, texture in pairs(KillTextures) do
					_G[texture]:Kill()
				end

				local pagebackdrop = CreateFrame("Frame", nil, SpellBookPage1:GetParent())
				pagebackdrop:SetTemplate("Transparent")
				pagebackdrop:Point("TOPLEFT", SpellBookFrame, "TOPLEFT", 50, -50)
				pagebackdrop:Point("BOTTOMRIGHT", SpellBookPage1, "BOTTOMRIGHT", 5, 35)

				SkinNextPrevButton(SpellBookPrevPageButton)
				SkinNextPrevButton(SpellBookNextPageButton)

				-- Skin SpellButtons
				local function SpellButtons(self, first)
					for i = 1, SPELLS_PER_PAGE do
						local button = _G["SpellButton"..i]
						local icon = _G["SpellButton"..i.."IconTexture"]

						if first then
							button:StripTextures()
						end

						if _G["SpellButton"..i.."Highlight"] then
							_G["SpellButton"..i.."Highlight"]:SetTexture(1, 1, 1, 0.3)
							_G["SpellButton"..i.."Highlight"]:ClearAllPoints()
							_G["SpellButton"..i.."Highlight"]:SetAllPoints(icon)
						end

						if icon then
							icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
							icon:ClearAllPoints()
							icon:SetAllPoints()

							button:SetFrameLevel(button:GetFrameLevel() + 2)
							if not button.backdrop then
								button:CreateBackdrop("Default", true)
							end
						end
					end
				end
				SpellButtons(nil, true)
				hooksecurefunc("SpellButton_UpdateButton", SpellButtons)

				-- Skill Line Tabs
				for i = 1, MAX_SKILLLINE_TABS do
					local tab = _G["SpellBookSkillLineTab"..i]
					if tab then
						tab:StripTextures()
						tab:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
						tab:GetNormalTexture():ClearAllPoints()

						tab:GetNormalTexture():Point("TOPLEFT", 2, -2)
						tab:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)

						tab:CreateBackdrop("Default")
						tab.backdrop:SetAllPoints()
						tab:StyleButton(true)

						local point, relatedTo, point2, x, y = tab:GetPoint()
						tab:Point(point, relatedTo, point2, 16, -1)
					end
				end

				--SpellBookFrame:SetTemplate("Transparent")
				local SpellBookBG = CreateFrame("Frame", "SpellBookBG", SpellBookFrame)
				SpellBookBG:CreatePanel("Transparent", 560, 525, "TOPLEFT", SpellBookFrame, "TOPLEFT", 5, -1)

				SpellBookFrameCloseButton:Point("TOPRIGHT", SpellBookBG, 4, 5)

				-- Profession Tab
				local professionbuttons = {
					"PrimaryProfession1SpellButtonTop",
					"PrimaryProfession1SpellButtonBottom",
					"PrimaryProfession2SpellButtonTop",
					"PrimaryProfession2SpellButtonBottom",
					"SecondaryProfession1SpellButtonLeft",
					"SecondaryProfession1SpellButtonRight",
					"SecondaryProfession2SpellButtonLeft",
					"SecondaryProfession2SpellButtonRight",
					"SecondaryProfession3SpellButtonLeft",
					"SecondaryProfession3SpellButtonRight",
					"SecondaryProfession4SpellButtonLeft",
					"SecondaryProfession4SpellButtonRight",
				}

				for _, button in pairs(professionbuttons) do
					local icon = _G[button.."IconTexture"]
					local button = _G[button]
					button:StripTextures()

					if icon then
						icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
						icon:ClearAllPoints()
						icon:Point("TOPLEFT", 2, -2)
						icon:Point("BOTTOMRIGHT", -2, 2)

						button:SetFrameLevel(button:GetFrameLevel() + 2)
						if not button.backdrop then
							button:CreateBackdrop("Default", true)
							button.backdrop:SetAllPoints()
						end
					end
				end

				local professionstatusbars = {
					"PrimaryProfession1StatusBar",
					"PrimaryProfession2StatusBar",
					"SecondaryProfession1StatusBar",
					"SecondaryProfession2StatusBar",
					"SecondaryProfession3StatusBar",
					"SecondaryProfession4StatusBar",
				}

				for _, statusbar in pairs(professionstatusbars) do
					local statusbar = _G[statusbar]
					statusbar:StripTextures()
					statusbar:SetStatusBarTexture(C.media.texture)
					statusbar:SetStatusBarColor(0, 0.8, 0)
					statusbar:CreateBackdrop("Default")

					statusbar.rankText:ClearAllPoints()
					statusbar.rankText:SetPoint("CENTER")
				end

				-- Mounts/Companions
				for i = 1, NUM_COMPANIONS_PER_PAGE do
					local button = _G["SpellBookCompanionButton"..i]
					local icon = _G["SpellBookCompanionButton"..i.."IconTexture"]
					button:StripTextures()
					button:StyleButton(false)

					if icon then
						icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
						icon:ClearAllPoints()
						icon:Point("TOPLEFT", 2, -2)
						icon:Point("BOTTOMRIGHT", -2, 2)

						button:SetFrameLevel(button:GetFrameLevel() + 2)
						if not button.backdrop then
							button:CreateBackdrop("Default", true)
							button.backdrop:SetAllPoints()
						end
					end
				end

				SpellBookCompanionSummonButton:SkinButton()
				SpellBookCompanionModelFrame:StripTextures()
				SpellBookCompanionModelFrameShadowOverlay:StripTextures()
				SpellBookCompanionsModelFrame:Kill()
				SpellBookCompanionModelFrame:SetTemplate("Default")

				-- Bottom Tabs
				for i = 1, 5 do
					SkinTab(_G["SpellBookFrameTabButton"..i])
				end
				_G["SpellBookFrameTabButton1"]:ClearAllPoints()
				_G["SpellBookFrameTabButton1"]:Point("TOPLEFT", _G["SpellBookFrame"], "BOTTOMLEFT", -5, 1)
			end
		end

		-- Character Frame
		if C.extra_skins.character_frame == true then
			do
				local slots = {
					"HeadSlot",
					"NeckSlot",
					"ShoulderSlot",
					"BackSlot",
					"ChestSlot",
					"ShirtSlot",
					"TabardSlot",
					"WristSlot",
					"HandsSlot",
					"WaistSlot",
					"LegsSlot",
					"FeetSlot",
					"Finger0Slot",
					"Finger1Slot",
					"Trinket0Slot",
					"Trinket1Slot",
					"MainHandSlot",
					"SecondaryHandSlot",
					"RangedSlot",
				}
				for _, slot in pairs(slots) do
					local icon = _G["Character"..slot.."IconTexture"]
					local slot = _G["Character"..slot]
					slot:StripTextures()
					slot:StyleButton(false)
					icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					icon:ClearAllPoints()
					icon:Point("TOPLEFT", 2, -2)
					icon:Point("BOTTOMRIGHT", -2, 2)

					slot:SetFrameLevel(slot:GetFrameLevel() + 2)
					slot:CreateBackdrop("Default")
					slot.backdrop:SetAllPoints()
				end

				-- Strip Textures
				local charframe = {
					"CharacterFrame",
					"CharacterModelFrame",
					"CharacterFrameInset",
					"CharacterStatsPane",
					"CharacterFrameInsetRight",
					"PaperDollSidebarTabs",
					"PaperDollEquipmentManagerPane",
					"PaperDollFrameItemFlyout",
				}

				CharacterFrameExpandButton:Size(CharacterFrameExpandButton:GetWidth() - 7, CharacterFrameExpandButton:GetHeight() - 7)
				SkinNextPrevButton(CharacterFrameExpandButton)

				SkinRotateButton(CharacterModelFrameRotateLeftButton)
				SkinRotateButton(CharacterModelFrameRotateRightButton)
				CharacterModelFrameRotateLeftButton:Point("TOPLEFT", CharacterModelFrame, "TOPLEFT", 4, -4)
				CharacterModelFrameRotateRightButton:Point("TOPLEFT", CharacterModelFrameRotateLeftButton, "TOPRIGHT", 4, 0)

				-- Swap item flyout frame (shown when holding alt over a slot)
				PaperDollFrameItemFlyout:HookScript("OnShow", function()
					PaperDollFrameItemFlyoutButtons:StripTextures()

					for i = 1, PDFITEMFLYOUT_MAXITEMS do
						local button = _G["PaperDollFrameItemFlyoutButtons"..i]
						local icon = _G["PaperDollFrameItemFlyoutButtons"..i.."IconTexture"]
						if button then
							button:StyleButton(false)

							icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
							button:GetNormalTexture():SetTexture(nil)

							icon:ClearAllPoints()
							icon:Point("TOPLEFT", 2, -2)
							icon:Point("BOTTOMRIGHT", -2, 2)
							button:SetFrameLevel(button:GetFrameLevel() + 2)
							if not button.backdrop then
								button:CreateBackdrop("Default")
								button.backdrop:SetAllPoints()
							end
						end
					end
				end)

				-- Icon in upper right corner of character frame
				CharacterFramePortrait:Kill()
				CharacterModelFrame:CreateBackdrop("Default")

				local scrollbars = {
					"PaperDollTitlesPaneScrollBar",
					"PaperDollEquipmentManagerPaneScrollBar",
				}

				for _, texture in pairs(scrollbars) do
					SkinScrollBar(texture)
				end

				for _, object in pairs(charframe) do
					_G[object]:StripTextures()
				end

				-- Titles
				PaperDollTitlesPane:HookScript("OnShow", function(self)
					for x, object in pairs(PaperDollTitlesPane.buttons) do
						object.BgTop:SetTexture(nil)
						object.BgBottom:SetTexture(nil)
						object.BgMiddle:SetTexture(nil)
						object.Check:SetTexture(nil)
					end
				end)

				-- Equipement Manager
				PaperDollEquipmentManagerPaneEquipSet:SkinButton()
				PaperDollEquipmentManagerPaneSaveSet:SkinButton()
				PaperDollEquipmentManagerPaneEquipSet:Width(PaperDollEquipmentManagerPaneEquipSet:GetWidth() - 8)
				PaperDollEquipmentManagerPaneSaveSet:Width(PaperDollEquipmentManagerPaneSaveSet:GetWidth() - 8)
				PaperDollEquipmentManagerPaneEquipSet:Point("TOPLEFT", PaperDollEquipmentManagerPane, "TOPLEFT", 8, 0)
				PaperDollEquipmentManagerPaneSaveSet:Point("LEFT", PaperDollEquipmentManagerPaneEquipSet, "RIGHT", 4, 0)
				PaperDollEquipmentManagerPaneEquipSet.ButtonBackground:SetTexture(nil)
				PaperDollEquipmentManagerPane:HookScript("OnShow", function(self)
					for x, object in pairs(PaperDollEquipmentManagerPane.buttons) do
						object.BgTop:SetTexture(nil)
						object.BgBottom:SetTexture(nil)
						object.BgMiddle:SetTexture(nil)

						object.Check:SetTexture(nil)
						object.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

						if not object.backdrop then
							object:CreateBackdrop("Default")
						end

						object.backdrop:Point("TOPLEFT", object.icon, "TOPLEFT", -2, 2)
						object.backdrop:Point("BOTTOMRIGHT", object.icon, "BOTTOMRIGHT", 2, -2)
						object.icon:SetParent(object.backdrop)

						-- Making all icons the same size and position because otherwise BlizzardUI tries to attach itself to itself when it refreshes
						object.icon:SetPoint("LEFT", object, "LEFT", 4, 0)
						object.icon.SetPoint = T.dummy
						object.icon:Size(36, 36)
						object.icon.SetSize = T.dummy
					end
					GearManagerDialogPopup:StripTextures()
					GearManagerDialogPopup:SetTemplate("Transparent")
					GearManagerDialogPopup:Point("TOPLEFT", PaperDollFrame, "TOPRIGHT", 3, 0)
					GearManagerDialogPopupScrollFrame:StripTextures()
					GearManagerDialogPopupEditBox:StripTextures()
					GearManagerDialogPopupEditBox:SetTemplate("Default")
					GearManagerDialogPopupOkay:SkinButton()
					GearManagerDialogPopupCancel:SkinButton()

					for i = 1, NUM_GEARSET_ICONS_SHOWN do
						local button = _G["GearManagerDialogPopupButton"..i]
						local icon = button.icon

						if button then
							button:StripTextures()
							button:StyleButton(true)

							icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
							_G["GearManagerDialogPopupButton"..i.."Icon"]:SetTexture(nil)

							icon:ClearAllPoints()
							icon:Point("TOPLEFT", 2, -2)
							icon:Point("BOTTOMRIGHT", -2, 2)
							button:SetFrameLevel(button:GetFrameLevel() + 2)
							if not button.backdrop then
								button:CreateBackdrop("Default")
								button.backdrop:SetAllPoints()
							end
						end
					end
				end)

				-- Handle Tabs at bottom of character frame
				for i = 1, 4 do
					SkinTab(_G["CharacterFrameTab"..i])
				end

				-- Buttons used to toggle between equipment manager, titles, and character stats
				local function FixSidebarTabCoords()
					for i = 1, #PAPERDOLL_SIDEBARS do
						local tab = _G["PaperDollSidebarTab"..i]
						if tab then
							tab.Highlight:SetTexture(1, 1, 1, 0.3)
							tab.Highlight:Point("TOPLEFT", 3, -4)
							tab.Highlight:Point("BOTTOMRIGHT", -1, 0)
							tab.Hider:SetTexture(0.4, 0.4, 0.4, 0.4)
							tab.Hider:Point("TOPLEFT", 3, -4)
							tab.Hider:Point("BOTTOMRIGHT", -1, 0)
							tab.TabBg:Kill()

							if i == 1 then
								for i=1, tab:GetNumRegions() do
									local region = select(i, tab:GetRegions())
									region:SetTexCoord(0.16, 0.86, 0.16, 0.86)
									region.SetTexCoord = T.dummy
								end
							end
							tab:CreateBackdrop("Default")
							tab.backdrop:Point("TOPLEFT", 1, -2)
							tab.backdrop:Point("BOTTOMRIGHT", 1, -2)
						end
					end
				end
				hooksecurefunc("PaperDollFrame_UpdateSidebarTabs", FixSidebarTabCoords)

				-- Stat panels, atm it looks like 7 is the max
				for i = 1, 7 do
					_G["CharacterStatsPaneCategory"..i]:StripTextures()
				end

				-- Reputation
				local function UpdateFactionSkins()
					ReputationListScrollFrame:StripTextures()
					for i = 1, GetNumFactions() do
						local statusbar = _G["ReputationBar"..i.."ReputationBar"]

						if statusbar then
							statusbar:SetStatusBarTexture(C.media.texture)

							if not statusbar.backdrop then
								statusbar:CreateBackdrop("Default")
							end

							_G["ReputationBar"..i.."Background"]:SetTexture(nil)
							_G["ReputationBar"..i.."LeftLine"]:SetTexture(nil)
							_G["ReputationBar"..i.."BottomLine"]:SetTexture(nil)
							_G["ReputationBar"..i.."ReputationBarHighlight1"]:SetTexture(nil)
							_G["ReputationBar"..i.."ReputationBarHighlight2"]:SetTexture(nil)
							_G["ReputationBar"..i.."ReputationBarAtWarHighlight1"]:SetTexture(nil)
							_G["ReputationBar"..i.."ReputationBarAtWarHighlight2"]:SetTexture(nil)
							_G["ReputationBar"..i.."ReputationBarLeftTexture"]:SetTexture(nil)
							_G["ReputationBar"..i.."ReputationBarRightTexture"]:SetTexture(nil)
						end
					end
					ReputationDetailFrame:StripTextures()
					ReputationDetailFrame:SetTemplate("Transparent")
					ReputationDetailFrame:Point("TOPLEFT", ReputationFrame, "TOPRIGHT", 3, 0)
					ReputationDetailCloseButton:Point("TOPRIGHT", ReputationDetailFrame, "TOPRIGHT", 4, 5)
				end
				ReputationFrame:HookScript("OnShow", UpdateFactionSkins)
				hooksecurefunc("ReputationFrame_OnEvent", UpdateFactionSkins)

				-- Currency
				TokenFrame:HookScript("OnShow", function()
					for i = 1, GetCurrencyListSize() do
						local button = _G["TokenFrameContainerButton"..i]

						if button then
							button.highlight:Kill()
							button.categoryMiddle:Kill()
							button.categoryLeft:Kill()
							button.categoryRight:Kill()

							if button.icon then
								button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
							end
						end
					end
					TokenFramePopup:StripTextures()
					TokenFramePopup:SetTemplate("Transparent")
					TokenFramePopup:Point("TOPLEFT", TokenFrame, "TOPRIGHT", 3, 0)
				end)

				-- Pet
				PetModelFrame:CreateBackdrop("Default")
				PetPaperDollFrameExpBar:StripTextures()
				PetPaperDollFrameExpBar:SetStatusBarTexture(C.media.texture)
				PetPaperDollFrameExpBar:CreateBackdrop("Default")

				CharacterFrame:SetTemplate("Transparent")
				CharacterFrame:SetFrameStrata("DIALOG")
			end
		end
	end
end)