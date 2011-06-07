local T, C, L = unpack(ShestakUI)
if C.extra_skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Blizzard Frames skin
----------------------------------------------------------------------------------------
local function SkinScrollBar(frame)
	if _G[frame:GetName().."BG"] then _G[frame:GetName().."BG"]:SetTexture(nil) end
	if _G[frame:GetName().."Track"] then _G[frame:GetName().."Track"]:SetTexture(nil) end

	if _G[frame:GetName().."Top"] then
		_G[frame:GetName().."Top"]:SetTexture(nil)
		_G[frame:GetName().."Bottom"]:SetTexture(nil)
		_G[frame:GetName().."Middle"]:SetTexture(nil)
	end
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
		if tex then
			tex:SetTexture(nil)
		end
	end

	if tab.GetHighlightTexture and tab:GetHighlightTexture() then
		tab:GetHighlightTexture():SetTexture(nil)
	else
		tab:StripTextures()
	end

	tab.backdrop = CreateFrame("Frame", nil, tab)
	tab.backdrop:SetTemplate("Transparent")
	tab.backdrop:SetFrameLevel(tab:GetFrameLevel() - 1)
	tab.backdrop:Point("TOPLEFT", 10, -3)
	tab.backdrop:Point("BOTTOMRIGHT", -10, 3)
end

local function SkinNextPrevButton(btn, horizonal)
	btn:SetTemplate("Overlay")
	btn:Size(btn:GetWidth() - 7, btn:GetHeight() - 7)

	if horizonal then
		btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.72, 0.65, 0.29, 0.65, 0.72)
		btn:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.8, 0.65, 0.35, 0.65, 0.8)
		btn:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)
	else
		btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.81, 0.65, 0.29, 0.65, 0.81)
		if btn:GetPushedTexture() then
			btn:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.81, 0.65, 0.35, 0.65, 0.81)
		end
		if btn:GetDisabledTexture() then
			btn:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)
		end
	end

	btn:GetNormalTexture():ClearAllPoints()
	btn:GetNormalTexture():Point("TOPLEFT", 2, -2)
	btn:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
	if btn:GetDisabledTexture() then
		btn:GetDisabledTexture():SetAllPoints(btn:GetNormalTexture())
	end
	if btn:GetPushedTexture() then
		btn:GetPushedTexture():SetAllPoints(btn:GetNormalTexture())
	end
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
	if _G[frame:GetName().."Left"] then _G[frame:GetName().."Left"]:Kill() end
	if _G[frame:GetName().."Middle"] then _G[frame:GetName().."Middle"]:Kill() end
	if _G[frame:GetName().."Right"] then _G[frame:GetName().."Right"]:Kill() end
	if _G[frame:GetName().."Mid"] then _G[frame:GetName().."Mid"]:Kill() end
	frame:CreateBackdrop("Overlay")

	if frame:GetName() and frame:GetName():find("Silver") or frame:GetName():find("Copper") then
		frame.backdrop:Point("BOTTOMRIGHT", -12, -2)
	end
end

local function SkinDropDownBox(frame, width)
	local button = _G[frame:GetName().."Button"]
	if not width then width = 155 end

	frame:StripTextures()
	frame:Width(width)

	_G[frame:GetName().."Text"]:ClearAllPoints()
	_G[frame:GetName().."Text"]:Point("RIGHT", button, "LEFT", -2, 0)

	button:ClearAllPoints()
	button:Point("RIGHT", frame, "RIGHT", -10, 3)
	button.SetPoint = T.dummy

	SkinNextPrevButton(button, true)

	frame:CreateBackdrop("Overlay")
	frame.backdrop:Point("TOPLEFT", 20, -2)
	frame.backdrop:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
end

local function SkinCheckBox(frame)
	frame:StripTextures()
	frame:CreateBackdrop("Overlay")
	frame.backdrop:Point("TOPLEFT", 4, -4)
	frame.backdrop:Point("BOTTOMRIGHT", -4, 4)

	if frame.SetCheckedTexture then
		frame:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	end

	if frame.SetDisabledTexture then
		frame:SetDisabledTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
	end

	if not frame:GetChecked() then
		frame:SetDisabledTexture(nil)
	else
		frame:SetDisabledTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
	end

	frame.SetNormalTexture = T.dummy
	frame.SetPushedTexture = T.dummy
	frame.SetHighlightTexture = T.dummy
end

local function SkinCloseButton(f, point)
	if f.SetNormalTexture then f:SetNormalTexture("") end
	if f.SetHighlightTexture then f:SetHighlightTexture("")	end
	if f.SetPushedTexture then f:SetPushedTexture("") end
	if f.SetDisabledTexture then f:SetDisabledTexture("") end

	f:SetTemplate("Overlay")
	f:Size(18, 18)

	local text = f:FontString(nil, C.media.normal_font, 17)
	text:SetPoint("CENTER", 0, 1)
	text:SetText("x")

	if point then
		f:Point("TOPRIGHT", point, "TOPRIGHT", -4, -4)
	else
		f:Point("TOPRIGHT", -4, -4)
	end

	for i = 1, f:GetNumRegions() do
		local region = select(i, f:GetRegions())
		if region:GetObjectType() == "Texture" then
			if region:GetTexture() == "Interface\\DialogFrame\\UI-DialogBox-Corner" then
				region:Kill()
			end
		end
	end

	f:HookScript("OnEnter", T.SetModifiedBackdrop)
	f:HookScript("OnLeave", T.SetOriginalBackdrop)
end

local SkinBlizz = CreateFrame("Frame")
SkinBlizz:RegisterEvent("ADDON_LOADED")
SkinBlizz:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") then return end

	-- TimeManager
	if addon == "Blizzard_TimeManager" then
		TimeManagerFrame:StripTextures()
		TimeManagerFrame:CreateBackdrop("Transparent")
		TimeManagerFrame.backdrop:Point("TOPLEFT", 0, 0)
		TimeManagerFrame.backdrop:Point("BOTTOMRIGHT", -50, 0)

		SkinCloseButton(TimeManagerCloseButton, TimeManagerFrame.backdrop)

		SkinDropDownBox(TimeManagerAlarmHourDropDown, 70)
		SkinDropDownBox(TimeManagerAlarmMinuteDropDown, 70)
		SkinDropDownBox(TimeManagerAlarmAMPMDropDown, 70)

		SkinEditBox(TimeManagerAlarmMessageEditBox)
		TimeManagerAlarmMessageEditBox:Height(TimeManagerAlarmMessageEditBox:GetHeight() - 5)

		TimeManagerAlarmEnabledButton:SkinButton(true)
		TimeManagerAlarmEnabledButton:HookScript("OnClick", function(self)
			self:SkinButton()
		end)

		TimeManagerFrame:HookScript("OnShow", function(self)
			TimeManagerAlarmEnabledButton:SkinButton()
		end)

		SkinCheckBox(TimeManagerMilitaryTimeCheck)
		SkinCheckBox(TimeManagerLocalTimeCheck)

		TimeManagerStopwatchFrame:StripTextures()
		TimeManagerStopwatchCheck:SetTemplate("Default")
		TimeManagerStopwatchCheck:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
		TimeManagerStopwatchCheck:GetNormalTexture():ClearAllPoints()
		TimeManagerStopwatchCheck:GetNormalTexture():Point("TOPLEFT", 2, -2)
		TimeManagerStopwatchCheck:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
		local hover = TimeManagerStopwatchCheck:CreateTexture("Frame", nil, TimeManagerStopwatchCheck)
		hover:SetTexture(1, 1, 1, 0.3)
		hover:Point("TOPLEFT", TimeManagerStopwatchCheck, 2, -2)
		hover:Point("BOTTOMRIGHT", TimeManagerStopwatchCheck, -2, 2)
		TimeManagerStopwatchCheck:SetHighlightTexture(hover)

		StopwatchFrame:StripTextures()
		StopwatchFrame:CreateBackdrop("Transparent")
		StopwatchFrame.backdrop:Point("TOPLEFT", 2, -15)
		StopwatchFrame.backdrop:Point("BOTTOMRIGHT", -2, 2)

		StopwatchTabFrame:StripTextures()

		SkinCloseButton(StopwatchCloseButton)
		SkinNextPrevButton(StopwatchPlayPauseButton)
		SkinNextPrevButton(StopwatchResetButton)
		StopwatchPlayPauseButton:Point("RIGHT", StopwatchResetButton, "LEFT", -4, 0)
		StopwatchResetButton:Point("BOTTOMRIGHT", StopwatchFrame, "BOTTOMRIGHT", -7, 7)
		StopwatchCloseButton:ClearAllPoints()
		StopwatchCloseButton:Point("BOTTOMRIGHT", StopwatchFrame.backdrop, "TOPRIGHT", 0, 3)
	end

	-- ReforgingUI
	if addon == "Blizzard_ReforgingUI" then
		ReforgingFrame:StripTextures()
		ReforgingFrame:SetTemplate("Transparent")

		ReforgingFrameTopInset:StripTextures()
		ReforgingFrameInset:StripTextures()
		ReforgingFrameBottomInset:StripTextures()

		ReforgingFrameRestoreButton:SkinButton(true)
		ReforgingFrameReforgeButton:SkinButton(true)

		SkinDropDownBox(ReforgingFrameFilterOldStat, 180)
		SkinDropDownBox(ReforgingFrameFilterNewStat, 180)

		ReforgingFrameItemButton:StripTextures()
		ReforgingFrameItemButton:SetTemplate("Default", true)
		ReforgingFrameItemButton:StyleButton()
		ReforgingFrameItemButtonIconTexture:ClearAllPoints()
		ReforgingFrameItemButtonIconTexture:Point("TOPLEFT", 2, -2)
		ReforgingFrameItemButtonIconTexture:Point("BOTTOMRIGHT", -2, 2)

		hooksecurefunc("ReforgingFrame_Update", function(self)
			local currentReforge, icon, name, quality, bound, cost = GetReforgeItemInfo()
			if icon then
				ReforgingFrameItemButtonIconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			else
				ReforgingFrameItemButtonIconTexture:SetTexture(nil)
			end
		end)

		SkinCloseButton(ReforgingFrameCloseButton)
	end

	-- Calendar
	if addon == "Blizzard_Calendar" then
		local frames = {
			"CalendarFrame",
		}

		for _, frame in pairs(frames) do
			_G[frame]:StripTextures()
		end

		CalendarFrame:SetTemplate("Transparent")
		SkinCloseButton(CalendarCloseButton)

		SkinNextPrevButton(CalendarPrevMonthButton)
		SkinNextPrevButton(CalendarNextMonthButton)

		-- Dropdown button
		do
			local frame = CalendarFilterFrame
			local button = CalendarFilterButton

			frame:StripTextures()
			frame:Width(155)

			_G[frame:GetName().."Text"]:ClearAllPoints()
			_G[frame:GetName().."Text"]:Point("RIGHT", button, "LEFT", -2, 0)

			button:ClearAllPoints()
			button:Point("RIGHT", frame, "RIGHT", -10, 3)
			button.SetPoint = T.dummy

			SkinNextPrevButton(button, true)

			frame:CreateBackdrop("Default")
			frame.backdrop:Point("TOPLEFT", 20, 2)
			frame.backdrop:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
		end

		-- Backdrop
		local bg = CreateFrame("Frame", "CalendarFrameBackdrop", CalendarFrame)
		bg:SetTemplate("Default")
		bg:Point("TOPLEFT", 10, -72)
		bg:Point("BOTTOMRIGHT", -8, 3)

		CalendarContextMenu:SetTemplate("Transparent")
		CalendarContextMenu.SetBackdropColor = T.dummy
		CalendarContextMenu.SetBackdropBorderColor = T.dummy

		-- Boost frame levels
		for i = 1, 42 do
			_G["CalendarDayButton"..i]:SetFrameLevel(_G["CalendarDayButton"..i]:GetFrameLevel() + 1)
		end

		-- CreateEventFrame
		CalendarCreateEventFrame:StripTextures()
		CalendarCreateEventFrame:SetTemplate("Transparent")
		CalendarCreateEventFrame:Point("TOPLEFT", CalendarFrame, "TOPRIGHT", 3, 0)
		CalendarCreateEventTitleFrame:StripTextures()

		CalendarCreateEventCreateButton:SkinButton(true)
		CalendarCreateEventMassInviteButton:SkinButton(true)
		CalendarCreateEventInviteButton:SkinButton(true)
		CalendarCreateEventInviteButton:Point("TOPLEFT", CalendarCreateEventInviteEdit, "TOPRIGHT", 4, 2)
		CalendarCreateEventInviteEdit:Width(CalendarCreateEventInviteEdit:GetWidth() - 2)
		CalendarCreateEventInviteEdit:Height(CalendarCreateEventInviteEdit:GetHeight() - 2)
		CalendarCreateEventInviteEdit:Point("TOPLEFT", CalendarCreateEventInviteList, "BOTTOMLEFT", 2, -3)

		CalendarCreateEventInviteList:StripTextures()
		CalendarCreateEventInviteList:SetTemplate("Overlay")

		SkinEditBox(CalendarCreateEventInviteEdit)
		SkinEditBox(CalendarCreateEventTitleEdit)
		SkinDropDownBox(CalendarCreateEventTypeDropDown, 120)

		CalendarCreateEventDescriptionContainer:StripTextures()
		CalendarCreateEventDescriptionContainer:SetTemplate("Overlay")

		SkinCloseButton(CalendarCreateEventCloseButton)

		SkinCheckBox(CalendarCreateEventLockEventCheck)

		SkinDropDownBox(CalendarCreateEventHourDropDown, 68)
		SkinDropDownBox(CalendarCreateEventMinuteDropDown, 68)
		SkinDropDownBox(CalendarCreateEventAMPMDropDown, 68)
		SkinDropDownBox(CalendarCreateEventRepeatOptionDropDown, 120)
		CalendarCreateEventIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		CalendarCreateEventIcon.SetTexCoord = T.dummy

		CalendarCreateEventInviteListSection:StripTextures()

		CalendarClassButtonContainer:HookScript("OnShow", function()
			for i, class in ipairs(CLASS_SORT_ORDER) do
				local button = _G["CalendarClassButton"..i]
				button:StripTextures()
				button:CreateBackdrop("Default")

				local tcoords = CLASS_ICON_TCOORDS[class]
				local buttonIcon = button:GetNormalTexture()
				buttonIcon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
				buttonIcon:SetTexCoord(tcoords[1] + 0.015, tcoords[2] - 0.02, tcoords[3] + 0.018, tcoords[4] - 0.02)
			end

			CalendarClassButton1:Point("TOPLEFT", CalendarClassButtonContainer, "TOPLEFT", 5, 0)

			CalendarClassTotalsButton:StripTextures()
			CalendarClassTotalsButton:CreateBackdrop("Default")
		end)

		-- Texture Picker Frame
		CalendarTexturePickerFrame:StripTextures()
		CalendarTexturePickerTitleFrame:StripTextures()
		CalendarTexturePickerFrame:SetTemplate("Transparent")

		SkinScrollBar(CalendarTexturePickerScrollBar)
		SkinScrollBar(CalendarViewEventInviteListScrollFrameScrollBar)
		CalendarTexturePickerAcceptButton:SkinButton(true)
		CalendarTexturePickerCancelButton:SkinButton(true)
		CalendarCreateEventRaidInviteButton:SkinButton(true)

		-- Mass Invite Frame
		CalendarMassInviteFrame:StripTextures()
		CalendarMassInviteFrame:SetTemplate("Overlay")
		CalendarMassInviteTitleFrame:StripTextures()

		SkinCloseButton(CalendarMassInviteCloseButton)
		CalendarMassInviteGuildAcceptButton:SkinButton()
		CalendarMassInviteArenaButton2:SkinButton()
		CalendarMassInviteArenaButton3:SkinButton()
		CalendarMassInviteArenaButton5:SkinButton()
		SkinDropDownBox(CalendarMassInviteGuildRankMenu, 130)

		SkinEditBox(CalendarMassInviteGuildMinLevelEdit)
		SkinEditBox(CalendarMassInviteGuildMaxLevelEdit)

		-- Raid View
		CalendarViewRaidFrame:StripTextures()
		CalendarViewRaidFrame:SetTemplate("Transparent")
		CalendarViewRaidFrame:Point("TOPLEFT", CalendarFrame, "TOPRIGHT", 3, 0)
		CalendarViewRaidTitleFrame:StripTextures()
		SkinCloseButton(CalendarViewRaidCloseButton)

		-- Holiday View
		CalendarViewHolidayFrame:StripTextures(true)
		CalendarViewHolidayFrame:SetTemplate("Transparent")
		CalendarViewHolidayFrame:Point("TOPLEFT", CalendarFrame, "TOPRIGHT", 3, 0)
		CalendarViewHolidayTitleFrame:StripTextures()
		SkinCloseButton(CalendarViewHolidayCloseButton)

		-- Event View
		CalendarViewEventFrame:StripTextures()
		CalendarViewEventFrame:SetTemplate("Transparent")
		CalendarViewEventFrame:Point("TOPLEFT", CalendarFrame, "TOPRIGHT", 3, 0)
		CalendarViewEventTitleFrame:StripTextures()
		CalendarViewEventDescriptionContainer:StripTextures()
		CalendarViewEventDescriptionContainer:SetTemplate("Overlay")
		CalendarViewEventInviteList:StripTextures()
		CalendarViewEventInviteList:SetTemplate("Overlay")
		CalendarViewEventInviteListSection:StripTextures()
		SkinCloseButton(CalendarViewEventCloseButton)

		local buttons = {
			"CalendarViewEventAcceptButton",
			"CalendarViewEventTentativeButton",
			"CalendarViewEventRemoveButton",
			"CalendarViewEventDeclineButton",
		}

		for _, button in pairs(buttons) do
			_G[button]:SkinButton()
		end
	end

	-- AchievementUI
	if addon == "Blizzard_AchievementUI" then
		local frames = {
			"AchievementFrame",
			"AchievementFrameCategories",
			"AchievementFrameSummary",
			"AchievementFrameHeader",
			"AchievementFrameSummaryCategoriesHeader",
			"AchievementFrameSummaryAchievementsHeader",
			"AchievementFrameStatsBG",
			"AchievementFrameAchievements",
			"AchievementFrameComparison",
			"AchievementFrameComparisonHeader",
			"AchievementFrameComparisonSummaryPlayer",
			"AchievementFrameComparisonSummaryFriend",
		}

		for _, frame in pairs(frames) do
			_G[frame]:StripTextures(true)
		end

		local noname_frames = {
			"AchievementFrameStats",
			"AchievementFrameSummary",
			"AchievementFrameAchievements",
			"AchievementFrameComparison"
		}

		for _, frame in pairs(noname_frames) do
			for i = 1, _G[frame]:GetNumChildren() do
				local child = select(i, _G[frame]:GetChildren())
				if child and not child:GetName() then
					child:SetBackdrop(nil)
				end
			end
		end

		AchievementFrame:CreateBackdrop("Transparent")
		AchievementFrame.backdrop:Point("TOPLEFT", 0, 6)
		AchievementFrame.backdrop:SetPoint("BOTTOMRIGHT")
		AchievementFrameHeaderTitle:ClearAllPoints()
		AchievementFrameHeaderTitle:Point("TOPLEFT", AchievementFrame.backdrop, "TOPLEFT", -22, -8)
		AchievementFrameHeaderPoints:ClearAllPoints()
		AchievementFrameHeaderPoints:Point("LEFT", AchievementFrameHeaderTitle, "RIGHT", 2, 0)

		-- Backdrops
		AchievementFrameCategoriesContainer:CreateBackdrop("Overlay")
		AchievementFrameCategoriesContainer.backdrop:Point("TOPLEFT", 0, 4)
		AchievementFrameCategoriesContainer.backdrop:Point("BOTTOMRIGHT", -2, -3)
		AchievementFrameAchievementsContainer:CreateBackdrop("Overlay")
		AchievementFrameAchievementsContainer.backdrop:Point("TOPLEFT", -3, 2)
		AchievementFrameAchievementsContainer.backdrop:Point("BOTTOMRIGHT", -3, -3)
		AchievementFrameStatsContainer:CreateBackdrop("Overlay")
		AchievementFrameStatsContainer.backdrop:Point("TOPLEFT", -2, 2)
		AchievementFrameStatsContainer.backdrop:Point("BOTTOMRIGHT", -2, -3)
		AchievementFrameComparisonStatsContainer:CreateBackdrop("Overlay")
		AchievementFrameComparisonStatsContainer.backdrop:Point("TOPLEFT", -3, 2)
		AchievementFrameComparisonStatsContainer.backdrop:Point("BOTTOMRIGHT", -2, -3)

		SkinCloseButton(AchievementFrameCloseButton, AchievementFrame.backdrop)
		SkinDropDownBox(AchievementFrameFilterDropDown)
		AchievementFrameFilterDropDown:Point("TOPRIGHT", AchievementFrame, "TOPRIGHT", -44, 5)

		-- ScrollBars
		SkinScrollBar(AchievementFrameCategoriesContainerScrollBar)
		SkinScrollBar(AchievementFrameAchievementsContainerScrollBar)
		SkinScrollBar(AchievementFrameStatsContainerScrollBar)
		SkinScrollBar(AchievementFrameComparisonContainerScrollBar)
		SkinScrollBar(AchievementFrameComparisonStatsContainerScrollBar)

		-- Tabs
		for i = 1, 3 do
			SkinTab(_G["AchievementFrameTab"..i])
			_G["AchievementFrameTab"..i]:SetFrameLevel(_G["AchievementFrameTab"..i]:GetFrameLevel() + 2)
		end

		local function SkinStatusBar(bar)
			bar:StripTextures()
			bar:SetStatusBarTexture(C.media.texture)
			bar:SetStatusBarColor(0, 0.7, 0.1)
			bar:CreateBackdrop("Overlay")

			if _G[bar:GetName().."Title"] then
				_G[bar:GetName().."Title"]:SetPoint("LEFT", 4, 0)
			end

			if _G[bar:GetName().."Label"] then
				_G[bar:GetName().."Label"]:SetPoint("LEFT", 4, 0)
			end

			if _G[bar:GetName().."Text"] then
				_G[bar:GetName().."Text"]:SetPoint("RIGHT", -4, 0)
			end
		end

		SkinStatusBar(AchievementFrameSummaryCategoriesStatusBar)
		SkinStatusBar(AchievementFrameComparisonSummaryPlayerStatusBar)
		SkinStatusBar(AchievementFrameComparisonSummaryFriendStatusBar)
		AchievementFrameComparisonSummaryFriendStatusBar.text:ClearAllPoints()
		AchievementFrameComparisonSummaryFriendStatusBar.text:SetPoint("CENTER")
		AchievementFrameComparisonHeader:Point("BOTTOMRIGHT", AchievementFrameComparison, "TOPRIGHT", 45, -20)

		for i = 1, 8 do
			local frame = _G["AchievementFrameSummaryCategoriesCategory"..i]
			local button = _G["AchievementFrameSummaryCategoriesCategory"..i.."Button"]
			local highlight = _G["AchievementFrameSummaryCategoriesCategory"..i.."ButtonHighlight"]
			SkinStatusBar(frame)
			button:StripTextures()
			highlight:StripTextures()

			_G[highlight:GetName().."Middle"]:SetTexture(1, 1, 1, 0.3)
			_G[highlight:GetName().."Middle"]:SetAllPoints(frame)
		end

		AchievementFrame:HookScript("OnShow", function()
			for i = 1, 20 do
				local frame = _G["AchievementFrameCategoriesContainerButton"..i]
				local lastframe = _G["AchievementFrameCategoriesContainerButton"..i-1]

				frame:StripTextures()
				frame:StyleButton()
			end
		end)

		hooksecurefunc("AchievementFrameSummary_UpdateAchievements", function()
			for i = 1, ACHIEVEMENTUI_MAX_SUMMARY_ACHIEVEMENTS do
				local frame = _G["AchievementFrameSummaryAchievement"..i]
				_G["AchievementFrameSummaryAchievement"..i.."Highlight"]:Kill()
				frame:StripTextures()

				_G["AchievementFrameSummaryAchievement"..i.."Description"]:SetTextColor(0.6, 0.6, 0.6)

				if not frame.backdrop then
					frame:CreateBackdrop("Overlay", true)
					frame.backdrop:Point("TOPLEFT", 2, -2)
					frame.backdrop:Point("BOTTOMRIGHT", -2, 2)

					_G["AchievementFrameSummaryAchievement"..i.."IconBling"]:Kill()
					_G["AchievementFrameSummaryAchievement"..i.."IconOverlay"]:Kill()
					_G["AchievementFrameSummaryAchievement"..i.."Icon"]:SetTemplate("Default")
					_G["AchievementFrameSummaryAchievement"..i.."Icon"]:Height(_G["AchievementFrameSummaryAchievement"..i.."Icon"]:GetHeight() - 14)
					_G["AchievementFrameSummaryAchievement"..i.."Icon"]:Width(_G["AchievementFrameSummaryAchievement"..i.."Icon"]:GetWidth() - 14)
					_G["AchievementFrameSummaryAchievement"..i.."Icon"]:ClearAllPoints()
					_G["AchievementFrameSummaryAchievement"..i.."Icon"]:Point("LEFT", 6, 0)
					_G["AchievementFrameSummaryAchievement"..i.."IconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					_G["AchievementFrameSummaryAchievement"..i.."IconTexture"]:ClearAllPoints()
					_G["AchievementFrameSummaryAchievement"..i.."IconTexture"]:Point("TOPLEFT", 2, -2)
					_G["AchievementFrameSummaryAchievement"..i.."IconTexture"]:Point("BOTTOMRIGHT", -2, 2)
				end
			end
		end)

		for i = 1, 7 do
			local frame = _G["AchievementFrameAchievementsContainerButton"..i]
			_G["AchievementFrameAchievementsContainerButton"..i.."Highlight"]:Kill()
			frame:StripTextures()
			frame.SetBackdropBorderColor = T.dummy

			-- Initiate method of creating a backdrop
			frame.bg1 = frame:CreateTexture(nil, "BACKGROUND")
			frame.bg1:SetDrawLayer("BACKGROUND", 4)
			frame.bg1:SetTexture(C.media.blank)
			frame.bg1:SetVertexColor(0.1, 0.1, 0.1)
			frame.bg1:Point("TOPLEFT", T.mult * 4, -T.mult * 4)
			frame.bg1:Point("BOTTOMRIGHT", -T.mult * 4, T.mult * 4)

			frame.bg2 = frame:CreateTexture(nil, "BACKGROUND")
			frame.bg2:SetDrawLayer("BACKGROUND", 3)
			frame.bg2:SetTexture(0, 0, 0)
			frame.bg2:Point("TOPLEFT", T.mult * 3, -T.mult * 3)
			frame.bg2:Point("BOTTOMRIGHT", -T.mult * 3, T.mult * 3)

			frame.bg3 = frame:CreateTexture(nil, "BACKGROUND")
			frame.bg3:SetDrawLayer("BACKGROUND", 2)
			frame.bg3:SetTexture(unpack(C.media.border_color))
			frame.bg3:Point("TOPLEFT", T.mult * 2, -T.mult * 2)
			frame.bg3:Point("BOTTOMRIGHT", -T.mult * 2, T.mult * 2)

			frame.bg4 = frame:CreateTexture(nil, "BACKGROUND")
			frame.bg4:SetDrawLayer("BACKGROUND", 1)
			frame.bg4:SetTexture(0, 0, 0)
			frame.bg4:Point("TOPLEFT", T.mult, -T.mult)
			frame.bg4:Point("BOTTOMRIGHT", -T.mult, T.mult)

			_G["AchievementFrameAchievementsContainerButton"..i.."Description"]:SetTextColor(0.6, 0.6, 0.6)
			_G["AchievementFrameAchievementsContainerButton"..i.."Description"].SetTextColor = T.dummy
			_G["AchievementFrameAchievementsContainerButton"..i.."HiddenDescription"]:SetTextColor(1, 1, 1)
			_G["AchievementFrameAchievementsContainerButton"..i.."HiddenDescription"].SetTextColor = T.dummy

			_G["AchievementFrameAchievementsContainerButton"..i.."IconBling"]:Kill()
			_G["AchievementFrameAchievementsContainerButton"..i.."IconOverlay"]:Kill()
			_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:SetTemplate("Default")
			_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:Height(_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:GetHeight() - 14)
			_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:Width(_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:GetWidth() - 14)
			_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:ClearAllPoints()
			_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:Point("LEFT", 6, 0)
			_G["AchievementFrameAchievementsContainerButton"..i.."IconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			_G["AchievementFrameAchievementsContainerButton"..i.."IconTexture"]:ClearAllPoints()
			_G["AchievementFrameAchievementsContainerButton"..i.."IconTexture"]:Point("TOPLEFT", 2, -2)
			_G["AchievementFrameAchievementsContainerButton"..i.."IconTexture"]:Point("BOTTOMRIGHT", -2, 2)

			_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:StripTextures()
			_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:SetTemplate("Default")
			_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
			_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:Size(12, 12)
			_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:GetCheckedTexture():Point("TOPLEFT", -4, 4)
			_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:GetCheckedTexture():Point("BOTTOMRIGHT", 4, -4)

			_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:ClearAllPoints()
			_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:Point("BOTTOMLEFT", frame, "BOTTOMLEFT", 5, 5)

			_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"].ClearAllPoints = T.dummy
			_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"].SetPoint = T.dummy
		end

		local compares = {
			"Player",
			"Friend"
		}

		for _, compare in pairs(compares) do
			for i = 1, 9 do
				local frame = "AchievementFrameComparisonContainerButton"..i..compare

				_G[frame]:StripTextures()
				_G[frame.."Background"]:Kill()

				_G[frame]:CreateBackdrop("Overlay", true)
				_G[frame].backdrop:Point("TOPLEFT", 2, -2)
				_G[frame].backdrop:Point("BOTTOMRIGHT", -2, 2)
				_G[frame].SetBackdropBorderColor = T.dummy

				if _G[frame.."Description"] then
					_G[frame.."Description"]:SetTextColor(0.6, 0.6, 0.6)
					_G[frame.."Description"].SetTextColor = T.dummy
					_G[frame.."Description"]:SetParent(_G[frame].backdrop)
				end

				_G[frame.."Icon"]:SetParent(_G[frame].backdrop)
				_G[frame.."Shield"]:SetParent(_G[frame].backdrop)

				if compare == "Friend" then
					_G[frame.."Shield"]:Point("TOPRIGHT", _G["AchievementFrameComparisonContainerButton"..i.."Friend"], "TOPRIGHT", -20, -9)
				end

				if _G[frame.."Label"] then
					_G[frame.."Label"]:SetParent(_G[frame].backdrop)
				end

				_G[frame.."IconBling"]:Kill()
				_G[frame.."IconOverlay"]:Kill()
				_G[frame.."Icon"]:SetTemplate("Default")
				_G[frame.."Icon"]:Height(_G[frame.."Icon"]:GetHeight() - 14)
				_G[frame.."Icon"]:Width(_G[frame.."Icon"]:GetWidth() - 14)
				_G[frame.."Icon"]:ClearAllPoints()
				_G[frame.."Icon"]:Point("LEFT", 6, 0)
				_G[frame.."IconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				_G[frame.."IconTexture"]:ClearAllPoints()
				_G[frame.."IconTexture"]:Point("TOPLEFT", 2, -2)
				_G[frame.."IconTexture"]:Point("BOTTOMRIGHT", -2, 2)
			end
		end

		for i = 1, 20 do
			local frame = _G["AchievementFrameStatsContainerButton"..i]
			frame:StyleButton()

			_G["AchievementFrameStatsContainerButton"..i.."BG"]:SetTexture(1, 1, 1, 0.2)
			_G["AchievementFrameStatsContainerButton"..i.."HeaderLeft"]:Kill()
			_G["AchievementFrameStatsContainerButton"..i.."HeaderRight"]:Kill()
			_G["AchievementFrameStatsContainerButton"..i.."HeaderMiddle"]:Kill()

			local frame = "AchievementFrameComparisonStatsContainerButton"..i
			_G[frame]:StripTextures()
			_G[frame]:StyleButton()

			_G[frame.."BG"]:SetTexture(1, 1, 1, 0.2)
			_G[frame.."HeaderLeft"]:Kill()
			_G[frame.."HeaderRight"]:Kill()
			_G[frame.."HeaderMiddle"]:Kill()
		end

		hooksecurefunc("AchievementButton_GetProgressBar", function(index)
			local frame = _G["AchievementFrameProgressBar"..index]
			if frame then
				if not frame.skinned then
					frame:StripTextures()
					frame:SetStatusBarTexture(C.media.texture)
					frame:SetStatusBarColor(0, 0.7, 0.1)
					frame:SetFrameLevel(frame:GetFrameLevel() + 3)
					frame:Height(frame:GetHeight() - 2)

					frame.bg1 = frame:CreateTexture(nil, "BACKGROUND")
					frame.bg1:SetDrawLayer("BACKGROUND", -7)
					frame.bg1:SetTexture(unpack(C.media.backdrop_color))
					frame.bg1:Point("TOPLEFT", -T.mult * 3, T.mult * 3)
					frame.bg1:Point("BOTTOMRIGHT", T.mult * 3, -T.mult * 3)

					frame.bg2 = frame:CreateTexture(nil, "BACKGROUND")
					frame.bg2:SetDrawLayer("BACKGROUND", -6)
					frame.bg2:SetTexture(unpack(C.media.border_color))
					frame.bg2:Point("TOPLEFT", -T.mult * 2, T.mult * 2)
					frame.bg2:Point("BOTTOMRIGHT", T.mult * 2, -T.mult * 2)

					frame.bg3 = frame:CreateTexture(nil, "BACKGROUND")
					frame.bg3:SetDrawLayer("BACKGROUND", -5)
					frame.bg3:SetTexture(unpack(C.media.backdrop_color))
					frame.bg3:Point("TOPLEFT", -T.mult, T.mult)
					frame.bg3:Point("BOTTOMRIGHT", T.mult, -T.mult)

					frame.text:ClearAllPoints()
					frame.text:SetPoint("CENTER", frame, "CENTER", 0, -1)
					frame.text:SetJustifyH("CENTER")

					if index > 1 then
						frame:ClearAllPoints()
						frame:Point("TOP", _G["AchievementFrameProgressBar"..index-1], "BOTTOM", 0, -5)
						frame.SetPoint = T.dummy
						frame.ClearAllPoints = T.dummy
					end

					frame.skinned = true
				end
			end
		end)

		hooksecurefunc("AchievementObjectives_DisplayCriteria", function(objectivesFrame, id)
			local numCriteria = GetAchievementNumCriteria(id)
			local textStrings, metas = 0, 0
			for i = 1, numCriteria do
				local criteriaString, criteriaType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString = GetAchievementCriteriaInfo(id, i)

				if criteriaType == CRITERIA_TYPE_ACHIEVEMENT and assetID then
					metas = metas + 1
					local metaCriteria = AchievementButton_GetMeta(metas)
					if objectivesFrame.completed and completed then
						metaCriteria.label:SetTextColor(1, 1, 1, 1)
						metaCriteria.label:SetShadowOffset(0, 0)
					elseif completed then
						metaCriteria.label:SetTextColor(0, 1, 0, 1)
						metaCriteria.label:SetShadowOffset(1, -1)
					else
						metaCriteria.label:SetTextColor(0.6, 0.6, 0.6, 1)
						metaCriteria.label:SetShadowOffset(1, -1)
					end
				elseif criteriaType ~= 1 then
					textStrings = textStrings + 1
					local criteria = AchievementButton_GetCriteria(textStrings)
					if objectivesFrame.completed and completed then
						criteria.name:SetTextColor(1, 1, 1, 1)
						criteria.name:SetShadowOffset(0, 0)
					elseif completed then
						criteria.name:SetTextColor(0, 1, 0, 1)
						criteria.name:SetShadowOffset(1, -1)
					else
						criteria.name:SetTextColor(0.6, 0.6, 0.6, 1)
						criteria.name:SetShadowOffset(1, -1)
					end
				end
			end
		end)
	end

	-- LookingForGuildUI
	if addon == "Blizzard_LookingForGuildUI" then
		local checkbox = {
			"LookingForGuildPvPButton",
			"LookingForGuildWeekendsButton",
			"LookingForGuildWeekdaysButton",
			"LookingForGuildRPButton",
			"LookingForGuildRaidButton",
			"LookingForGuildQuestButton",
			"LookingForGuildDungeonButton",
		}

		-- Checkboxes
		for _, v in pairs(checkbox) do
			SkinCheckBox(_G[v])
		end

		SkinCheckBox(LookingForGuildTankButton.checkButton)
		SkinCheckBox(LookingForGuildHealerButton.checkButton)
		SkinCheckBox(LookingForGuildDamagerButton.checkButton)

		-- Other frames
		LookingForGuildFrameInset:StripTextures(false)
		LookingForGuildFrame:StripTextures()
		LookingForGuildFrame:SetTemplate("Transparent")
		LookingForGuildBrowseButton_LeftSeparator:Kill()
		LookingForGuildRequestButton_RightSeparator:Kill()
		SkinScrollBar(LookingForGuildBrowseFrameContainerScrollBar)
		LookingForGuildBrowseButton:SkinButton()
		LookingForGuildRequestButton:SkinButton()
		SkinCloseButton(LookingForGuildFrameCloseButton)
		LookingForGuildCommentInputFrame:CreateBackdrop("Overlay")
		LookingForGuildCommentInputFrame:StripTextures(false)
		GuildFinderRequestMembershipFrame:StripTextures(true)
		GuildFinderRequestMembershipFrame:SetTemplate("Transparent")
		GuildFinderRequestMembershipFrameAcceptButton:SkinButton()
		GuildFinderRequestMembershipFrameCancelButton:SkinButton()
		GuildFinderRequestMembershipFrameInputFrame:StripTextures()
		GuildFinderRequestMembershipFrameInputFrame:SetTemplate("Overlay")

		-- Container buttons
		for i = 1, 5 do
			local b = _G["LookingForGuildBrowseFrameContainerButton"..i]
			local t = _G["LookingForGuildAppsFrameContainerButton"..i]
			b:SetBackdrop(nil)
			t:SetBackdrop(nil)
		end

		-- Tabs
		for i = 1, 3 do
			_G["LookingForGuildFrameTab"..i]:StripTextures()
		end
	end

	-- InspectUI
	if addon == "Blizzard_InspectUI" then
		InspectFrame:StripTextures(true)
		InspectFrameInset:StripTextures(true)
		InspectTalentFramePointsBar:StripTextures()
		InspectFrame:CreateBackdrop("Transparent")
		InspectFrame.backdrop:SetAllPoints()
		SkinCloseButton(InspectFrameCloseButton)

		for i = 1, 4 do
			SkinTab(_G["InspectFrameTab"..i])
		end

		InspectModelFrameBorderTopLeft:Kill()
		InspectModelFrameBorderTopRight:Kill()
		InspectModelFrameBorderTop:Kill()
		InspectModelFrameBorderLeft:Kill()
		InspectModelFrameBorderRight:Kill()
		InspectModelFrameBorderBottomLeft:Kill()
		InspectModelFrameBorderBottomRight:Kill()
		InspectModelFrameBorderBottom:Kill()
		InspectModelFrameBorderBottom2:Kill()
		InspectModelFrameBackgroundOverlay:Kill()
		InspectModelFrame:CreateBackdrop("Default")

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
			local icon = _G["Inspect"..slot.."IconTexture"]
			local slot = _G["Inspect"..slot]
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

		SkinRotateButton(InspectModelFrameRotateLeftButton)
		SkinRotateButton(InspectModelFrameRotateRightButton)
		InspectModelFrameRotateLeftButton:Point("TOPLEFT", InspectModelFrame.backdrop, "TOPLEFT", 6, -6)
		InspectModelFrameRotateRightButton:Point("TOPLEFT", InspectModelFrameRotateLeftButton, "TOPRIGHT", 4, 0)

		InspectPVPFrameBottom:Kill()
		InspectGuildFrameBG:Kill()
		InspectPVPFrame:HookScript("OnShow", function() InspectPVPFrameBG:Kill() end)

		for i = 1, 3 do
			_G["InspectPVPTeam"..i]:StripTextures()
			_G["InspectTalentFrameTab"..i]:StripTextures()
		end

		InspectTalentFrame.bg = CreateFrame("Frame", nil, InspectTalentFrame)
		InspectTalentFrame.bg:SetTemplate("Default")
		InspectTalentFrame.bg:Point("TOPLEFT", InspectTalentFrameBackgroundTopLeft, "TOPLEFT", -2, 2)
		InspectTalentFrame.bg:Point("BOTTOMRIGHT", InspectTalentFrameBackgroundBottomRight, "BOTTOMRIGHT", -20, 52)
		InspectTalentFrame.bg:SetFrameLevel(InspectTalentFrame.bg:GetFrameLevel() - 2)

		for i = 1, MAX_NUM_TALENTS do
			local button = _G["InspectTalentFrameTalent"..i]
			local icon = _G["InspectTalentFrameTalent"..i.."IconTexture"]
			if button then
				button:StripTextures()
				button:StyleButton()
				button:SetTemplate("Default")
				button.SetHighlightTexture = T.dummy
				button.SetPushedTexture = T.dummy
				button:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button:GetPushedTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button:GetHighlightTexture():SetAllPoints(icon)
				button:GetPushedTexture():SetAllPoints(icon)

				if button.Rank then
					button.Rank:SetFont(C.media.normal_font, 11, "OUTLINE")
					button.Rank:ClearAllPoints()
					button.Rank:SetPoint("BOTTOMRIGHT", 1, 0)
				end

				icon:ClearAllPoints()
				icon:Point("TOPLEFT", 2, -2)
				icon:Point("BOTTOMRIGHT", -2, 2)
				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			end
		end
	end

	-- BindingUI
	if addon == "Blizzard_BindingUI" then
		local buttons = {
			"KeyBindingFrameDefaultButton",
			"KeyBindingFrameUnbindButton",
			"KeyBindingFrameOkayButton",
			"KeyBindingFrameCancelButton",
		}

		for _, v in pairs(buttons) do
			_G[v]:StripTextures()
			_G[v]:SkinButton()
		end

		SkinCheckBox(KeyBindingFrameCharacterButton)
		KeyBindingFrameHeaderText:ClearAllPoints()
		KeyBindingFrameHeaderText:Point("TOP", KeyBindingFrame, "TOP", 0, -4)
		KeyBindingFrame:StripTextures()
		KeyBindingFrame:CreateBackdrop("Transparent")
		KeyBindingFrame.backdrop:Point("TOPLEFT", 0, 0)
		KeyBindingFrame.backdrop:Point("BOTTOMRIGHT", -40, 10)

		for i = 1, KEY_BINDINGS_DISPLAYED  do
			local button1 = _G["KeyBindingFrameBinding"..i.."Key1Button"]
			local button2 = _G["KeyBindingFrameBinding"..i.."Key2Button"]
			button1:StripTextures(true)
			button1:StyleButton(false)
			button1:SetTemplate("Overlay", true)
			button2:StripTextures(true)
			button2:StyleButton(false)
			button2:SetTemplate("Overlay", true)
			button2:Point("LEFT", button1, "RIGHT", 1, 0)
		end

		KeyBindingFrameUnbindButton:Point("RIGHT", KeyBindingFrameOkayButton, "LEFT", -3, 0)
		KeyBindingFrameOkayButton:Point("RIGHT", KeyBindingFrameCancelButton, "LEFT", -3, 0)
	end

	-- GuildBankUI
	if addon == "Blizzard_GuildBankUI" then
		GuildBankFrame:StripTextures()
		GuildBankFrame:SetTemplate("Transparent")
		GuildBankEmblemFrame:StripTextures(true)

		for i = 1, GuildBankFrame:GetNumChildren() do
			local child = select(i, GuildBankFrame:GetChildren())
			if child.GetPushedTexture and child:GetPushedTexture() and not child:GetName() then
				SkinCloseButton(child)
			end
		end

		GuildBankFrameDepositButton:SkinButton(true)
		GuildBankFrameWithdrawButton:SkinButton(true)
		GuildBankInfoSaveButton:SkinButton(true)
		GuildBankFramePurchaseButton:SkinButton(true)

		GuildBankFrameWithdrawButton:Point("RIGHT", GuildBankFrameDepositButton, "LEFT", -2, 0)

		GuildBankInfoScrollFrame:StripTextures()
		GuildBankTransactionsScrollFrame:StripTextures()

		GuildBankFrame.inset = CreateFrame("Frame", nil, GuildBankFrame)
		GuildBankFrame.inset:SetTemplate("Overlay")
		GuildBankFrame.inset:Point("TOPLEFT", 30, -65)
		GuildBankFrame.inset:Point("BOTTOMRIGHT", -20, 63)

		for i = 1, NUM_GUILDBANK_COLUMNS do
			_G["GuildBankColumn"..i]:StripTextures()

			for x = 1, NUM_SLOTS_PER_GUILDBANK_GROUP do
				local button = _G["GuildBankColumn"..i.."Button"..x]
				local icon = _G["GuildBankColumn"..i.."Button"..x.."IconTexture"]
				button:StripTextures()
				button:StyleButton()
				button:SetTemplate("Default", true)

				icon:ClearAllPoints()
				icon:Point("TOPLEFT", 2, -2)
				icon:Point("BOTTOMRIGHT", -2, 2)
				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			end
		end

		for i = 1, 8 do
			local button = _G["GuildBankTab"..i.."Button"]
			local texture = _G["GuildBankTab"..i.."ButtonIconTexture"]
			_G["GuildBankTab"..i]:StripTextures(true)

			button:StripTextures()
			button:StyleButton(true)
			button:SetTemplate("Default", true)

			-- Reposition tabs
			button:ClearAllPoints()
			if i == 1 then
				button:SetPoint("TOPLEFT", GuildBankFrame, "TOPRIGHT", 1, 0)
			else
				local fixpos = i-1
				button:SetPoint("TOP", _G["GuildBankTab"..fixpos.."Button"], "BOTTOM", 0, -20)
			end

			texture:ClearAllPoints()
			texture:Point("TOPLEFT", 2, -2)
			texture:Point("BOTTOMRIGHT", -2, 2)
			texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end

		for i = 1, 4 do
			SkinTab(_G["GuildBankFrameTab"..i])
		end

		-- Reposition tabs
		GuildBankFrameTab1:ClearAllPoints()
		GuildBankFrameTab1:SetPoint("TOPLEFT", GuildBankFrame, "BOTTOMLEFT", 0, 2)

		-- Popup
		GuildBankPopupFrame:CreateBackdrop("Transparent")
		GuildBankPopupFrame.backdrop:Point("TOPLEFT", 5, 0)
		GuildBankPopupFrame.backdrop:Point("BOTTOMRIGHT", -25, 23)
		GuildBankPopupFrame:StripTextures()
		GuildBankPopupFrame:Point("TOPLEFT", GuildBankFrame, "TOPRIGHT", -4, 0)

		GuildBankPopupCancelButton:SkinButton(true)
		GuildBankPopupOkayButton:SkinButton(true)
		GuildBankPopupScrollFrame:StripTextures()
		GuildBankPopupEditBox:StripTextures(true)
		SkinEditBox(GuildBankPopupEditBox)
		GuildBankPopupEditBox:Height(GuildBankPopupEditBox:GetHeight() - 5)

		for i = 1, 16 do
			local button = _G["GuildBankPopupButton"..i]
			local texture = _G["GuildBankPopupButton"..i.."Icon"]

			button:StripTextures()
			button:StyleButton(true)
			button:SetTemplate("Default", true)

			texture:ClearAllPoints()
			texture:Point("TOPLEFT", 2, -2)
			texture:Point("BOTTOMRIGHT", -2, 2)
			texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
	end

	-- ArchaeologyUI
	if addon == "Blizzard_ArchaeologyUI" then
		ArchaeologyFrame:StripTextures(true)
		ArchaeologyFrameInset:StripTextures(true)
		ArchaeologyFrame:SetTemplate("Transparent")

		ArchaeologyFrameArtifactPageSolveFrameSolveButton:SkinButton(true)
		ArchaeologyFrameArtifactPageBackButton:SkinButton(true)
		SkinDropDownBox(ArchaeologyFrameRaceFilter, 125)

		ArchaeologyFrameRankBar:StripTextures()
		ArchaeologyFrameRankBar:SetStatusBarTexture(C.media.texture)
		ArchaeologyFrameRankBar:CreateBackdrop("Overlay")

		ArchaeologyFrameArtifactPageSolveFrameStatusBar:StripTextures()
		ArchaeologyFrameArtifactPageSolveFrameStatusBar:SetStatusBarTexture(C.media.texture)
		ArchaeologyFrameArtifactPageSolveFrameStatusBar:SetStatusBarColor(0.7, 0.2, 0)
		ArchaeologyFrameArtifactPageSolveFrameStatusBar:CreateBackdrop("Overlay")

		for i = 1, ARCHAEOLOGY_MAX_COMPLETED_SHOWN do
			local artifact = _G["ArchaeologyFrameCompletedPageArtifact"..i]

			if artifact then
				_G["ArchaeologyFrameCompletedPageArtifact"..i.."Border"]:Kill()
				_G["ArchaeologyFrameCompletedPageArtifact"..i.."Bg"]:Kill()
				_G["ArchaeologyFrameCompletedPageArtifact"..i.."Icon"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				_G["ArchaeologyFrameCompletedPageArtifact"..i.."Icon"].backdrop = CreateFrame("Frame", nil, artifact)
				_G["ArchaeologyFrameCompletedPageArtifact"..i.."Icon"].backdrop:SetTemplate("Default")
				_G["ArchaeologyFrameCompletedPageArtifact"..i.."Icon"].backdrop:Point("TOPLEFT", _G["ArchaeologyFrameCompletedPageArtifact"..i.."Icon"], "TOPLEFT", -2, 2)
				_G["ArchaeologyFrameCompletedPageArtifact"..i.."Icon"].backdrop:Point("BOTTOMRIGHT", _G["ArchaeologyFrameCompletedPageArtifact"..i.."Icon"], "BOTTOMRIGHT", 2, -2)
				_G["ArchaeologyFrameCompletedPageArtifact"..i.."Icon"].backdrop:SetFrameLevel(artifact:GetFrameLevel() - 2)
				_G["ArchaeologyFrameCompletedPageArtifact"..i.."Icon"]:SetDrawLayer("OVERLAY")
				_G["ArchaeologyFrameCompletedPageArtifact"..i.."ArtifactName"]:SetTextColor(1, 0.8, 0)
				_G["ArchaeologyFrameCompletedPageArtifact"..i.."ArtifactName"]:SetShadowOffset(1, -1)
				_G["ArchaeologyFrameCompletedPageArtifact"..i.."ArtifactSubText"]:SetTextColor(0.6, 0.6, 0.6)
				_G["ArchaeologyFrameCompletedPageArtifact"..i.."ArtifactSubText"]:SetShadowOffset(1, -1)
			end
		end

		for i = 1, ARCHAEOLOGY_MAX_RACES do
			local frame = _G["ArchaeologyFrameSummaryPageRace"..i]

			if frame then
				frame.raceName:SetTextColor(1, 1, 1)
				frame.raceName:SetShadowOffset(1, -1)
			end
		end

		for i = 1, ArchaeologyFrameCompletedPage:GetNumRegions() do
			local region = select(i, ArchaeologyFrameCompletedPage:GetRegions())
			if region:GetObjectType() == "FontString" then
				region:SetTextColor(1, 0.8, 0)
				region:SetShadowColor(0, 0, 0)
				region:SetShadowOffset(1, -1)
			end
		end

		for i = 1, ArchaeologyFrameSummaryPage:GetNumRegions() do
			local region = select(i, ArchaeologyFrameSummaryPage:GetRegions())
			if region:GetObjectType() == "FontString" then
				region:SetTextColor(1, 0.8, 0)
				region:SetShadowColor(0, 0, 0)
				region:SetShadowOffset(1, -1)
			end
		end

		ArchaeologyFrameCompletedPage.infoText:SetTextColor(1, 1, 1)
		ArchaeologyFrameHelpPageTitle:SetTextColor(1, 0.8, 0)
		ArchaeologyFrameHelpPageTitle:SetShadowColor(0, 0, 0)
		ArchaeologyFrameHelpPageTitle:SetShadowOffset(1, -1)
		ArchaeologyFrameHelpPageDigTitle:SetTextColor(1, 0.8, 0)
		ArchaeologyFrameHelpPageDigTitle:SetShadowColor(0, 0, 0)
		ArchaeologyFrameHelpPageDigTitle:SetShadowOffset(1, -1)
		ArchaeologyFrameHelpPageHelpScrollHelpText:SetTextColor(1, 1, 1)

		ArchaeologyFrameArtifactPageHistoryTitle:SetTextColor(1, 0.8, 0)
		ArchaeologyFrameArtifactPageIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		ArchaeologyFrameArtifactPageIcon.backdrop = CreateFrame("Frame", nil, ArchaeologyFrameArtifactPage)
		ArchaeologyFrameArtifactPageIcon.backdrop:SetTemplate("Default")
	    ArchaeologyFrameArtifactPageIcon.backdrop:Point("TOPLEFT", ArchaeologyFrameArtifactPageIcon, "TOPLEFT", -2, 2)
		ArchaeologyFrameArtifactPageIcon.backdrop:Point("BOTTOMRIGHT", ArchaeologyFrameArtifactPageIcon, "BOTTOMRIGHT", 2, -2)
		ArchaeologyFrameArtifactPageIcon.backdrop:SetFrameLevel(ArchaeologyFrameArtifactPage:GetFrameLevel())
		ArchaeologyFrameArtifactPageIcon:SetParent(ArchaeologyFrameArtifactPageIcon.backdrop)
		ArchaeologyFrameArtifactPageIcon:SetDrawLayer("OVERLAY")

		ArchaeologyFrameArtifactPageHistoryScrollChildText:SetTextColor(1, 1, 1)
		SkinCloseButton(ArchaeologyFrameCloseButton)
		SkinNextPrevButton(ArchaeologyFrameCompletedPageNextPageButton)
		SkinNextPrevButton(ArchaeologyFrameCompletedPagePrevPageButton)

		ArchaeologyFrameInfoButton:Point("TOPLEFT", ArchaeologyFrame, 4, -4)
	end

	-- GuildControlUI
	if addon == "Blizzard_GuildControlUI" then
		GuildControlUI:StripTextures()
		GuildControlUIHbar:StripTextures()
		GuildControlUI:SetTemplate("Transparent")
		GuildControlUI:ClearAllPoints()
		GuildControlUI:Point("TOPLEFT", GuildFrame, "TOPRIGHT", 3, 0)
		GuildControlUI:SetFrameLevel(GuildControlUI:GetFrameLevel() + 2)

		local function SkinGuildRanks()
			for i = 1, GuildControlGetNumRanks() do
				local rankFrame = _G["GuildControlUIRankOrderFrameRank"..i]
				if rankFrame then
					rankFrame.downButton:SkinButton()
					rankFrame.upButton:SkinButton()
					rankFrame.deleteButton:SkinButton()

					if not rankFrame.nameBox.backdrop then
						SkinEditBox(rankFrame.nameBox)
					end

					rankFrame.nameBox.backdrop:Point("TOPLEFT", -2, -4)
					rankFrame.nameBox.backdrop:Point("BOTTOMRIGHT", -4, 4)
				end
			end
		end
		hooksecurefunc("GuildControlUI_RankOrder_Update", SkinGuildRanks)
		GuildControlUIRankOrderFrameNewButton:HookScript("OnClick", function()
			T.Delay(1, SkinGuildRanks)
		end)

		SkinDropDownBox(GuildControlUINavigationDropDown)
		SkinDropDownBox(GuildControlUIRankSettingsFrameRankDropDown, 180)
		GuildControlUINavigationDropDownButton:Width(20)
		GuildControlUIRankSettingsFrameRankDropDownButton:Width(20)

		for i = 1, NUM_RANK_FLAGS do
			if _G["GuildControlUIRankSettingsFrameCheckbox"..i] then
				SkinCheckBox(_G["GuildControlUIRankSettingsFrameCheckbox"..i])
			end
		end

		GuildControlUIRankOrderFrameNewButton:SkinButton()

		SkinEditBox(GuildControlUIRankSettingsFrameGoldBox)
		GuildControlUIRankSettingsFrameGoldBox.backdrop:Point("TOPLEFT", -2, -4)
		GuildControlUIRankSettingsFrameGoldBox.backdrop:Point("BOTTOMRIGHT", 2, 4)
		GuildControlUIRankSettingsFrameGoldBox:StripTextures()

		GuildControlUIRankBankFrameInset:StripTextures()
		GuildControlUIRankBankFrameInsetScrollFrame:StripTextures()

		local once = false
		hooksecurefunc("GuildControlUI_BankTabPermissions_Update", function()
			local numTabs = GetNumGuildBankTabs()
			if numTabs < MAX_BUY_GUILDBANK_TABS then
				numTabs = numTabs + 1
			end
			for i = 1, numTabs do
				local tab = _G["GuildControlBankTab"..i.."Owned"]
				local icon = tab.tabIcon
				local editbox = tab.editBox

				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

				if once == false then
					_G["GuildControlBankTab"..i.."BuyPurchaseButton"]:SkinButton()
					_G["GuildControlBankTab"..i.."OwnedStackBox"]:StripTextures()
				end
			end
			once = true
		end)

		SkinDropDownBox(GuildControlUIRankBankFrameRankDropDown, 180)
		GuildControlUIRankBankFrameRankDropDownButton:Width(20)

		SkinCloseButton(GuildControlUICloseButton)
	end

	-- GuildUI
	if addon == "Blizzard_GuildUI" then
		GuildFrame:StripTextures(true)
		GuildFrame:SetTemplate("Transparent")
		GuildLevelFrame:Kill()

		SkinCloseButton(GuildMemberDetailCloseButton)
		SkinCloseButton(GuildFrameCloseButton)

		local striptextures = {
			"GuildNewPerksFrame",
			"GuildFrameInset",
			"GuildFrameBottomInset",
			"GuildAllPerksFrame",
			"GuildMemberDetailFrame",
			"GuildMemberNoteBackground",
			"GuildInfoFrameInfo",
			"GuildLogContainer",
			"GuildLogFrame",
			"GuildRewardsFrame",
			"GuildMemberOfficerNoteBackground",
			"GuildTextEditContainer",
			"GuildTextEditFrame",
			"GuildRecruitmentRolesFrame",
			"GuildRecruitmentAvailabilityFrame",
			"GuildRecruitmentInterestFrame",
			"GuildRecruitmentLevelFrame",
			"GuildRecruitmentCommentFrame",
			"GuildRecruitmentCommentInputFrame",
			"GuildInfoFrameApplicantsContainer",
			"GuildInfoFrameApplicants",
			"GuildNewsBossModel",
			"GuildNewsBossModelTextFrame",
		}

		GuildRewardsFrameVisitText:ClearAllPoints()
		GuildRewardsFrameVisitText:SetPoint("TOP", GuildRewardsFrame, "TOP", 0, 30)

		for _, frame in pairs(striptextures) do
			_G[frame]:StripTextures()
		end

		GuildNewsBossModel:CreateBackdrop("Transparent")
		GuildNewsBossModelTextFrame:CreateBackdrop("Overlay")
		GuildNewsBossModelTextFrame.backdrop:Point("TOPLEFT", GuildNewsBossModel.backdrop, "BOTTOMLEFT", 0, -1)
		GuildNewsBossModel:Point("TOPLEFT", GuildFrame, "TOPRIGHT", 5, -2)

		local buttons = {
			"GuildPerksToggleButton",
			"GuildMemberRemoveButton",
			"GuildMemberGroupInviteButton",
			"GuildAddMemberButton",
			"GuildViewLogButton",
			"GuildControlButton",
			"GuildRecruitmentListGuildButton",
			"GuildTextEditFrameAcceptButton",
			"GuildRecruitmentInviteButton",
			"GuildRecruitmentMessageButton",
			"GuildRecruitmentDeclineButton",
		}

		for i, button in pairs(buttons) do
			if i == 1 then
				_G[button]:SkinButton()
			else
				_G[button]:SkinButton(true)
			end
		end

		local checkbuttons = {
			"Quest",
			"Dungeon",
			"Raid",
			"PvP",
			"RP",
			"Weekdays",
			"Weekends",
			"LevelAny",
			"LevelMax",
		}

		for _, frame in pairs(checkbuttons) do
			SkinCheckBox(_G["GuildRecruitment"..frame.."Button"])
		end

		SkinCheckBox(GuildRecruitmentTankButton:GetChildren())
		SkinCheckBox(GuildRecruitmentHealerButton:GetChildren())
		SkinCheckBox(GuildRecruitmentDamagerButton:GetChildren())

		for i = 1, 5 do
			SkinTab(_G["GuildFrameTab"..i])
		end
		GuildXPFrame:ClearAllPoints()
		GuildXPFrame:Point("TOP", GuildFrame, "TOP", 0, -40)

		SkinScrollBar(GuildPerksContainerScrollBar)

		GuildFactionBar:StripTextures()
		GuildFactionBar.progress:SetTexture(C.media.texture)
		GuildFactionBar:CreateBackdrop("Overlay")
		GuildFactionBar.backdrop:Point("TOPLEFT", GuildFactionBar.progress, "TOPLEFT", -2, 2)
		GuildFactionBar.backdrop:Point("BOTTOMRIGHT", GuildFactionBar, "BOTTOMRIGHT", 0, 0)

		GuildXPBarLeft:Kill()
		GuildXPBarRight:Kill()
		GuildXPBarMiddle:Kill()
		GuildXPBarBG:Kill()
		GuildXPBarShadow:Kill()
		GuildXPBarCap:Kill()
		GuildXPBar.progress:SetTexture(C.media.texture)
		GuildXPBar:CreateBackdrop("Overlay")
		GuildXPBar.backdrop:Point("TOPLEFT", GuildXPBar.progress, "TOPLEFT", -2, 2)
		GuildXPBar.backdrop:Point("BOTTOMRIGHT", GuildXPBar, "BOTTOMRIGHT", -2, 0)

		GuildLatestPerkButton:StripTextures()
		GuildLatestPerkButtonIconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		GuildLatestPerkButtonIconTexture:ClearAllPoints()
		GuildLatestPerkButtonIconTexture:Point("TOPLEFT", 2, -2)
		GuildLatestPerkButton:CreateBackdrop("Default")
		GuildLatestPerkButton.backdrop:Point("TOPLEFT", GuildLatestPerkButtonIconTexture, "TOPLEFT", -2, 2)
		GuildLatestPerkButton.backdrop:Point("BOTTOMRIGHT", GuildLatestPerkButtonIconTexture, "BOTTOMRIGHT", 2, -2)

		GuildNextPerkButton:StripTextures()
		GuildNextPerkButtonIconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		GuildNextPerkButtonIconTexture:ClearAllPoints()
		GuildNextPerkButtonIconTexture:Point("TOPLEFT", 2, -2)
		GuildNextPerkButton:CreateBackdrop("Default")
		GuildNextPerkButton.backdrop:Point("TOPLEFT", GuildNextPerkButtonIconTexture, "TOPLEFT", -2, 2)
		GuildNextPerkButton.backdrop:Point("BOTTOMRIGHT", GuildNextPerkButtonIconTexture, "BOTTOMRIGHT", 2, -2)

		-- Guild Perk buttons list
		for i = 1, 8 do
			local button = _G["GuildPerksContainerButton"..i]
			button:StripTextures()

			if button.icon then
				button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button.icon:ClearAllPoints()
				button.icon:Point("TOPLEFT", 2, -2)
				button:CreateBackdrop("Default")
				button.backdrop:Point("TOPLEFT", button.icon, "TOPLEFT", -2, 2)
				button.backdrop:Point("BOTTOMRIGHT", button.icon, "BOTTOMRIGHT", 2, -2)
				button.icon:SetParent(button.backdrop)
			end
		end

		-- Roster
		SkinScrollBar(GuildRosterContainerScrollBar)
		SkinCheckBox(GuildRosterShowOfflineButton)

		for i = 1, 4 do
			_G["GuildRosterColumnButton"..i]:StripTextures(true)
		end

		SkinDropDownBox(GuildRosterViewDropdown, 200)

		for i = 1, 14 do
			_G["GuildRosterContainerButton"..i.."HeaderButton"]:SkinButton(true)
		end

		-- Detail Frame
		GuildMemberDetailFrame:SetTemplate("Transparent")
		GuildMemberDetailFrame:ClearAllPoints()
		GuildMemberDetailFrame:Point("TOPLEFT", GuildFrame, "TOPRIGHT", 3, 0)
		GuildMemberNoteBackground:SetTemplate("Overlay")
		GuildMemberOfficerNoteBackground:SetTemplate("Overlay")
		GuildMemberRankDropdown:SetFrameLevel(GuildMemberRankDropdown:GetFrameLevel() + 5)
		SkinDropDownBox(GuildMemberRankDropdown, 160)

		GuildMemberRemoveButton:ClearAllPoints()
		GuildMemberRemoveButton:Point("BOTTOMLEFT", GuildMemberDetailFrame, "BOTTOMLEFT", 9, 4)

		-- News
		GuildNewsFrame:StripTextures()
		for i = 1, 17 do
			_G["GuildNewsContainerButton"..i].header:Kill()
		end

		GuildNewsFiltersFrame:StripTextures()
		GuildNewsFiltersFrame:SetTemplate("Transparent")
		SkinCloseButton(GuildNewsFiltersFrameCloseButton)

		for i = 1, 7 do
			SkinCheckBox(_G["GuildNewsFilterButton"..i])
		end

		GuildNewsFiltersFrame:Point("TOPLEFT", GuildFrame, "TOPRIGHT", 3, 0)
		SkinScrollBar(GuildNewsContainerScrollBar)

		-- Info Frame
		SkinScrollBar(GuildInfoDetailsFrameScrollBar)
		SkinScrollBar(GuildInfoFrameApplicantsContainerScrollBar)

		for i = 1, 3 do
			_G["GuildInfoFrameTab"..i]:StripTextures()
		end

		local backdrop1 = CreateFrame("Frame", nil, GuildInfoFrameInfo)
		backdrop1:SetTemplate("Overlay")
		backdrop1:SetFrameLevel(GuildInfoFrameInfo:GetFrameLevel() - 1)
		backdrop1:Point("TOPLEFT", GuildInfoFrameInfo, "TOPLEFT", 2, -22)
		backdrop1:Point("BOTTOMRIGHT", GuildInfoFrameInfo, "BOTTOMRIGHT", 0, 200)

		local backdrop2 = CreateFrame("Frame", nil, GuildInfoFrameInfo)
		backdrop2:SetTemplate("Overlay")
		backdrop2:SetFrameLevel(GuildInfoFrameInfo:GetFrameLevel() - 1)
		backdrop2:Point("TOPLEFT", GuildInfoFrameInfo, "TOPLEFT", 2, -158)
		backdrop2:Point("BOTTOMRIGHT", GuildInfoFrameInfo, "BOTTOMRIGHT", 0, 118)

		local backdrop3 = CreateFrame("Frame", nil, GuildInfoFrameInfo)
		backdrop3:SetTemplate("Overlay")
		backdrop3:SetFrameLevel(GuildInfoFrameInfo:GetFrameLevel() - 1)
		backdrop3:Point("TOPLEFT", GuildInfoFrameInfo, "TOPLEFT", 2, -233)
		backdrop3:Point("BOTTOMRIGHT", GuildInfoFrameInfo, "BOTTOMRIGHT", 0, 3)

		GuildRecruitmentCommentInputFrame:SetTemplate("Overlay")

		for _, button in next, GuildInfoFrameApplicantsContainer.buttons do
			button:SetBackdrop(nil)
		end

		-- Text Edit Frame
		GuildTextEditFrame:SetTemplate("Transparent")
		SkinScrollBar(GuildTextEditScrollFrameScrollBar)
		GuildTextEditContainer:SetTemplate("Transparent")
		SkinCloseButton(GuildTextEditFrameCloseButton, GuildTextEditFrame)
		for i = 1, GuildTextEditFrame:GetNumChildren() do
			local child = select(i, GuildTextEditFrame:GetChildren())
			if child:GetName() == "GuildTextEditFrameCloseButton" and child:GetWidth() > 50 then
				child:SkinButton(true)
			end
		end

		-- Guild Log
		SkinScrollBar(GuildLogScrollFrameScrollBar)
		GuildLogFrame:CreateBackdrop("Transparent")
		GuildLogFrame.backdrop:Point("TOPLEFT", 0, 0)
		GuildLogFrame.backdrop:Point("BOTTOMRIGHT", -15, 0)
		GuildLogFrame:Point("TOPLEFT", GuildFrame, "TOPRIGHT", 3, 0)
		SkinCloseButton(GuildLogFrameCloseButton, GuildLogFrame.backdrop)

		for i = 1, GuildLogFrame:GetNumChildren() do
			local child = select(i, GuildLogFrame:GetChildren())
			if child:GetName() == "GuildLogFrameCloseButton" and child:GetWidth() > 50 then
				child:SkinButton(true)
			end
		end

		-- Rewards
		SkinScrollBar(GuildRewardsContainerScrollBar)

		for i = 1, 8 do
			local button = _G["GuildRewardsContainerButton"..i]
			button:StripTextures()

			if button.icon then
				button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button.icon:ClearAllPoints()
				button.icon:Point("TOPLEFT", 2, -2)
				button:CreateBackdrop("Default")
				button.backdrop:Point("TOPLEFT", button.icon, "TOPLEFT", -2, 2)
				button.backdrop:Point("BOTTOMRIGHT", button.icon, "BOTTOMRIGHT", 2, -2)
				button.icon:SetParent(button.backdrop)
			end
		end
	end

	-- TradeSkillUI
	if addon == "Blizzard_TradeSkillUI" then
		TradeSkillFrame:StripTextures(true)
		TradeSkillListScrollFrame:StripTextures()
		TradeSkillDetailScrollFrame:StripTextures()
		TradeSkillFrameInset:StripTextures()
		TradeSkillExpandButtonFrame:StripTextures()
		TradeSkillDetailScrollChildFrame:StripTextures()

		TradeSkillFrame:SetTemplate("Transparent")
		TradeSkillFrame:Height(TradeSkillFrame:GetHeight() + 12)
		TradeSkillRankFrame:StripTextures()
		TradeSkillRankFrame:CreateBackdrop("Overlay")
		TradeSkillRankFrame:SetStatusBarTexture(C.media.texture)

		TradeSkillCreateButton:SkinButton(true)
		TradeSkillCancelButton:SkinButton(true)
		TradeSkillFilterButton:SkinButton(true)
		TradeSkillCreateAllButton:SkinButton(true)
		TradeSkillViewGuildCraftersButton:SkinButton(true)

		TradeSkillLinkButton:GetNormalTexture():SetTexCoord(0.25, 0.7, 0.37, 0.75)
		TradeSkillLinkButton:GetPushedTexture():SetTexCoord(0.25, 0.7, 0.45, 0.8)
		TradeSkillLinkButton:GetHighlightTexture():Kill()
		TradeSkillLinkButton:CreateBackdrop("Overlay")
		TradeSkillLinkButton:Size(17, 14)
		TradeSkillLinkButton:Point("LEFT", TradeSkillLinkFrame, "LEFT", 5, -1)
		SkinEditBox(TradeSkillFrameSearchBox)
		TradeSkillFrameSearchBox:Height(TradeSkillFrameSearchBox:GetHeight() - 2)
		SkinEditBox(TradeSkillInputBox)
		TradeSkillInputBox:Height(TradeSkillInputBox:GetHeight() - 2)
		SkinNextPrevButton(TradeSkillDecrementButton)
		SkinNextPrevButton(TradeSkillIncrementButton)
		TradeSkillIncrementButton:Point("RIGHT", TradeSkillCreateButton, "LEFT", -13, 0)
		TradeSkillDecrementButton:Height(TradeSkillDecrementButton:GetHeight() + 7)
		TradeSkillIncrementButton:Height(TradeSkillIncrementButton:GetHeight() + 7)

		SkinCloseButton(TradeSkillFrameCloseButton)

		local once = false
		hooksecurefunc("TradeSkillFrame_SetSelection", function(id)
			TradeSkillSkillIcon:StyleButton()
			if TradeSkillSkillIcon:GetNormalTexture() then
				TradeSkillSkillIcon:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
				TradeSkillSkillIcon:GetNormalTexture():ClearAllPoints()
				TradeSkillSkillIcon:GetNormalTexture():Point("TOPLEFT", 2, -2)
				TradeSkillSkillIcon:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
			end
			TradeSkillSkillIcon:SetTemplate("Default")

			for i = 1, MAX_TRADE_SKILL_REAGENTS do
				local button = _G["TradeSkillReagent"..i]
				local icon = _G["TradeSkillReagent"..i.."IconTexture"]
				local count = _G["TradeSkillReagent"..i.."Count"]

				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				icon:SetDrawLayer("OVERLAY")
				if not icon.backdrop then
					icon.backdrop = CreateFrame("Frame", nil, button)
					icon.backdrop:SetFrameLevel(button:GetFrameLevel() - 1)
					icon.backdrop:SetTemplate("Default")
					icon.backdrop:Point("TOPLEFT", icon, "TOPLEFT", -2, 2)
					icon.backdrop:Point("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)
				end
				icon:SetParent(icon.backdrop)
				count:SetParent(icon.backdrop)
				count:SetFont(C.media.normal_font, 12, "OUTLINE")
				count:SetDrawLayer("OVERLAY")

				if i > 2 and once == false then
					local point, anchoredto, point2, x, y = button:GetPoint()
					button:ClearAllPoints()
					button:Point(point, anchoredto, point2, x, y - 3)
					once = true
				end

				_G["TradeSkillReagent"..i.."NameFrame"]:Kill()
			end
		end)

		-- Guild Crafters
		TradeSkillGuildFrame:StripTextures()
		TradeSkillGuildFrame:SetTemplate("Transparent")
		TradeSkillGuildFrame:Point("BOTTOMLEFT", TradeSkillFrame, "BOTTOMRIGHT", 3, 19)
		TradeSkillGuildFrameContainer:StripTextures()
		TradeSkillGuildFrameContainer:SetTemplate("Overlay")
		SkinCloseButton(TradeSkillGuildFrameCloseButton)
	end

	-- RaidUI
	if addon == "Blizzard_RaidUI" then
		local buttons = {
			"RaidFrameRaidBrowserButton",
			"RaidFrameRaidInfoButton",
			"RaidFrameReadyCheckButton",
		}

		for i = 1, #buttons do
			_G[buttons[i]]:SkinButton()
		end

		local StripAllTextures = {
			"RaidGroup1",
			"RaidGroup2",
			"RaidGroup3",
			"RaidGroup4",
			"RaidGroup5",
			"RaidGroup6",
			"RaidGroup7",
			"RaidGroup8",
		}

		for _, object in pairs(StripAllTextures) do
			_G[object]:StripTextures()
		end

		for i = 1, MAX_RAID_GROUPS * 5 do
			_G["RaidGroupButton"..i]:SkinButton(true)
		end

		for i = 1, 8 do
			for j = 1, 5 do
				_G["RaidGroup"..i.."Slot"..j]:StripTextures()
				_G["RaidGroup"..i.."Slot"..j]:SetTemplate("Transparent")
			end
		end
	end

	-- TalentUI
	if addon == "Blizzard_TalentUI" then
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
			"PlayerTalentFramePanel1HeaderIcon",
			"PlayerTalentFramePanel2HeaderIcon",
			"PlayerTalentFramePanel3HeaderIcon",
			"PlayerTalentFramePetTalents",
		}

		for _, object in pairs(StripAllTextures) do
			_G[object]:StripTextures()
		end

		local function StripTalentFramePanelTextures(object)
			for i = 1, object:GetNumRegions() do
				local region = select(i, object:GetRegions())
				if region:GetObjectType() == "Texture" then
					if region:GetName():find("Branch") then
						region:SetDrawLayer("OVERLAY")
					else
						region:SetTexture(nil)
					end
				end
			end
		end

		StripTalentFramePanelTextures(PlayerTalentFramePanel1)
		StripTalentFramePanelTextures(PlayerTalentFramePanel2)
		StripTalentFramePanelTextures(PlayerTalentFramePanel3)
		StripTalentFramePanelTextures(PlayerTalentFramePetPanel)

		for i = 1, 3 do
			_G["PlayerTalentFramePanel"..i.."SelectTreeButton"]:SetFrameLevel(_G["PlayerTalentFramePanel"..i.."SelectTreeButton"]:GetFrameLevel() + 5)
			_G["PlayerTalentFramePanel"..i.."SelectTreeButton"]:StripTextures(true)
			_G["PlayerTalentFramePanel"..i.."SelectTreeButton"]:SkinButton()
		end

		local KillTextures = {
			"PlayerTalentFramePanel1InactiveShadow",
			"PlayerTalentFramePanel2InactiveShadow",
			"PlayerTalentFramePanel3InactiveShadow",
			"PlayerTalentFramePanel1SummaryRoleIcon",
			"PlayerTalentFramePanel2SummaryRoleIcon",
			"PlayerTalentFramePanel3SummaryRoleIcon",
			"PlayerTalentFramePetShadowOverlay",
			"PlayerTalentFrameHeaderHelpBox",
		}

		for _, texture in pairs(KillTextures) do
			_G[texture]:Kill()
		end

		for i = 1, 3 do
			_G["PlayerTalentFramePanel"..i.."Arrow"]:SetFrameLevel(_G["PlayerTalentFramePanel"..i.."Arrow"]:GetFrameLevel() + 1)
		end
		PlayerTalentFramePetPanelArrow:SetFrameStrata("HIGH")

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
		SkinCloseButton(PlayerTalentFrameCloseButton)

		function talentpairs(inspect, pet)
			local tab, tal = 1, 0
			return function()
				tal = tal + 1
				if tal > GetNumTalents(tab, inspect, pet) then
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

			if button.Rank then
				button.Rank:SetFont(C.media.normal_font, 11, "OUTLINE")
				button.Rank:ClearAllPoints()
				button.Rank:SetPoint("BOTTOMRIGHT", 3, -1)
			end

			if icon then
				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button:StyleButton()
				button.SetHighlightTexture = T.dummy
				button.SetPushedTexture = T.dummy
				button:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button:GetPushedTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button:GetHighlightTexture():SetAllPoints(icon)
				button:GetPushedTexture():SetAllPoints(icon)

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
				tab:GetNormalTexture():Point("TOPLEFT", 2, -2)
				tab:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)

				tab:CreateBackdrop("Default")
				tab.backdrop:SetAllPoints()
				tab:StyleButton(true)
			end
		end

		-- Reposition tabs
		PlayerSpecTab1:ClearAllPoints()
		PlayerSpecTab1:SetPoint("TOPLEFT", PlayerTalentFrame, "TOPRIGHT", 1, 0)
		PlayerSpecTab1.SetPoint = T.dummy

		local function TalentSummaryClean(i)
			local frame = _G["PlayerTalentFramePanel"..i.."Summary"]
			frame:CreateBackdrop("Overlay")
			frame:SetFrameLevel(frame:GetFrameLevel() + 1)
			local a, b, _, d, _, _, _, _, _, _, _, _, m, _ = frame:GetRegions()
			a:Hide()
			b:Hide()
			d:Hide()
			m:Hide()

			_G["PlayerTalentFramePanel"..i.."SummaryIcon"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end

		local function TalentHeaderIcon(self, first, i)
			local button = _G["PlayerTalentFramePanel"..i.."HeaderIcon"]
			local icon = _G["PlayerTalentFramePanel"..i.."HeaderIconIcon"]
			local panel = _G["PlayerTalentFramePanel"..i]
			local text = _G["PlayerTalentFramePanel"..i.."HeaderIconPointsSpent"]

			if first then
				button:StripTextures()
			end

			_G["PlayerTalentFramePanel"..i.."HeaderIconPointsSpent"]:SetFont(C.media.normal_font, 11, "OUTLINE")

			if icon then
				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button:SetFrameLevel(button:GetFrameLevel() + 1)
				button:ClearAllPoints()
				button:Point("TOPLEFT", panel, "TOPLEFT", 4, -4)
				text:SetFont(C.media.normal_font, 11, "OUTLINE")
				text:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 2)
				local frame = CreateFrame("Frame", nil, button)
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
			for j = 1, 4 do
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
		PlayerTalentFramePetModel:CreateBackdrop("Overlay")
		PlayerTalentFramePetModel.backdrop:Point("TOPLEFT", PlayerTalentFramePetModel, "TOPLEFT")
		PlayerTalentFramePetModel.backdrop:Point("BOTTOMRIGHT", PlayerTalentFramePetModel, "BOTTOMRIGHT", 0, -7)
		PlayerTalentFrameLearnButton:SkinButton(true)
		PlayerTalentFrameResetButton:SkinButton(true)

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
				button:Point("TOPLEFT", panel, "TOPLEFT", 5, -5)
				local text = button:FontString(nil, C.media.normal_font, 11, "OUTLINE")
				text:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", 3, -2)
				text:SetText(pointsSpent)
				local frame = CreateFrame("Frame", nil, button)
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
				button:SetFrameLevel(button:GetFrameLevel() + 1)
				button:ClearAllPoints()
				button:Point("BOTTOMLEFT", panel, "TOPLEFT", 0, 10)
				local text = button:FontString(nil, C.media.normal_font, 11)
				text:Point("TOPRIGHT", button, "TOPRIGHT", 0, -10)
				text:SetText(diet)
				local frame = CreateFrame("Frame", nil, button)
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

			if button.Rank then
				button.Rank:SetFont(C.media.normal_font, 11, "OUTLINE")
				button.Rank:ClearAllPoints()
				button.Rank:SetPoint("BOTTOMRIGHT", 3, -1)
			end

			if icon then
				button:StyleButton()
				button.SetHighlightTexture = T.dummy
				button.SetPushedTexture = T.dummy
				button:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button:GetPushedTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button:GetHighlightTexture():SetAllPoints(icon)
				button:GetPushedTexture():SetAllPoints(icon)

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

	-- GlyphUI
	if addon == "Blizzard_GlyphUI" then
		-- Glyph Tab
		GlyphFrameSparkleFrame:CreateBackdrop("Default")
		GlyphFrameSparkleFrame.backdrop:Point("TOPLEFT", GlyphFrameSparkleFrame, "TOPLEFT", 3, -3)
		GlyphFrameSparkleFrame.backdrop:Point("BOTTOMRIGHT", GlyphFrameSparkleFrame, "BOTTOMRIGHT", -3, 3)
		SkinEditBox(GlyphFrameSearchBox)
		SkinDropDownBox(GlyphFrameFilterDropDown, 212)

		GlyphFrameBackground:SetParent(GlyphFrameSparkleFrame)
		GlyphFrameBackground:SetPoint("TOPLEFT", 5, -5)
		GlyphFrameBackground:SetPoint("BOTTOMRIGHT", -5, 5)

		for i = 1, 9 do
			_G["GlyphFrameGlyph"..i]:SetFrameLevel(_G["GlyphFrameGlyph"..i]:GetFrameLevel() + 5)
		end

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

		GlyphFrameClearInfoFrameIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		GlyphFrameClearInfoFrameIcon:ClearAllPoints()
		GlyphFrameClearInfoFrameIcon:Point("TOPLEFT", 2, -2)
		GlyphFrameClearInfoFrameIcon:Point("BOTTOMRIGHT", -2, 2)

		GlyphFrameClearInfoFrame:CreateBackdrop("Default", true)
		GlyphFrameClearInfoFrame.backdrop:SetAllPoints()
		GlyphFrameClearInfoFrame:StyleButton()
		GlyphFrameClearInfoFrame:Size(25, 25)

		SkinScrollBar(GlyphFrameScrollFrameScrollBar)

		local StripAllTextures = {
			"GlyphFrameScrollFrame",
			"GlyphFrameSideInset",
			"GlyphFrameScrollFrameScrollChild",
		}

		for _, object in pairs(StripAllTextures) do
			_G[object]:StripTextures()
		end
	end

	-- AuctionUI
	if addon == "Blizzard_AuctionUI" then
		SkinCloseButton(AuctionFrameCloseButton)
		AuctionFrame:StripTextures(true)
		AuctionFrame:SetTemplate("Transparent")

		BrowseFilterScrollFrame:StripTextures()
		BrowseScrollFrame:StripTextures()
		AuctionsScrollFrame:StripTextures()
		BidScrollFrame:StripTextures()

		SkinDropDownBox(BrowseDropDown)
		SkinDropDownBox(PriceDropDown)
		SkinDropDownBox(DurationDropDown, 80)

		SkinCheckBox(IsUsableCheckButton)
		SkinCheckBox(ShowOnPlayerCheckButton)

		-- Dress Up Frame
		AuctionDressUpFrame:StripTextures()
		AuctionDressUpFrame:SetTemplate("Transparent")
		AuctionDressUpFrame:Point("TOPLEFT", AuctionFrame, "TOPRIGHT", 3, 0)
		AuctionDressUpFrameResetButton:SkinButton()
		AuctionDressUpFrameCloseButton:StripTextures()
		SkinCloseButton(AuctionDressUpFrameCloseButton, AuctionDressUpFrame)

		SkinRotateButton(AuctionDressUpModelRotateLeftButton)
		SkinRotateButton(AuctionDressUpModelRotateRightButton)
		AuctionDressUpModelRotateLeftButton:Point("TOPLEFT", AuctionDressUpFrame, 4, -4)
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
		AuctionsCloseButton:Point("BOTTOMRIGHT", AuctionFrameAuctions, "BOTTOMRIGHT", 66, 10)
		AuctionsCancelAuctionButton:Point("RIGHT", AuctionsCloseButton, "LEFT", -4, 0)
		BidCloseButton:Point("BOTTOMRIGHT", AuctionFrameBid, "BOTTOMRIGHT", 66, 10)
		BidBuyoutButton:Point("RIGHT", BidCloseButton, "LEFT", -4, 0)
		BidBidButton:Point("RIGHT", BidBuyoutButton, "LEFT", -4, 0)
		BrowseCloseButton:Point("BOTTOMRIGHT", AuctionFrameBrowse, "BOTTOMRIGHT", 66, 10)
		BrowseBuyoutButton:Point("RIGHT", BrowseCloseButton, "LEFT", -4, 0)
		BrowseBidButton:Point("RIGHT", BrowseBuyoutButton, "LEFT", -4, 0)
		BrowseResetButton:Point("TOPLEFT", AuctionFrameBrowse, "TOPLEFT", 81, -74)
		BrowseSearchButton:Point("TOPRIGHT", AuctionFrameBrowse, "TOPRIGHT", 25, -34)

		AuctionsItemButton:StripTextures()
		AuctionsItemButton:StyleButton()
		AuctionsItemButton:SetTemplate("Default", true)

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
			SkinEditBox(_G[editbox])
			_G[editbox]:SetTextInsets(1, 1, -1, 1)
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

		-- Custom Backdrops
		AuctionFrameBrowse.bg1 = CreateFrame("Frame", nil, AuctionFrameBrowse)
		AuctionFrameBrowse.bg1:SetTemplate("Overlay")
		AuctionFrameBrowse.bg1:Point("TOPLEFT", 20, -103)
		AuctionFrameBrowse.bg1:Point("BOTTOMRIGHT", -575, 40)
		BrowseFilterScrollFrame:Height(300)

		AuctionFrameBrowse.bg2 = CreateFrame("Frame", nil, AuctionFrameBrowse)
		AuctionFrameBrowse.bg2:SetTemplate("Overlay")
		AuctionFrameBrowse.bg2:Point("TOPLEFT", AuctionFrameBrowse.bg1, "TOPRIGHT", 4, 0)
		AuctionFrameBrowse.bg2:Point("BOTTOMRIGHT", AuctionFrame, "BOTTOMRIGHT", -8, 40)
		AuctionFrameBrowse.bg2:SetFrameLevel(AuctionFrameBrowse.bg2:GetFrameLevel() - 2)
		BrowseScrollFrame:Height(300)

		AuctionFrameBid.bg = CreateFrame("Frame", nil, AuctionFrameBid)
		AuctionFrameBid.bg:SetTemplate("Overlay")
		AuctionFrameBid.bg:Point("TOPLEFT", 22, -72)
		AuctionFrameBid.bg:Point("BOTTOMRIGHT", 66, 39)
		AuctionFrameBid.bg:SetFrameLevel(AuctionFrameBid.bg:GetFrameLevel() - 2)
		BidScrollFrame:Height(332)

		AuctionsScrollFrame:Height(336)
		AuctionFrameAuctions.bg1 = CreateFrame("Frame", nil, AuctionFrameAuctions)
		AuctionFrameAuctions.bg1:SetTemplate("Overlay")
		AuctionFrameAuctions.bg1:Point("TOPLEFT", 15, -70)
		AuctionFrameAuctions.bg1:Point("BOTTOMRIGHT", -545, 35)
		AuctionFrameAuctions.bg1:SetFrameLevel(AuctionFrameAuctions.bg1:GetFrameLevel() - 2)

		AuctionFrameAuctions.bg2 = CreateFrame("Frame", nil, AuctionFrameAuctions)
		AuctionFrameAuctions.bg2:SetTemplate("Overlay")
		AuctionFrameAuctions.bg2:Point("TOPLEFT", AuctionFrameAuctions.bg1, "TOPRIGHT", 3, 0)
		AuctionFrameAuctions.bg2:Point("BOTTOMRIGHT", AuctionFrame, -8, 35)
		AuctionFrameAuctions.bg2:SetFrameLevel(AuctionFrameAuctions.bg2:GetFrameLevel() - 2)
	end

	if addon == "Blizzard_AuctionUI" and IsAddOnLoaded("Auctionator") then
		local buttons = {
			"Atr_Search_Button",
			"Atr_Back_Button",
			"Atr_Buy1_Button",
			"Atr_Adv_Search_Button",
			"Atr_FullScanButton",
			"Auctionator1Button",
			"Atr_ListTabsTab1",
			"Atr_ListTabsTab2",
			"Atr_ListTabsTab3",
			"Atr_CreateAuctionButton",
			"Atr_RemFromSListButton",
			"Atr_AddToSListButton",
			"Atr_SrchSListButton",
			"Atr_DelSListButton",
			"Atr_NewSListButton",
			"Atr_CheckActiveButton",
			"AuctionatorCloseButton",
			"Atr_CancelSelectionButton",
			"Atr_FullScanStartButton",
			"Atr_FullScanDone",
			"Atr_CheckActives_Yes_Button",
			"Atr_CheckActives_No_Button",
			"Atr_Adv_Search_ResetBut",
			"Atr_Adv_Search_OKBut",
			"Atr_Adv_Search_CancelBut",
			"Atr_Buy_Confirm_OKBut",
			"Atr_Buy_Confirm_CancelBut",
			"Atr_MngSListsButton",
			"Auctionator_Search",
		}

		for i = 1, getn(buttons) do
			local frame = _G[buttons[i]]
			if frame then
				_G[buttons[i]]:SkinButton(true)
			end
		end

		local dropdown = {
			"Atr_DropDown1",
			"Atr_Duration",
			"Atr_DropDownSL",
		}

		for i = 1, getn(dropdown) do
			local frame = _G[dropdown[i]]
			if frame then
				SkinDropDownBox(_G[dropdown[i]])
			end
		end

		local editbox = {
			"Atr_StackPriceGold",
			"Atr_StackPriceSilver",
			"Atr_StackPriceCopper",
			"Atr_ItemPriceGold",
			"Atr_ItemPriceSilver",
			"Atr_ItemPriceCopper",
			"Atr_Batch_NumAuctions",
			"Atr_Batch_Stacksize",
			"Atr_Search_Box",
			"Atr_AS_Searchtext",
			"Atr_AS_Minlevel",
			"Atr_AS_Maxlevel",
			"Atr_AS_MinItemlevel",
			"Atr_AS_MaxItemlevel",
		}

		for i = 1, getn(editbox) do
			local frame = _G[editbox[i]]
			if frame then
				SkinEditBox(_G[editbox[i]])
			end
		end

		local frames = {
			"Atr_FullScanResults",
			"Atr_Adv_Search_Dialog",
			"Atr_FullScanFrame",
			"Atr_HeadingsBar",
			"Atr_Error_Frame",
			"Atr_Hlist",
			"Atr_Buy_Confirm_Frame",
			"Atr_CheckActives_Frame",
			"Atr_Hilite1",
		}

		for i = 1, getn(frames) do
			local frame = _G[frames[i]]
			if frame then
				_G[frames[i]]:StripTextures()
			end
		end

		Atr_FullScanResults:SetTemplate("Transparent")
		Atr_Adv_Search_Dialog:SetTemplate("Transparent")
		Atr_FullScanFrame:SetTemplate("Transparent")
		Atr_Buy_Confirm_Frame:SetTemplate("Default")
		Atr_CheckActives_Frame:SetTemplate("Default")
		Atr_Error_Frame:SetTemplate("Transparent")

		Atr_HeadingsBar:CreateBackdrop("Overlay")
		Atr_HeadingsBar.backdrop:Point("TOPLEFT", 0, -25)
		Atr_HeadingsBar.backdrop:Point("BOTTOMRIGHT", 3, -182)

		Atr_SellControls:CreateBackdrop("Overlay")
		Atr_SellControls.backdrop:Point("TOPLEFT", -2, 0)
		Atr_SellControls.backdrop:Point("BOTTOMRIGHT", 24, 1)

		Atr_Hlist:SetTemplate("Overlay")
		Atr_Hlist:Width(196)
		Atr_Hlist:ClearAllPoints()
		Atr_Hlist:Point("TOPLEFT", -195, -75)

		Atr_Hilite1:CreateBackdrop("Overlay")
		Atr_Hilite1.backdrop:Point("TOPLEFT", 1, -3)
		Atr_Hilite1.backdrop:Point("BOTTOMRIGHT", 3, -1)

		Atr_Search_Box:Height(Atr_Search_Box:GetHeight() - 2)
		Auctionator1Button:Height(22)
		Atr_Search_Button:Height(22)
		Atr_Adv_Search_Button:Height(22)
		Atr_Back_Button:Height(22)
		Atr_FullScanButton:Height(22)
		Atr_FullScanButton:Point("LEFT", Atr_Adv_Search_Button, "RIGHT", 3, 0)
		Atr_FullScanButton:Point("RIGHT", Auctionator1Button, "LEFT", -3, 0)

		Atr_CreateAuctionButton:Width(165)
		Atr_CreateAuctionButton:ClearAllPoints()
		Atr_CreateAuctionButton:Point("CENTER", 14, -20)

		for i = 4, 6 do
			SkinTab(_G["AuctionFrameTab"..i])
		end

		AuctionatorCloseButton:ClearAllPoints()
		AuctionatorCloseButton:Point("BOTTOMLEFT", Atr_Main_Panel, "BOTTOMRIGHT", -14, 10)
		Atr_Buy1_Button:Point("RIGHT", AuctionatorCloseButton, "LEFT", -4, 0)
		Atr_CancelSelectionButton:Point("RIGHT", Atr_Buy1_Button, "LEFT", -4, 0)

		Atr_RecommendItem_Tex:SetTemplate("Default")
		Atr_RecommendItem_Tex:StyleButton()
		Atr_SellControls_Tex:SetTemplate("Default")
		Atr_SellControls_Tex:StyleButton()
	end

	-- BarbershopUI
	if addon == "Blizzard_BarbershopUI" then
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

		BarberShopAltFormFrameBorder:StripTextures()
		BarberShopAltFormFrame:Point("BOTTOM", BarberShopFrame, "TOP", 0, 5)
		BarberShopAltFormFrame:StripTextures()
		BarberShopAltFormFrame:CreateBackdrop("Transparent")
	end

	-- MacroUI
	if addon == "Blizzard_MacroUI" then
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

		if T.PTRVersion() then
			tinsert(buttons, "MacroSaveButton")
			tinsert(buttons, "MacroCancelButton")
		end

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
		MacroFrame:Width(360)
		MacroFrame:StripTextures()
		MacroFrame:CreateBackdrop("Transparent")
		MacroFrame.backdrop:Point("TOPLEFT", 0, -12)
		MacroFrame.backdrop:Point("BOTTOMRIGHT", 0, 30)
		MacroFrameTextBackground:StripTextures()
		MacroFrameTextBackground:CreateBackdrop("Overlay")
		MacroButtonScrollFrame:CreateBackdrop("Overlay")
		MacroPopupFrame:StripTextures()
		MacroPopupFrame:SetTemplate("Transparent")
		MacroPopupScrollFrame:StripTextures()
		MacroPopupScrollFrame:CreateBackdrop("Overlay")
		MacroPopupScrollFrame.backdrop:Point("TOPLEFT", 51, 2)
		MacroPopupScrollFrame.backdrop:Point("BOTTOMRIGHT", -4, 4)
		MacroPopupEditBox:CreateBackdrop("Overlay")
		MacroPopupEditBox:StripTextures(true)
		SkinCloseButton(MacroFrameCloseButton, MacroFrame.backdrop)

		-- Reposition edit button
		MacroEditButton:ClearAllPoints()
		MacroEditButton:Point("BOTTOMLEFT", MacroFrameSelectedMacroButton, "BOTTOMRIGHT", 10, 0)

		-- Regular scroll bar
		SkinScrollBar(MacroButtonScrollFrame)

		MacroPopupFrame:HookScript("OnShow", function(self)
			self:ClearAllPoints()
			self:Point("TOPLEFT", MacroFrame, "TOPRIGHT", 3, -12)
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

	-- DebugTools
	if addon == "Blizzard_DebugTools" then
		ScriptErrorsFrame:SetTemplate("Transparent")
		EventTraceFrame:SetTemplate("Transparent")
		SkinCloseButton(ScriptErrorsFrameClose)
		_G["EventTraceTooltip"]:HookScript("OnShow", function(self) self:SetTemplate("Transparent") end)

		local texs = {
			"TopLeft",
			"TopRight",
			"Top",
			"BottomLeft",
			"BottomRight",
			"Bottom",
			"Left",
			"Right",
			"TitleBG",
			"DialogBG",
		}

		for i = 1, #texs do
			_G["ScriptErrorsFrame"..texs[i]]:SetTexture(nil)
			_G["EventTraceFrame"..texs[i]]:SetTexture(nil)
		end

		for i = 1, ScriptErrorsFrame:GetNumChildren() do
			local child = select(i, ScriptErrorsFrame:GetChildren())
			if child:GetObjectType() == "Button" and not child:GetName() then
				child:SkinButton()
			end
		end
	end

	-- TrainerUI
	if addon == "Blizzard_TrainerUI" then
		local StripAllTextures = {
			"ClassTrainerFrame",
			"ClassTrainerScrollFrameScrollChild",
			"ClassTrainerFrameSkillStepButton",
			"ClassTrainerFrameBottomInset",
		}

		local buttons = {
			"ClassTrainerTrainButton",
		}

		local KillTextures = {
			"ClassTrainerFrameInset",
			"ClassTrainerFramePortrait",
			"ClassTrainerScrollFrameScrollBarBG",
			"ClassTrainerScrollFrameScrollBarTop",
			"ClassTrainerScrollFrameScrollBarBottom",
			"ClassTrainerScrollFrameScrollBarMiddle",
		}

		for i = 1, 8 do
			_G["ClassTrainerScrollFrameButton"..i]:StripTextures()
			_G["ClassTrainerScrollFrameButton"..i]:StyleButton()
			_G["ClassTrainerScrollFrameButton"..i.."Icon"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			_G["ClassTrainerScrollFrameButton"..i]:CreateBackdrop()
			_G["ClassTrainerScrollFrameButton"..i].backdrop:Point("TOPLEFT", _G["ClassTrainerScrollFrameButton"..i.."Icon"], "TOPLEFT", -2, 2)
			_G["ClassTrainerScrollFrameButton"..i].backdrop:Point("BOTTOMRIGHT", _G["ClassTrainerScrollFrameButton"..i.."Icon"], "BOTTOMRIGHT", 2, -2)
			_G["ClassTrainerScrollFrameButton"..i.."Icon"]:SetParent(_G["ClassTrainerScrollFrameButton"..i].backdrop)

			_G["ClassTrainerScrollFrameButton"..i].selectedTex:SetTexture(1, 1, 1, 0.3)
			_G["ClassTrainerScrollFrameButton"..i].selectedTex:ClearAllPoints()
			_G["ClassTrainerScrollFrameButton"..i].selectedTex:Point("TOPLEFT", 2, -2)
			_G["ClassTrainerScrollFrameButton"..i].selectedTex:Point("BOTTOMRIGHT", -2, 2)
		end

		for _, object in pairs(StripAllTextures) do
			_G[object]:StripTextures()
		end

		for _, texture in pairs(KillTextures) do
			_G[texture]:Kill()
		end

		for i = 1, #buttons do
			_G[buttons[i]]:StripTextures()
			_G[buttons[i]]:SkinButton()
		end

		SkinDropDownBox(ClassTrainerFrameFilterDropDown, 155)

		ClassTrainerFrame:CreateBackdrop("Transparent")
		ClassTrainerFrame.backdrop:Point("TOPLEFT", ClassTrainerFrame, "TOPLEFT")
		ClassTrainerFrame.backdrop:Point("BOTTOMRIGHT", ClassTrainerFrame, "BOTTOMRIGHT")
		SkinCloseButton(ClassTrainerFrameCloseButton, ClassTrainerFrame)
		ClassTrainerFrameSkillStepButton.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		ClassTrainerFrameSkillStepButton:CreateBackdrop("Default")
		ClassTrainerFrameSkillStepButton.backdrop:Point("TOPLEFT", ClassTrainerFrameSkillStepButton.icon, "TOPLEFT", -2, 2)
		ClassTrainerFrameSkillStepButton.backdrop:Point("BOTTOMRIGHT", ClassTrainerFrameSkillStepButton.icon, "BOTTOMRIGHT", 2, -2)
		ClassTrainerFrameSkillStepButton.icon:SetParent(ClassTrainerFrameSkillStepButton.backdrop)

		ClassTrainerStatusBar:StripTextures()
		ClassTrainerStatusBar:SetStatusBarTexture(C.media.texture)
		ClassTrainerStatusBar:CreateBackdrop("Overlay")
		ClassTrainerStatusBar:ClearAllPoints()
		ClassTrainerStatusBar:Point("RIGHT", ClassTrainerFrameFilterDropDown, "LEFT", 10, 3)
		ClassTrainerStatusBar.rankText:ClearAllPoints()
		ClassTrainerStatusBar.rankText:SetPoint("CENTER", ClassTrainerStatusBar, "CENTER")
	end

	-- ItemSocketingUI
	if addon == "Blizzard_ItemSocketingUI" then
		ItemSocketingFrame:StripTextures()
		ItemSocketingFrame:CreateBackdrop("Transparent")
		ItemSocketingFrame.backdrop:Point("TOPLEFT", 16, -12)
		ItemSocketingFrame.backdrop:Point("BOTTOMRIGHT", 0, 20)
		ItemSocketingScrollFrame:StripTextures()
		ItemSocketingScrollFrame:CreateBackdrop("Overlay")

		for i = 1, MAX_NUM_SOCKETS  do
			local button = _G["ItemSocketingSocket"..i]
			local button_bracket = _G["ItemSocketingSocket"..i.."BracketFrame"]
			local button_bg = _G["ItemSocketingSocket"..i.."Background"]
			local button_icon = _G["ItemSocketingSocket"..i.."IconTexture"]
			button:StripTextures()
			button:StyleButton(false)
			button:SetTemplate("Overlay", true)
			button_bracket:Kill()
			button_bg:Kill()
			button_icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			button_icon:ClearAllPoints()
			button_icon:Point("TOPLEFT", 2, -2)
			button_icon:Point("BOTTOMRIGHT", -2, 2)
			ItemSocketingFrame:HookScript("OnUpdate", function(self)
				gemColor = GetSocketTypes(i)
				local color = GEM_TYPE_INFO[gemColor]
				button:SetBackdropBorderColor(color.r, color.g, color.b)
				button.overlay:SetVertexColor(color.r, color.g, color.b, 0.35)
			end)
		end

		ItemSocketingFramePortrait:Kill()
		ItemSocketingSocketButton:ClearAllPoints()
		ItemSocketingSocketButton:Point("BOTTOMRIGHT", ItemSocketingFrame.backdrop, "BOTTOMRIGHT", -5, 5)
		ItemSocketingSocketButton:SkinButton()
		SkinCloseButton(ItemSocketingCloseButton, ItemSocketingFrame.backdrop)
	end

	-- Stuff not in Blizzard load-on-demand
	if addon == "ShestakUI_Extra" then
		-- Tutorial Frame
		do
			TutorialFrame:StripTextures()
			TutorialFrame:CreateBackdrop("Transparent")
			TutorialFrame.backdrop:Point("TOPLEFT", 6, 0)
			TutorialFrame.backdrop:Point("BOTTOMRIGHT", 0, -6)
			SkinNextPrevButton(TutorialFrameNextButton)
			SkinNextPrevButton(TutorialFramePrevButton)
			TutorialFrameOkayButton:SkinButton()
			TutorialFrameOkayButton:ClearAllPoints()
			TutorialFrameOkayButton:Point("LEFT", TutorialFrameNextButton, "RIGHT", 10, 0)
			SkinCloseButton(TutorialFrameCloseButton, TutorialFrame.backdrop)
		end

		-- Bank/Container Frame
		if C.bag.enable ~= true or (not IsAddOnLoaded("cargBags") or not IsAddOnLoaded("cargBags_Nivaya")) then
			-- Container Frame
			BackpackTokenFrame:StripTextures()

			for i = 1, NUM_CONTAINER_FRAMES do
				local frame = _G["ContainerFrame"..i]
				local close = _G["ContainerFrame"..i.."CloseButton"]
				frame:StripTextures(true)
				frame:CreateBackdrop("Transparent")
				frame.backdrop:Point("TOPLEFT", 4, -2)
				frame.backdrop:Point("BOTTOMRIGHT", 0, 2)

				SkinCloseButton(close, frame.backdrop)

				for j = 1, MAX_CONTAINER_ITEMS do
					local item = _G["ContainerFrame"..i.."Item"..j]
					local icon = _G["ContainerFrame"..i.."Item"..j.."IconTexture"]
					local quest = _G["ContainerFrame"..i.."Item"..j.."IconQuestTexture"]
					item:SetNormalTexture(nil)
					item:StyleButton()
					item:SetTemplate()

					icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					icon:ClearAllPoints()
					icon:Point("TOPLEFT", 2, -2)
					icon:Point("BOTTOMRIGHT", -2, 2)

					quest:SetVertexColor(1, 1, 0)
					quest:SetTexCoord(0.05, 0.955, 0.05, 0.955)
				end
			end

			-- Bank Frame
			BankFrame:StripTextures(true)
			BankFrame:CreateBackdrop("Transparent")
			BankFrame.backdrop:Point("TOPLEFT", 16, -12)
			BankFrame.backdrop:Point("BOTTOMRIGHT", -25, 76)

			BankFramePurchaseButton:SkinButton()

			SkinCloseButton(BankCloseButton, BankFrame.backdrop)

			for i = 1, 28 do
				local item = _G["BankFrame".."Item"..i]
				local icon = _G["BankFrame".."Item"..i.."IconTexture"]
				local quest = _G["BankFrame".."Item"..i.."IconQuestTexture"]
				item:SetNormalTexture(nil)
				item:StyleButton()
				item:SetTemplate()

				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				icon:ClearAllPoints()
				icon:Point("TOPLEFT", 2, -2)
				icon:Point("BOTTOMRIGHT", -2, 2)

				quest:SetVertexColor(1, 1, 0)
				quest:SetTexCoord(0.05, 0.955, 0.05, 0.955)
			end

			for i = 1, 7 do
				local bag = _G["BankFrameBag"..i]
				local icon = _G["BankFrameBag"..i.."IconTexture"]
				local highlight = _G["BankFrameBag"..i.."HighlightFrameTexture"]

				bag:SetNormalTexture(nil)
				bag:StyleButton()
				bag:SetTemplate()

				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				icon:ClearAllPoints()
				icon:Point("TOPLEFT", 2, -2)
				icon:Point("BOTTOMRIGHT", -2, 2)

				highlight:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				highlight:ClearAllPoints()
				highlight:Point("TOPLEFT", 2, -2)
				highlight:Point("BOTTOMRIGHT", -2, 2)
			end
		end

		-- Achievement Popup Frames
		do
			local function SkinAchievePopUp()
				for i = 1, MAX_ACHIEVEMENT_ALERTS do
					local frame = _G["AchievementAlertFrame"..i]

					if frame then
						frame:SetAlpha(1)
						frame.SetAlpha = T.dummy
						if not frame.backdrop then
							frame:CreateBackdrop("Transparent")
							frame.backdrop:Point("TOPLEFT", _G[frame:GetName().."Background"], "TOPLEFT", -2, -6)
							frame.backdrop:Point("BOTTOMRIGHT", _G[frame:GetName().."Background"], "BOTTOMRIGHT", -2, 6)
						end

						-- Background
						_G["AchievementAlertFrame"..i.."Background"]:SetTexture(nil)
						_G["AchievementAlertFrame"..i.."Glow"]:Kill()
						_G["AchievementAlertFrame"..i.."Shine"]:Kill()

						-- Text
						_G["AchievementAlertFrame"..i.."Name"]:SetTextColor(1, 0.8, 0)
						_G["AchievementAlertFrame"..i.."Name"]:SetFont(C.media.normal_font, 14)
						_G["AchievementAlertFrame"..i.."Unlocked"]:SetTextColor(1, 1, 1)
						_G["AchievementAlertFrame"..i.."Unlocked"]:SetFont(C.media.normal_font, 11)

						-- Icon
						_G["AchievementAlertFrame"..i.."IconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
						_G["AchievementAlertFrame"..i.."IconOverlay"]:Kill()
						_G["AchievementAlertFrame"..i.."IconTexture"]:ClearAllPoints()
						_G["AchievementAlertFrame"..i.."IconTexture"]:Point("LEFT", frame, 7, 0)

						if not _G["AchievementAlertFrame"..i.."IconTexture"].b then
							_G["AchievementAlertFrame"..i.."IconTexture"].b = CreateFrame("Frame", nil, _G["AchievementAlertFrame"..i])
							_G["AchievementAlertFrame"..i.."IconTexture"].b:SetFrameLevel(0)
							_G["AchievementAlertFrame"..i.."IconTexture"].b:SetTemplate("Default")
							_G["AchievementAlertFrame"..i.."IconTexture"].b:Point("TOPLEFT", _G["AchievementAlertFrame"..i.."IconTexture"], "TOPLEFT", -2, 2)
							_G["AchievementAlertFrame"..i.."IconTexture"].b:Point("BOTTOMRIGHT", _G["AchievementAlertFrame"..i.."IconTexture"], "BOTTOMRIGHT", 2, -2)
						end
					end
				end
			end
			hooksecurefunc("AchievementAlertFrame_FixAnchors", SkinAchievePopUp)

			function SkinDungeonPopUp()
				for i = 1, DUNGEON_COMPLETION_MAX_REWARDS do
					local frame = _G["DungeonCompletionAlertFrame"..i]

					if frame then
						frame:SetAlpha(1)
						frame.SetAlpha = T.dummy
						if not frame.backdrop then
							frame:CreateBackdrop("Transparent")
							frame.backdrop:Point("TOPLEFT", frame, "TOPLEFT", -2, -6)
							frame.backdrop:Point("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 6)
						end

						-- Background
						for i = 1, frame:GetNumRegions() do
							local region = select(i, frame:GetRegions())
							if region:GetObjectType() == "Texture" then
								if region:GetTexture() == "Interface\\LFGFrame\\UI-LFG-DUNGEONTOAST" then
									region:Kill()
								end
							end
						end
						_G["DungeonCompletionAlertFrame"..i.."Shine"]:Kill()
						_G["DungeonCompletionAlertFrame"..i.."GlowFrame"]:Kill()
						_G["DungeonCompletionAlertFrame"..i.."GlowFrame"].glow:Kill()

						-- Icon
						_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
						_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"]:ClearAllPoints()
						_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"]:Point("LEFT", frame, 7, 0)

						if not _G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b then
							_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b = CreateFrame("Frame", nil, _G["DungeonCompletionAlertFrame"..i])
							_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b:SetFrameLevel(0)
							_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b:SetTemplate("Default")
							_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b:Point("TOPLEFT", _G["DungeonCompletionAlertFrame"..i.."DungeonTexture"], "TOPLEFT", -2, 2)
							_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b:Point("BOTTOMRIGHT", _G["DungeonCompletionAlertFrame"..i.."DungeonTexture"], "BOTTOMRIGHT", 2, -2)
						end
					end
				end
			end
			hooksecurefunc("DungeonCompletionAlertFrame_FixAnchors", SkinDungeonPopUp)
		end

		-- WorldState Frame
		do
			WorldStateScoreScrollFrame:StripTextures()
			WorldStateScoreFrame:StripTextures()
			WorldStateScoreFrame:SetTemplate("Transparent")
			SkinCloseButton(WorldStateScoreFrameCloseButton)
			WorldStateScoreFrameInset:Kill()
			WorldStateScoreFrameLeaveButton:SkinButton()

			for i = 1, WorldStateScoreScrollFrameScrollChildFrame:GetNumChildren() do
				local b = _G["WorldStateScoreButton"..i]
				b:StripTextures()
				b:StyleButton(false)
				b:SetTemplate("Default", true)
			end

			for i = 1, 3 do
				SkinTab(_G["WorldStateScoreFrameTab"..i])
			end
		end

		-- Merchant Frame
		do
			local frames = {
				"MerchantBuyBackItem",
				"MerchantFrame",
			}

			-- Main frames
			for i = 1, #frames do
				_G[frames[i]]:StripTextures(true)
				_G[frames[i]]:CreateBackdrop("Transparent")
			end
			MerchantBuyBackItem.backdrop:Point("TOPLEFT", -6, 6)
			MerchantBuyBackItem.backdrop:Point("BOTTOMRIGHT", 6, -6)
			MerchantFrame.backdrop:Point("TOPLEFT", 6, -12)
			MerchantFrame.backdrop:Point("BOTTOMRIGHT", 0, 60)

			-- Skin tabs
			for i= 1, 2 do
				SkinTab(_G["MerchantFrameTab"..i])
			end

			-- Icons/merchant slots
			for i = 1, 12 do
				local b = _G["MerchantItem"..i.."ItemButton"]
				local t = _G["MerchantItem"..i.."ItemButtonIconTexture"]
				local item_bar = _G["MerchantItem"..i]
				item_bar:StripTextures(true)
				item_bar:CreateBackdrop("Overlay")

				b:StripTextures()
				b:StyleButton(false)
				b:SetTemplate("Default", true)
				b:Point("TOPLEFT", item_bar, "TOPLEFT", 4, -4)
				t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				t:ClearAllPoints()
				t:Point("TOPLEFT", 2, -2)
				t:Point("BOTTOMRIGHT", -2, 2)

				_G["MerchantItem"..i.."MoneyFrame"]:ClearAllPoints()
				_G["MerchantItem"..i.."MoneyFrame"]:Point("BOTTOMLEFT", b, "BOTTOMRIGHT", 3, 0)
			end

			-- Buyback item frame + icon
			MerchantBuyBackItemItemButton:StripTextures()
			MerchantBuyBackItemItemButton:StyleButton(false)
			MerchantBuyBackItemItemButton:SetTemplate("Default", true)
			MerchantBuyBackItemItemButtonIconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			MerchantBuyBackItemItemButtonIconTexture:ClearAllPoints()
			MerchantBuyBackItemItemButtonIconTexture:Point("TOPLEFT", 2, -2)
			MerchantBuyBackItemItemButtonIconTexture:Point("BOTTOMRIGHT", -2, 2)

			MerchantRepairItemButton:StyleButton(false)
			MerchantRepairItemButton:SetTemplate("Default", true)
			for i = 1, MerchantRepairItemButton:GetNumRegions() do
				local region = select(i, MerchantRepairItemButton:GetRegions())
				if region:GetObjectType() == "Texture" and region:GetTexture() == "Interface\\MerchantFrame\\UI-Merchant-RepairIcons" then
					region:SetTexCoord(0.04, 0.24, 0.06, 0.5)
					region:ClearAllPoints()
					region:Point("TOPLEFT", 2, -2)
					region:Point("BOTTOMRIGHT", -2, 2)
				end
			end

			MerchantGuildBankRepairButton:StyleButton()
			MerchantGuildBankRepairButton:SetTemplate("Default", true)
			MerchantGuildBankRepairButtonIcon:SetTexCoord(0.61, 0.82, 0.1, 0.52)
			MerchantGuildBankRepairButtonIcon:ClearAllPoints()
			MerchantGuildBankRepairButtonIcon:Point("TOPLEFT", 2, -2)
			MerchantGuildBankRepairButtonIcon:Point("BOTTOMRIGHT", -2, 2)

			MerchantRepairAllButton:StyleButton(false)
			MerchantRepairAllButton:SetTemplate("Default", true)
			MerchantRepairAllIcon:SetTexCoord(0.34, 0.1, 0.34, 0.535, 0.535, 0.1, 0.535, 0.535)
			MerchantRepairAllIcon:ClearAllPoints()
			MerchantRepairAllIcon:Point("TOPLEFT", 2, -2)
			MerchantRepairAllIcon:Point("BOTTOMRIGHT", -2, 2)

			-- Misc frames
			MerchantFrame:Width(360)
			SkinCloseButton(MerchantFrameCloseButton, MerchantFrame.backdrop)
			SkinNextPrevButton(MerchantNextPageButton)
			SkinNextPrevButton(MerchantPrevPageButton)

			-- Reposition tabs
			MerchantFrameTab1:ClearAllPoints()
			MerchantFrameTab1:SetPoint("TOPLEFT", MerchantFrame.backdrop, "BOTTOMLEFT", 0, 2)
		end

		-- Mail Frame
		do
			MailFrame:StripTextures(true)
			MailFrame:CreateBackdrop("Transparent")
			MailFrame.backdrop:Point("TOPLEFT", 16, -12)
			MailFrame.backdrop:Point("BOTTOMRIGHT", -30, 76)

			for i = 1, INBOXITEMS_TO_DISPLAY do
				local bg = _G["MailItem"..i]
				bg:StripTextures()
				bg:CreateBackdrop("Overlay")
				bg.backdrop:Point("TOPLEFT", 2, 1)
				bg.backdrop:Point("BOTTOMRIGHT", -2, 2)

				local b = _G["MailItem"..i.."Button"]
				b:StripTextures()
				b:SetTemplate("Default", true)
				b:StyleButton()

				local t = _G["MailItem"..i.."ButtonIcon"]
				t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				t:ClearAllPoints()
				t:Point("TOPLEFT", 2, -2)
				t:Point("BOTTOMRIGHT", -2, 2)
			end

			SkinCloseButton(InboxCloseButton, MailFrame.backdrop)
			SkinNextPrevButton(InboxPrevPageButton)
			SkinNextPrevButton(InboxNextPageButton)

			MailFrameTab1:StripTextures()
			MailFrameTab2:StripTextures()
			SkinTab(MailFrameTab1)
			SkinTab(MailFrameTab2)

			-- Reposition tabs
			MailFrameTab1:ClearAllPoints()
			MailFrameTab1:SetPoint("TOPLEFT", MailFrame.backdrop, "BOTTOMLEFT", 0, 2)
			MailFrameTab1.SetPoint = T.dummy

			-- Send mail
			SendMailScrollFrame:StripTextures(true)
			SendMailScrollFrame:CreateBackdrop("Overlay")
			SendMailScrollFrame.backdrop:Point("TOPLEFT", 12, 0)
			SendMailScrollFrame.backdrop:Point("BOTTOMRIGHT", 0, 0)

			SkinScrollBar(SendMailScrollFrameScrollBar)

			SkinEditBox(SendMailNameEditBox)
			SkinEditBox(SendMailSubjectEditBox)
			SkinEditBox(SendMailMoneyGold)
			SkinEditBox(SendMailMoneySilver)
			SkinEditBox(SendMailMoneyCopper)

			SendMailNameEditBox.backdrop:Point("BOTTOMRIGHT", 2, 0)
			SendMailSubjectEditBox.backdrop:Point("BOTTOMRIGHT", 2, 0)
			SendMailFrame:StripTextures()

			local function MailFrameSkin()
				for i = 1, ATTACHMENTS_MAX_SEND do
					local b = _G["SendMailAttachment"..i]
					if not b.skinned then
						b:StripTextures()
						b:SetTemplate("Default", true)
						b:StyleButton()
						b.skinned = true
					end
					local t = b:GetNormalTexture()
					if t then
						t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
						t:ClearAllPoints()
						t:Point("TOPLEFT", 2, -2)
						t:Point("BOTTOMRIGHT", -2, 2)
					end
				end
			end
			hooksecurefunc("SendMailFrame_Update", MailFrameSkin)

			SendMailMailButton:SkinButton()
			SendMailCancelButton:SkinButton()

			-- Open mail (cod)
			OpenMailFrame:StripTextures(true)
			OpenMailFrame:CreateBackdrop("Transparent")
			OpenMailFrame.backdrop:Point("TOPLEFT", 16, -12)
			OpenMailFrame.backdrop:Point("BOTTOMRIGHT", -30, 76)

			SkinCloseButton(OpenMailCloseButton, OpenMailFrame.backdrop)
			OpenMailReportSpamButton:SkinButton()
			OpenMailReplyButton:SkinButton()
			OpenMailDeleteButton:SkinButton()
			OpenMailCancelButton:SkinButton()

			OpenMailScrollFrame:StripTextures(true)
			OpenMailScrollFrame:CreateBackdrop("Overlay")
			OpenMailScrollFrame.backdrop:Point("TOPLEFT", 12, 0)
			OpenMailScrollFrame.backdrop:Point("BOTTOMRIGHT", 0, 0)

			OpenMailScrollChildFrame:Point("TOPLEFT", 10, 0)

			SkinScrollBar(OpenMailScrollFrameScrollBar)

			SendMailBodyEditBox:SetTextColor(1, 1, 1)
			OpenMailBodyText:SetTextColor(1, 1, 1)
			InvoiceTextFontNormal:SetTextColor(1, 1, 1)
			OpenMailArithmeticLine:Kill()

			OpenMailLetterButton:StripTextures()
			OpenMailLetterButton:SetTemplate("Default", true)
			OpenMailLetterButton:StyleButton()
			OpenMailLetterButtonIconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			OpenMailLetterButtonIconTexture:ClearAllPoints()
			OpenMailLetterButtonIconTexture:Point("TOPLEFT", 2, -2)
			OpenMailLetterButtonIconTexture:Point("BOTTOMRIGHT", -2, 2)

			OpenMailMoneyButton:StripTextures()
			OpenMailMoneyButton:SetTemplate("Default", true)
			OpenMailMoneyButton:StyleButton()
			OpenMailMoneyButtonIconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			OpenMailMoneyButtonIconTexture:ClearAllPoints()
			OpenMailMoneyButtonIconTexture:Point("TOPLEFT", 2, -2)
			OpenMailMoneyButtonIconTexture:Point("BOTTOMRIGHT", -2, 2)

			for i = 1, ATTACHMENTS_MAX_SEND do
				local b = _G["OpenMailAttachmentButton"..i]
				b:StripTextures()
				b:SetTemplate("Default", true)
				b:StyleButton()

				local t = _G["OpenMailAttachmentButton"..i.."IconTexture"]
				if t then
					t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					t:ClearAllPoints()
					t:Point("TOPLEFT", 2, -2)
					t:Point("BOTTOMRIGHT", -2, 2)
				end
			end

			OpenMailReplyButton:Point("RIGHT", OpenMailDeleteButton, "LEFT", -2, 0)
			OpenMailDeleteButton:Point("RIGHT", OpenMailCancelButton, "LEFT", -2, 0)
			SendMailMailButton:Point("RIGHT", SendMailCancelButton, "LEFT", -2, 0)
		end

		-- Help Frame
		do
			local frames = {
				"HelpFrameLeftInset",
				"HelpFrameMainInset",
				"HelpFrameKnowledgebase",
				"HelpFrameKnowledgebaseErrorFrame",
			}

			local buttons = {
				"HelpFrameAccountSecurityOpenTicket",
				"HelpFrameReportLagLoot",
				"HelpFrameReportLagAuctionHouse",
				"HelpFrameReportLagMail",
				"HelpFrameReportLagMovement",
				"HelpFrameReportLagSpell",
				"HelpFrameReportLagChat",
				"HelpFrameReportAbuseOpenTicket",
				"HelpFrameOpenTicketHelpTopIssues",
				"HelpFrameOpenTicketHelpOpenTicket",
				"HelpFrameKnowledgebaseSearchButton",
				"HelpFrameKnowledgebaseNavBarHomeButton",
				"HelpFrameCharacterStuckStuck",
				"GMChatOpenLog",
				"HelpFrameTicketSubmit",
				"HelpFrameTicketCancel",
			}

			-- Main frames
			for i = 1, #frames do
				_G[frames[i]]:StripTextures(true)
				_G[frames[i]]:CreateBackdrop("Overlay")
			end

			HelpFrameHeader:StripTextures(true)
			HelpFrameHeader:SetFrameLevel(HelpFrameHeader:GetFrameLevel() + 2)
			HelpFrameKnowledgebaseErrorFrame:SetFrameLevel(HelpFrameKnowledgebaseErrorFrame:GetFrameLevel() + 2)

			HelpFrameTicketScrollFrame:StripTextures()
			HelpFrameTicketScrollFrame:CreateBackdrop("Overlay")
			HelpFrameTicketScrollFrame.backdrop:Point("TOPLEFT", -4, 4)
			HelpFrameTicketScrollFrame.backdrop:Point("BOTTOMRIGHT", 6, -4)

			for i = 1, HelpFrameTicket:GetNumChildren() do
				local child = select(i, HelpFrameTicket:GetChildren())
				if not child:GetName() then
					child:StripTextures()
				end
			end

			SkinScrollBar(HelpFrameKnowledgebaseScrollFrame2ScrollBar)

			-- Sub buttons
			for i = 1, #buttons do
				_G[buttons[i]]:StripTextures(true)
				_G[buttons[i]]:SkinButton(true)

				if _G[buttons[i]].text then
					_G[buttons[i]].text:ClearAllPoints()
					_G[buttons[i]].text:SetPoint("CENTER")
					_G[buttons[i]].text:SetJustifyH("CENTER")
				end
			end

			-- Main buttons
			for i = 1, 6 do
				local b = _G["HelpFrameButton"..i]
				b:SkinButton(true)
				b.text:ClearAllPoints()
				b.text:SetPoint("CENTER")
				b.text:SetJustifyH("CENTER")
			end

			-- Table options
			for i = 1, HelpFrameKnowledgebaseScrollFrameScrollChild:GetNumChildren() do
				local b = _G["HelpFrameKnowledgebaseScrollFrameButton"..i]
				b:StripTextures(true)
				b:SkinButton(true)
			end

			-- Misc items
			HelpFrameKnowledgebaseSearchBox:ClearAllPoints()
			HelpFrameKnowledgebaseSearchBox:Point("TOPLEFT", HelpFrameMainInset, "TOPLEFT", 13, -10)
			HelpFrameKnowledgebaseNavBarOverlay:Kill()
			if T.PTRVersion() then
				HelpFrameKnowledgebaseNavBar:StripTextures()
			end
			HelpFrame:StripTextures(true)
			HelpFrame:CreateBackdrop("Transparent")
			SkinEditBox(HelpFrameKnowledgebaseSearchBox)
			SkinScrollBar(HelpFrameKnowledgebaseScrollFrameScrollBar)
			SkinCloseButton(HelpFrameCloseButton, HelpFrame.backdrop)
			SkinCloseButton(HelpFrameKnowledgebaseErrorFrameCloseButton, HelpFrameKnowledgebaseErrorFrame.backdrop)			

			-- Hearth Stone Button
			HelpFrameCharacterStuckHearthstone:StyleButton()
			HelpFrameCharacterStuckHearthstone:SetTemplate("Default", true)
			HelpFrameCharacterStuckHearthstone.IconTexture:ClearAllPoints()
			HelpFrameCharacterStuckHearthstone.IconTexture:Point("TOPLEFT", 2, -2)
			HelpFrameCharacterStuckHearthstone.IconTexture:Point("BOTTOMRIGHT", -2, 2)
			HelpFrameCharacterStuckHearthstone.IconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)

			local function navButtonFrameLevel(self)
				for i = 1, #self.navList do
					local navButton = self.navList[i]
					local lastNav = self.navList[i-1]
					if navButton and lastNav then
						navButton:SetFrameLevel(lastNav:GetFrameLevel() - 2)
						navButton:ClearAllPoints()
						navButton:Point("LEFT", lastNav, "RIGHT", 3, 0)
					end
				end
			end

			hooksecurefunc("NavBar_AddButton", function(self, buttonData)
				local navButton = self.navList[#self.navList]

				if not navButton.skinned then
					navButton:SkinButton(true)
					navButton.skinned = true

					navButton:HookScript("OnClick", function()
						navButtonFrameLevel(self)
					end)
				end

				navButtonFrameLevel(self)
			end)

			HelpFrameGM_ResponseNeedMoreHelp:SkinButton()
			HelpFrameGM_ResponseCancel:SkinButton()
			for i = 1, HelpFrameGM_Response:GetNumChildren() do
				local child = select(i, HelpFrameGM_Response:GetChildren())
				if child and child:GetObjectType() == "Frame" and not child:GetName() then
					child:SetTemplate("Default")
				end
			end
		end

		-- Trade Frame
		do
			TradeFrame:StripTextures(true)
			TradeFrame:CreateBackdrop("Transparent")
			TradeFrame.backdrop:Point("TOPLEFT", 16, -12)
			TradeFrame.backdrop:Point("BOTTOMRIGHT", -20, 45)
			TradeFrameTradeButton:SkinButton(true)
			TradeFrameCancelButton:SkinButton(true)
			SkinCloseButton(TradeFrameCloseButton, TradeFrame.backdrop)

			SkinEditBox(TradePlayerInputMoneyFrameGold)
			SkinEditBox(TradePlayerInputMoneyFrameSilver)
			SkinEditBox(TradePlayerInputMoneyFrameCopper)

			for i = 1, 7 do
				local player = _G["TradePlayerItem"..i]
				local recipient = _G["TradeRecipientItem"..i]
				local player_button = _G["TradePlayerItem"..i.."ItemButton"]
				local recipient_button = _G["TradeRecipientItem"..i.."ItemButton"]
				local player_button_icon = _G["TradePlayerItem"..i.."ItemButtonIconTexture"]
				local recipient_button_icon = _G["TradeRecipientItem"..i.."ItemButtonIconTexture"]
				local player_button_count = _G["TradePlayerItem"..i.."ItemButtonCount"]
				local recipient_button_count = _G["TradeRecipientItem"..i.."ItemButtonCount"]

				if player_button and recipient_button then
					player:StripTextures()
					recipient:StripTextures()
					player_button:StripTextures()
					recipient_button:StripTextures()

					player_button_icon:ClearAllPoints()
					player_button_icon:Point("TOPLEFT", player_button, "TOPLEFT", 2, -2)
					player_button_icon:Point("BOTTOMRIGHT", player_button, "BOTTOMRIGHT", -2, 2)
					player_button_icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					player_button_icon:SetDrawLayer("OVERLAY")
					player_button_count:SetDrawLayer("OVERLAY")
					player_button:SetTemplate("Overlay", true)
					player_button:StyleButton()
					player_button.bg = CreateFrame("Frame", nil, player_button)
					player_button.bg:SetTemplate("Overlay")
					player_button.bg:SetPoint("TOPLEFT", player_button, "TOPRIGHT", 4, 0)
					player_button.bg:SetPoint("BOTTOMRIGHT", _G["TradePlayerItem"..i.."NameFrame"], "BOTTOMRIGHT", 0, 14)
					player_button.bg:SetFrameLevel(player_button:GetFrameLevel() - 4)

					recipient_button_icon:ClearAllPoints()
					recipient_button_icon:Point("TOPLEFT", recipient_button, "TOPLEFT", 2, -2)
					recipient_button_icon:Point("BOTTOMRIGHT", recipient_button, "BOTTOMRIGHT", -2, 2)
					recipient_button_icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					recipient_button_icon:SetDrawLayer("OVERLAY")
					recipient_button_count:SetDrawLayer("OVERLAY")
					recipient_button:SetTemplate("Overlay", true)
					recipient_button:StyleButton()
					recipient_button.bg = CreateFrame("Frame", nil, recipient_button)
					recipient_button.bg:SetTemplate("Overlay")
					recipient_button.bg:SetPoint("TOPLEFT", recipient_button, "TOPRIGHT", 4, 0)
					recipient_button.bg:SetPoint("BOTTOMRIGHT", _G["TradeRecipientItem"..i.."NameFrame"], "BOTTOMRIGHT", 0, 14)
					recipient_button.bg:SetFrameLevel(recipient_button:GetFrameLevel() - 4)
				end
			end

			TradeHighlightPlayerTop:SetTexture(0, 1, 0, 0.2)
			TradeHighlightPlayerBottom:SetTexture(0, 1, 0, 0.2)
			TradeHighlightPlayerMiddle:SetTexture(0, 1, 0, 0.2)
			TradeHighlightPlayer:SetFrameStrata("HIGH")
			TradeHighlightPlayer:Point("TOPLEFT", TradeFrame, "TOPLEFT", 23, -100)

			TradeHighlightPlayerEnchantTop:SetTexture(0, 1, 0, 0.2)
			TradeHighlightPlayerEnchantBottom:SetTexture(0, 1, 0, 0.2)
			TradeHighlightPlayerEnchantMiddle:SetTexture(0, 1, 0, 0.2)
			TradeHighlightPlayerEnchant:SetFrameStrata("HIGH")

			TradeHighlightRecipientTop:SetTexture(0, 1, 0, 0.2)
			TradeHighlightRecipientBottom:SetTexture(0, 1, 0, 0.2)
			TradeHighlightRecipientMiddle:SetTexture(0, 1, 0, 0.2)
			TradeHighlightRecipient:SetFrameStrata("HIGH")
			TradeHighlightRecipient:Point("TOPLEFT", TradeFrame, "TOPLEFT", 192, -100)

			TradeHighlightRecipientEnchantTop:SetTexture(0, 1, 0, 0.2)
			TradeHighlightRecipientEnchantBottom:SetTexture(0, 1, 0, 0.2)
			TradeHighlightRecipientEnchantMiddle:SetTexture(0, 1, 0, 0.2)
			TradeHighlightRecipientEnchant:SetFrameStrata("HIGH")
		end

		-- GuildRegistrar Frame
		do
			GuildRegistrarFrame:StripTextures(true)
			GuildRegistrarFrame:CreateBackdrop("Transparent")
			GuildRegistrarFrame.backdrop:Point("TOPLEFT", 16, -12)
			GuildRegistrarFrame.backdrop:Point("BOTTOMRIGHT", -30, 76)
			GuildRegistrarGreetingFrame:StripTextures()

			GuildRegistrarFramePurchaseButton:SkinButton()
			GuildRegistrarFrameCancelButton:SkinButton()
			GuildRegistrarFrameGoodbyeButton:SkinButton()
			GuildRegistrarFramePurchaseButton:ClearAllPoints()
			GuildRegistrarFramePurchaseButton:Point("BOTTOMLEFT", GuildRegistrarFrame.backdrop, "BOTTOMLEFT", 4, 4)
			GuildRegistrarFrameCancelButton:ClearAllPoints()
			GuildRegistrarFrameCancelButton:Point("BOTTOMRIGHT", GuildRegistrarFrame.backdrop, "BOTTOMRIGHT", -4, 4)
			GuildRegistrarFrameGoodbyeButton:ClearAllPoints()
			GuildRegistrarFrameGoodbyeButton:Point("BOTTOMRIGHT", GuildRegistrarFrame.backdrop, "BOTTOMRIGHT", -4, 4)

			SkinCloseButton(GuildRegistrarFrameCloseButton, GuildRegistrarFrame.backdrop)

			SkinEditBox(GuildRegistrarFrameEditBox)
			for i = 1, GuildRegistrarFrameEditBox:GetNumRegions() do
				local region = select(i, GuildRegistrarFrameEditBox:GetRegions())
				if region:GetObjectType() == "Texture" then
					if region:GetTexture() == "Interface\\ChatFrame\\UI-ChatInputBorder-Left" or region:GetTexture() == "Interface\\ChatFrame\\UI-ChatInputBorder-Right" then
						region:Kill()
					end
				end
			end
			GuildRegistrarFrameEditBox:Height(GuildRegistrarFrameEditBox:GetHeight() - 15)

			for i = 1, 2 do
				_G["GuildRegistrarButton"..i]:GetFontString():SetTextColor(1, 1, 1)
			end

			GuildRegistrarPurchaseText:SetTextColor(1, 1, 1)
			AvailableServicesText:SetTextColor(1, 0.8, 0)
			AvailableServicesText:SetShadowColor(0, 0, 0)
		end

		-- Tabard Frame
		do
			TabardFrame:StripTextures(true)
			TabardFrame:CreateBackdrop("Transparent")
			TabardFrame.backdrop:Point("TOPLEFT", 16, -12)
			TabardFrame.backdrop:Point("BOTTOMRIGHT", -30, 76)
			TabardModel:CreateBackdrop("Overlay")
			TabardModel.backdrop:Point("TOPLEFT", 2, 0)
			TabardModel.backdrop:Point("BOTTOMRIGHT", 2, -2)
			SkinCloseButton(TabardFrameCloseButton, TabardFrame.backdrop)
			TabardFrameCancelButton:SkinButton()
			TabardFrameAcceptButton:SkinButton()
			SkinRotateButton(TabardCharacterModelRotateLeftButton)
			SkinRotateButton(TabardCharacterModelRotateRightButton)
			TabardCharacterModelRotateLeftButton:ClearAllPoints()
			TabardCharacterModelRotateLeftButton:Point("BOTTOMLEFT", TabardModel.backdrop, "BOTTOMLEFT", 4, 4)
			TabardCharacterModelRotateRightButton:ClearAllPoints()
			TabardCharacterModelRotateRightButton:Point("LEFT", TabardCharacterModelRotateLeftButton, "RIGHT", 3, 0)
			TabardFrameCostFrame:StripTextures()
			TabardFrameCustomizationFrame:StripTextures()

			for i = 1, 5 do
				local custom = "TabardFrameCustomization"..i
				_G[custom]:StripTextures()
				SkinNextPrevButton(_G[custom.."LeftButton"])
				SkinNextPrevButton(_G[custom.."RightButton"])

				if i > 1 then
					_G[custom]:ClearAllPoints()
					_G[custom]:Point("TOP", _G["TabardFrameCustomization"..i-1], "BOTTOM", 0, -6)
				else
					local point, anchor, point2, x, y = _G[custom]:GetPoint()
					_G[custom]:Point(point, anchor, point2, x, y + 4)
				end
			end
		end

		-- Gossip Frame
		do
			local StripAllTextures = {
				"GossipFrameGreetingPanel",
			}

			for _, object in pairs(StripAllTextures) do
				_G[object]:StripTextures()
			end

			local KillTextures = {
				"GossipFramePortrait",
			}

			for _, texture in pairs(KillTextures) do
				_G[texture]:Kill()
			end

			local buttons = {
				"GossipFrameGreetingGoodbyeButton",
			}

			for i = 1, #buttons do
				_G[buttons[i]]:StripTextures()
				_G[buttons[i]]:SkinButton()
			end

			for i = 1, NUMGOSSIPBUTTONS do
				obj = select(3, _G["GossipTitleButton"..i]:GetRegions())
				obj:SetTextColor(1, 1, 1)
				obj:SetShadowOffset(1, -1)
			end

			GossipGreetingText:SetTextColor(1, 1, 1)
			GossipGreetingText:SetShadowOffset(1, -1)
			GossipFrame:CreateBackdrop("Transparent")
			GossipFrame.backdrop:Point("TOPLEFT", GossipFrame, "TOPLEFT", 16, -12)
			GossipFrame.backdrop:Point("BOTTOMRIGHT", GossipFrame, "BOTTOMRIGHT", -30, 69)
			SkinCloseButton(GossipFrameCloseButton, GossipFrame.backdrop)

			-- Extreme hackage, blizzard makes button text on quest frame use hex color codes for some reason
			hooksecurefunc("GossipFrameUpdate", function()
				for i = 1, NUMGOSSIPBUTTONS do
					local button = _G["GossipTitleButton"..i]

					if button:GetFontString() then
						if button:GetFontString():GetText() and button:GetFontString():GetText():find("|cff000000") then
							button:GetFontString():SetText(string.gsub(button:GetFontString():GetText(), "|cff000000", "|cffFFFF00"))
						end
					end
				end
			end)
		end

		-- Greeting Frame
		do
			QuestFrameGreetingPanel:HookScript("OnShow", function()
				QuestFrameGreetingPanel:StripTextures()
				QuestFrameGreetingGoodbyeButton:SkinButton(true)
				GreetingText:SetTextColor(1, 1, 1)
				CurrentQuestsText:SetTextColor(1, 0.8, 0)
				QuestGreetingFrameHorizontalBreak:Kill()
				AvailableQuestsText:SetTextColor(1, 0.8, 0)

				for i = 1, MAX_NUM_QUESTS do
					local button = _G["QuestTitleButton"..i]
					if button:GetFontString() then
						if button:GetFontString():GetText() and button:GetFontString():GetText():find("|cff000000") then
							button:GetFontString():SetText(string.gsub(button:GetFontString():GetText(), "|cff000000", "|cffFFFF00"))
						end
					end
				end
			end)
		end

		-- Encounter Journal
		if T.PTRVersion() then
		do
			EncounterJournal:StripTextures(true)
			EncounterJournal:CreateBackdrop("Transparent")
			EncounterJournal.backdrop:Point("TOPLEFT", -3, 0)
			EncounterJournal.backdrop:SetPoint("BOTTOMRIGHT", 0, -2)

			EncounterJournalNavBar:StripTextures(true)
			EncounterJournalNavBarOverlay:StripTextures(true)

			EncounterJournalNavBar:CreateBackdrop("Transparent")
			EncounterJournalNavBar.backdrop:Point("TOPLEFT", -2, 0)
			EncounterJournalNavBar.backdrop:SetPoint("BOTTOMRIGHT")
			EncounterJournalNavBarHomeButton:SkinButton(true)

			SkinEditBox(EncounterJournalSearchBox)
			SkinCloseButton(EncounterJournalCloseButton)

			EncounterJournalInset:StripTextures(true)
			EncounterJournal:HookScript("OnShow", function()
				if not EncounterJournalInstanceSelect.backdrop then
					EncounterJournalInstanceSelect:CreateBackdrop("Default")
					EncounterJournalInstanceSelect.backdrop:Point("TOPLEFT", -2, 2)
					EncounterJournalInstanceSelect.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
				end

				if not EncounterJournalEncounterFrameInfo.backdrop then
					EncounterJournalEncounterFrameInfo:CreateBackdrop("Default")
					EncounterJournalEncounterFrameInfo.backdrop:Point("TOPLEFT", -2, 2)
					EncounterJournalEncounterFrameInfo.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
				end

				EncounterJournalEncounterFrameInfoBossTab:ClearAllPoints()
				EncounterJournalEncounterFrameInfoBossTab:Point("LEFT", EncounterJournalEncounterFrameInfoEncounterTile, "RIGHT", -10, 4)
				EncounterJournalEncounterFrameInfoLootTab:ClearAllPoints()
				EncounterJournalEncounterFrameInfoLootTab:Point("LEFT", EncounterJournalEncounterFrameInfoBossTab, "RIGHT", -24, 0)

				EncounterJournalEncounterFrameInfoBossTab:SetFrameStrata("HIGH")
				EncounterJournalEncounterFrameInfoLootTab:SetFrameStrata("HIGH")

				EncounterJournalEncounterFrameInfoBossTab:SetScale(0.75)
				EncounterJournalEncounterFrameInfoLootTab:SetScale(0.75)
			end)

			SkinScrollBar(EncounterJournalInstanceSelectScrollFrameScrollBar)

			EncounterJournalEncounterFrameInfoBossTab:GetNormalTexture():SetTexture(nil)
			EncounterJournalEncounterFrameInfoBossTab:GetPushedTexture():SetTexture(nil)
			EncounterJournalEncounterFrameInfoBossTab:GetDisabledTexture():SetTexture(nil)
			EncounterJournalEncounterFrameInfoBossTab:GetHighlightTexture():SetTexture(nil)

			EncounterJournalEncounterFrameInfoLootTab:GetNormalTexture():SetTexture(nil)
			EncounterJournalEncounterFrameInfoLootTab:GetPushedTexture():SetTexture(nil)
			EncounterJournalEncounterFrameInfoLootTab:GetDisabledTexture():SetTexture(nil)
			EncounterJournalEncounterFrameInfoLootTab:GetHighlightTexture():SetTexture(nil)
		end
		end

		-- WorldMap
		if C.map.enable ~= true and not IsAddOnLoaded("Mapster") then
			WorldMapFrame:CreateBackdrop("Transparent")
			WorldMapDetailFrame.backdrop = CreateFrame("Frame", nil, WorldMapFrame)
			WorldMapDetailFrame.backdrop:SetTemplate("Default")
			WorldMapDetailFrame.backdrop:Point("TOPLEFT", WorldMapDetailFrame, "TOPLEFT", -2, 2)
			WorldMapDetailFrame.backdrop:Point("BOTTOMRIGHT", WorldMapDetailFrame, "BOTTOMRIGHT", 2, -2)
			WorldMapDetailFrame.backdrop:SetFrameLevel(WorldMapDetailFrame:GetFrameLevel() - 2)

			SkinCloseButton(WorldMapFrameCloseButton)
			SkinCloseButton(WorldMapFrameSizeDownButton)
			SkinCloseButton(WorldMapFrameSizeUpButton)

			SkinDropDownBox(WorldMapLevelDropDown)
			SkinDropDownBox(WorldMapZoneMinimapDropDown)
			SkinDropDownBox(WorldMapContinentDropDown)
			SkinDropDownBox(WorldMapZoneDropDown)
			WorldMapZoomOutButton:SkinButton()
			WorldMapZoomOutButton:Point("LEFT", WorldMapZoneDropDown, "RIGHT", 0, 4)
			WorldMapLevelUpButton:Point("TOPLEFT", WorldMapLevelDropDown, "TOPRIGHT", -2, 8)
			WorldMapLevelDownButton:Point("BOTTOMLEFT", WorldMapLevelDropDown, "BOTTOMRIGHT", -2, 2)

			SkinCheckBox(WorldMapTrackQuest)
			SkinCheckBox(WorldMapQuestShowObjectives)
			SkinCheckBox(WorldMapShowDigSites)

			-- Minimap
			local function SmallSkin()
				WorldMapLevelDropDown:ClearAllPoints()
				WorldMapLevelDropDown:Point("TOPLEFT", WorldMapDetailFrame, "TOPLEFT", -10, -4)

				WorldMapFrame.backdrop:ClearAllPoints()
				WorldMapFrame.backdrop:Point("TOPLEFT", 2, 3)
				WorldMapFrame.backdrop:Point("BOTTOMRIGHT", 2, 0)

				WorldMapFrameCloseButton:Point("TOPRIGHT", WorldMapFrame.backdrop, "TOPRIGHT", -4, -4)
				WorldMapFrameSizeUpButton:ClearAllPoints()
				WorldMapFrameSizeUpButton:Point("TOPRIGHT", WorldMapFrameCloseButton, "TOPLEFT", -4, 0)
				WorldMapFrameSizeUpButton:Point("BOTTOMRIGHT", WorldMapFrameCloseButton, "BOTTOMLEFT", -4, 0)
			end

			-- Largemap
			local function LargeSkin()
				if not InCombatLockdown() then
					WorldMapFrame:SetParent(UIParent)
					WorldMapFrame:EnableMouse(false)
					WorldMapFrame:EnableKeyboard(false)
					SetUIPanelAttribute(WorldMapFrame, "area", "center")
					SetUIPanelAttribute(WorldMapFrame, "allowOtherPanels", true)
				end

				WorldMapFrame.backdrop:ClearAllPoints()
				WorldMapFrame.backdrop:Point("TOPLEFT", WorldMapDetailFrame, "TOPLEFT", -25, 70)
				WorldMapFrame.backdrop:Point("BOTTOMRIGHT", WorldMapDetailFrame, "BOTTOMRIGHT", 25, -27)

				WorldMapFrameCloseButton:Point("TOPRIGHT", WorldMapFrame.backdrop, "TOPRIGHT", -4, -4)
				WorldMapFrameSizeDownButton:ClearAllPoints()
				WorldMapFrameSizeDownButton:Point("TOPRIGHT", WorldMapFrameCloseButton, "TOPLEFT", -4, 0)
				WorldMapFrameSizeDownButton:Point("BOTTOMRIGHT", WorldMapFrameCloseButton, "BOTTOMLEFT", -4, 0)
			end

			local function QuestSkin()
				if not InCombatLockdown() then
					WorldMapFrame:SetParent(UIParent)
					WorldMapFrame:EnableMouse(false)
					WorldMapFrame:EnableKeyboard(false)
					SetUIPanelAttribute(WorldMapFrame, "area", "center")
					SetUIPanelAttribute(WorldMapFrame, "allowOtherPanels", true)
				end

				WorldMapFrame.backdrop:ClearAllPoints()
				WorldMapFrame.backdrop:Point("TOPLEFT", WorldMapDetailFrame, "TOPLEFT", -25, 69)
				WorldMapFrame.backdrop:Point("BOTTOMRIGHT", WorldMapDetailFrame, "BOTTOMRIGHT", 334, -234)

				if not WorldMapQuestDetailScrollFrame.backdrop then
					WorldMapQuestDetailScrollFrame:CreateBackdrop("Overlay")
					WorldMapQuestDetailScrollFrame.backdrop:Point("TOPLEFT", -22, 2)
					WorldMapQuestDetailScrollFrame.backdrop:Point("BOTTOMRIGHT", 23, -4)
				end

				if not WorldMapQuestRewardScrollFrame.backdrop then
					WorldMapQuestRewardScrollFrame:CreateBackdrop("Overlay")
					WorldMapQuestRewardScrollFrame.backdrop:Point("BOTTOMRIGHT", 22, -4)
				end

				if not WorldMapQuestScrollFrame.backdrop then
					WorldMapQuestScrollFrame:CreateBackdrop("Overlay")
					WorldMapQuestScrollFrame.backdrop:Point("TOPLEFT", 0, 2)
					WorldMapQuestScrollFrame.backdrop:Point("BOTTOMRIGHT", 24, -3)
				end

				WorldMapFrameCloseButton:Point("TOPRIGHT", WorldMapFrame.backdrop, "TOPRIGHT", -4, -4)
				WorldMapFrameSizeDownButton:ClearAllPoints()
				WorldMapFrameSizeDownButton:Point("TOPRIGHT", WorldMapFrameCloseButton, "TOPLEFT", -4, 0)
				WorldMapFrameSizeDownButton:Point("BOTTOMRIGHT", WorldMapFrameCloseButton, "BOTTOMLEFT", -4, 0)
			end

			local function FixSkin()
				WorldMapFrame:StripTextures()
				if WORLDMAP_SETTINGS.size == WORLDMAP_FULLMAP_SIZE then
					LargeSkin()
				elseif WORLDMAP_SETTINGS.size == WORLDMAP_WINDOWED_SIZE then
					SmallSkin()
				elseif WORLDMAP_SETTINGS.size == WORLDMAP_QUESTLIST_SIZE then
					QuestSkin()
				end

				if not InCombatLockdown() then
					WorldMapFrame:SetScale(1)
					WorldMapFrameSizeDownButton:Show()
					WorldMapFrame:SetFrameLevel(10)
				else
					WorldMapFrameSizeDownButton:Disable()
					WorldMapFrameSizeUpButton:Disable()
				end

				WorldMapFrameAreaLabel:SetFont(C.media.normal_font, 50)
				WorldMapFrameAreaLabel:SetShadowOffset(2, -2)
				WorldMapFrameAreaLabel:SetTextColor(0.90, 0.8294, 0.6407)

				WorldMapFrameAreaDescription:SetFont(C.media.normal_font, 40)
				WorldMapFrameAreaDescription:SetShadowOffset(1, -1)

				WorldMapZoneInfo:SetFont(C.media.normal_font, 27)
				WorldMapZoneInfo:SetShadowOffset(1, -1)
			end

			WorldMapFrame:HookScript("OnShow", FixSkin)
			hooksecurefunc("WorldMapFrame_SetFullMapView", LargeSkin)
			hooksecurefunc("WorldMapFrame_SetQuestMapView", QuestSkin)
			hooksecurefunc("WorldMap_ToggleSizeUp", FixSkin)

			WorldMapFrame:RegisterEvent("PLAYER_LOGIN")
			WorldMapFrame:HookScript("OnEvent", function(self, event)
				if event == "PLAYER_LOGIN" then
					if not GetCVarBool("miniWorldMap") then
						ToggleFrame(WorldMapFrame)
						ToggleFrame(WorldMapFrame)
					end
				end
			end)

			local coords = CreateFrame("Frame", "CoordsFrame", WorldMapFrame)
			local fontheight = select(2, WorldMapQuestShowObjectivesText:GetFont()) * 1.1
			coords:SetFrameLevel(90)
			coords:FontString("PlayerText", C.media.normal_font, fontheight)
			coords:FontString("MouseText", C.media.normal_font, fontheight)
			coords.PlayerText:SetTextColor(WorldMapQuestShowObjectivesText:GetTextColor())
			coords.MouseText:SetTextColor(WorldMapQuestShowObjectivesText:GetTextColor())
			coords.PlayerText:SetShadowOffset(1, -1)
			coords.MouseText:SetShadowOffset(1, -1)
			coords.PlayerText:SetPoint("BOTTOMLEFT", WorldMapDetailFrame, "BOTTOMLEFT", 5, 5)
			coords.PlayerText:SetText(UnitName("player")..": 0,0")
			coords.MouseText:SetPoint("BOTTOMLEFT", coords.PlayerText, "TOPLEFT", 0, 5)
			coords.MouseText:SetText(L_MAP_CURSOR.."0,0")
			local int = 0

			WorldMapFrame:HookScript("OnUpdate", function(self, elapsed)
				if InCombatLockdown() then
					WorldMapFrameSizeDownButton:Disable()
					WorldMapFrameSizeUpButton:Disable()
				else
					WorldMapFrameSizeDownButton:Enable()
					WorldMapFrameSizeUpButton:Enable()
				end

				if WORLDMAP_SETTINGS.size == WORLDMAP_FULLMAP_SIZE then
					WorldMapFrameSizeUpButton:Hide()
					WorldMapFrameSizeDownButton:Show()
				elseif WORLDMAP_SETTINGS.size == WORLDMAP_WINDOWED_SIZE then
					WorldMapFrameSizeUpButton:Show()
					WorldMapFrameSizeDownButton:Hide()
				elseif WORLDMAP_SETTINGS.size == WORLDMAP_QUESTLIST_SIZE then
					WorldMapFrameSizeUpButton:Hide()
					WorldMapFrameSizeDownButton:Show()
				end

				int = int + 1

				if int >= 3 then
					local inInstance, _ = IsInInstance()
					local x,y = GetPlayerMapPosition("player")
					x = math.floor(100 * x)
					y = math.floor(100 * y)
					if x ~= 0 and y ~= 0 then
						coords.PlayerText:SetText(UnitName("player")..": "..x..","..y)
					else
						coords.PlayerText:SetText(UnitName("player")..": ".."|cffff0000"..L_MAP_BOUNDS.."|r")
					end

					local scale = WorldMapDetailFrame:GetEffectiveScale()
					local width = WorldMapDetailFrame:GetWidth()
					local height = WorldMapDetailFrame:GetHeight()
					local centerX, centerY = WorldMapDetailFrame:GetCenter()
					local x, y = GetCursorPosition()
					local adjustedX = (x / scale - (centerX - (width/2))) / width
					local adjustedY = (centerY + (height/2) - y / scale) / height

					if (adjustedX >= 0  and adjustedY >= 0 and adjustedX <= 1 and adjustedY <= 1) then
						adjustedX = math.floor(100 * adjustedX)
						adjustedY = math.floor(100 * adjustedY)
						coords.MouseText:SetText(L_MAP_CURSOR..adjustedX..","..adjustedY)
					else
						coords.MouseText:SetText(L_MAP_CURSOR.."|cffff0000"..L_MAP_BOUNDS.."|r")
					end

					int = 0
				end
			end)
			WorldMapContinentDropDownButton:HookScript("OnClick", function() DropDownList1:SetScale(C.general.uiscale) end)
			WorldMapZoneDropDownButton:HookScript("OnClick", function() DropDownList1:SetScale(C.general.uiscale) end)
		end

		-- Item Text Frame
		do
			ItemTextFrame:StripTextures(true)
			ItemTextScrollFrame:StripTextures()
			ItemTextFrame:CreateBackdrop("Transparent")
			ItemTextFrame.backdrop:Point("TOPLEFT", 16, -12)
			ItemTextFrame.backdrop:Point("BOTTOMRIGHT", -30, 76)
			SkinCloseButton(ItemTextCloseButton, ItemTextFrame.backdrop)
			SkinNextPrevButton(ItemTextPrevPageButton)
			SkinNextPrevButton(ItemTextNextPageButton)
			ItemTextPageText:SetTextColor(1, 1, 1)
			ItemTextPageText.SetTextColor = T.dummy
		end

		-- Taxi Frame
		do
			TaxiFrame:StripTextures()
			TaxiFrame:CreateBackdrop("Transparent")
			TaxiFrame.backdrop:Point("TOPLEFT", -5, 3)
			TaxiFrame.backdrop:Point("BOTTOMRIGHT", 5, -7)
			TaxiRouteMap:CreateBackdrop("Default")
			TaxiRouteMap.backdrop:Point("TOPLEFT", -2, 2)
			TaxiRouteMap.backdrop:Point("BOTTOMRIGHT", 2, -2)
			SkinCloseButton(TaxiFrameCloseButton)
			TaxiFrameCloseButton:Point("TOPRIGHT", -4, -1)
		end

		-- LFR frame
		do
			local buttons = {
				"LFRQueueFrameFindGroupButton",
				"LFRQueueFrameAcceptCommentButton",
				"LFRBrowseFrameSendMessageButton",
				"LFRBrowseFrameInviteButton",
				"LFRBrowseFrameRefreshButton",
				"LFRQueueFrameNoLFRWhileLFDLeaveQueueButton",
			}

			LFRParentFrame:StripTextures()
			LFRParentFrame:CreateBackdrop("Transparent")
			LFRParentFrame.backdrop:Point("TOPLEFT", 16, -12)
			LFRParentFrame.backdrop:Point("BOTTOMRIGHT", -1, 0)
			LFRQueueFrameNoLFRWhileLFD:StripTextures()
			LFRQueueFrameNoLFRWhileLFD:CreateBackdrop("Overlay")
			LFRQueueFrameNoLFRWhileLFD.backdrop:Point("TOPLEFT", 4, 0)
			LFRQueueFrameNoLFRWhileLFD.backdrop:Point("BOTTOMRIGHT", -3, -1)
			LFRQueueFrame:StripTextures()
			LFRBrowseFrame:StripTextures()

			for i = 1, #buttons do
				_G[buttons[i]]:SkinButton()
			end

			LFRQueueFrameFindGroupButton:Point("BOTTOMLEFT", LFRParentFrame.backdrop, "BOTTOMLEFT", 9, 7)
			LFRQueueFrameAcceptCommentButton:Point("BOTTOMRIGHT", LFRParentFrame.backdrop, "BOTTOMRIGHT", -9, 7)

			-- Close button
			for i = 1, LFRParentFrame:GetNumChildren() do
				local child = select(i, LFRParentFrame:GetChildren())
				if child.GetPushedTexture and child:GetPushedTexture() and not child:GetName() then
					SkinCloseButton(child, LFRParentFrame.backdrop)
				end
			end

			SkinTab(LFRParentFrameTab1)
			SkinTab(LFRParentFrameTab2)

			-- Reposition tabs
			LFRParentFrameTab1:ClearAllPoints()
			LFRParentFrameTab1:SetPoint("TOPLEFT", LFRParentFrame.backdrop, "BOTTOMLEFT", 0, 2)

			SkinDropDownBox(LFRBrowseFrameRaidDropDown)
			LFRQueueFrameSpecificListScrollFrame:StripTextures()

			LFRQueueFrameCommentTextButton:CreateBackdrop("Overlay")
			LFRQueueFrameCommentTextButton.backdrop:Point("TOPLEFT", -6, 2)
			LFRQueueFrameCommentTextButton.backdrop:Point("BOTTOMRIGHT", 1, 0)

			for i = 1, 7 do
				local button = "LFRBrowseFrameColumnHeader"..i
				_G[button.."Left"]:Kill()
				_G[button.."Middle"]:Kill()
				_G[button.."Right"]:Kill()
			end

			for i = 1, NUM_LFR_CHOICE_BUTTONS do
				local button = _G["LFRQueueFrameSpecificListButton"..i]
				SkinCheckBox(button.enableButton)
			end

			SkinCheckBox(LFRQueueFrameRoleButtonTank:GetChildren())
			SkinCheckBox(LFRQueueFrameRoleButtonHealer:GetChildren())
			SkinCheckBox(LFRQueueFrameRoleButtonDPS:GetChildren())
			LFRQueueFrameRoleButtonTank:GetChildren():SetFrameLevel(LFRQueueFrameRoleButtonTank:GetChildren():GetFrameLevel() + 2)
			LFRQueueFrameRoleButtonHealer:GetChildren():SetFrameLevel(LFRQueueFrameRoleButtonHealer:GetChildren():GetFrameLevel() + 2)
			LFRQueueFrameRoleButtonDPS:GetChildren():SetFrameLevel(LFRQueueFrameRoleButtonDPS:GetChildren():GetFrameLevel() + 2)
		end

		-- LFD frame
		do
			local StripAllTextures = {
				"LFDParentFrame",
				"LFDQueueFrame",
				"LFDQueueFrameSpecific",
				"LFDQueueFrameRandom",
				"LFDQueueFrameRandomScrollFrame",
				"LFDQueueFrameCapBar",
				"LFDDungeonReadyDialog",
				"LFDQueueFrameRandomScrollFrameScrollBar",
				"LFDQueueFrameNoLFDWhileLFR",
				"LFDQueueFrameSpecificListScrollFrame",
			}

			local KillTextures = {
				"LFDQueueFrameBackground",
				"LFDParentFrameInset",
				"LFDParentFrameEyeFrame",
				"LFDQueueFrameRoleButtonTankBackground",
				"LFDQueueFrameRoleButtonHealerBackground",
				"LFDQueueFrameRoleButtonDPSBackground",
				"LFDDungeonReadyDialogBackground",
			}

			local buttons = {
				"LFDQueueFrameFindGroupButton",
				"LFDQueueFrameCancelButton",
				"LFDQueueFramePartyBackfillBackfillButton",
				"LFDQueueFramePartyBackfillNoBackfillButton",
				"LFDQueueFrameNoLFDWhileLFRLeaveQueueButton",
			}

			local checkButtons = {
				"LFDQueueFrameRoleButtonTank",
				"LFDQueueFrameRoleButtonHealer",
				"LFDQueueFrameRoleButtonDPS",
				"LFDQueueFrameRoleButtonLeader",
			}

			for _, object in pairs(checkButtons) do
				_G[object].checkButton:SetFrameLevel(_G[object].checkButton:GetFrameLevel() + 2)
				SkinCheckBox(_G[object].checkButton)
			end

			hooksecurefunc("LFDQueueFrameRandom_UpdateFrame", function()
				local dungeonID = LFDQueueFrame.type
				if type(dungeonID) == "string" then return end
				local _, _, _, _, _, numRewards = GetLFGDungeonRewards(dungeonID)

				for i = 1, LFD_MAX_REWARDS do
					local button = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i]
					local icon = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."IconTexture"]
					local count = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."Count"]
					local role1 = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."RoleIcon1"]
					local role2 = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."RoleIcon2"]
					local role3 = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."RoleIcon3"]

					if button then
						local __texture = _G[button:GetName().."IconTexture"]:GetTexture()
						button:StripTextures()
						icon:SetTexture(__texture)
						icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
						icon:Point("TOPLEFT", 2, -2)
						icon:SetDrawLayer("OVERLAY")
						count:SetDrawLayer("OVERLAY")
						if not button.backdrop then
							button:CreateBackdrop("Default")
							button.backdrop:Point("TOPLEFT", icon, "TOPLEFT", -2, 2)
							button.backdrop:Point("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)
							icon:SetParent(button.backdrop)
							icon.SetPoint = T.dummy

							if count then
								count:SetParent(button.backdrop)
							end
							if role1 then
								role1:SetParent(button.backdrop)
							end
							if role2 then
								role2:SetParent(button.backdrop)
							end
							if role3 then
								role3:SetParent(button.backdrop)
							end
						end
					end
				end
			end)

			hooksecurefunc("LFDQueueFrameSpecificListButton_SetDungeon", function(button, dungeonID, mode, submode)
				for _, object in pairs(checkButtons) do
					local button = _G[object]
					if not button.checkButton:GetChecked() then
						button.checkButton:SetDisabledTexture(nil)
					else
						button.checkButton:SetDisabledTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
					end
				end
			end)

			for _, object in pairs(StripAllTextures) do
				_G[object]:StripTextures()
			end

			for _, texture in pairs(KillTextures) do
				_G[texture]:Kill()
			end

			for i = 1, #buttons do
				_G[buttons[i]]:StripTextures()
				_G[buttons[i]]:SkinButton()
			end

			for i = 1, NUM_LFD_CHOICE_BUTTONS do
				SkinCheckBox(_G["LFDQueueFrameSpecificListButton"..i.."EnableButton"])
			end

			LFDQueueFrameCapBar:SetPoint("LEFT", 40, 0)

			LFDQueueFrameNoLFDWhileLFR:CreateBackdrop("Overlay")
			LFDQueueFrameNoLFDWhileLFR.backdrop:Point("TOPLEFT", 2, 5)
			LFDQueueFrameNoLFDWhileLFR.backdrop:Point("BOTTOMRIGHT", 0, 6)
			LFDQueueFrameSpecific:Point("TOPLEFT", -5, 0)
			LFDQueueFrameSpecific:Point("BOTTOMRIGHT", 0, 10)
			LFDParentFrame:CreateBackdrop("Transparent")
			LFDParentFrame.backdrop:Point("TOPLEFT", LFDParentFrame, "TOPLEFT")
			LFDParentFrame.backdrop:Point("BOTTOMRIGHT", LFDParentFrame, "BOTTOMRIGHT", 0, 4)
			SkinCloseButton(LFDParentFrameCloseButton, LFDParentFrame)
			SkinCloseButton(LFDDungeonReadyDialogCloseButton, LFDDungeonReadyDialog)
			SkinDropDownBox(LFDQueueFrameTypeDropDown, 300)
			LFDQueueFrameTypeDropDown:Point("RIGHT", -10, 0)
			LFDQueueFrameCapBar:CreateBackdrop("Transparent")
			LFDQueueFrameCapBar.backdrop:Point("TOPLEFT", LFDQueueFrameCapBar, "TOPLEFT", 1, -1)
			LFDQueueFrameCapBar.backdrop:Point("BOTTOMRIGHT", LFDQueueFrameCapBar, "BOTTOMRIGHT", -1, 1)
			LFDQueueFrameCapBarProgress:SetTexture(C.media.texture)
			LFDQueueFrameCapBarCap1:SetTexture(C.media.texture)
			LFDQueueFrameCapBarCap2:SetTexture(C.media.texture)
			SkinScrollBar(LFDQueueFrameSpecificListScrollFrameScrollBar)
			RolePollPopup:SetTemplate("Transparent")
			LFDDungeonReadyDialog:SetTemplate("Transparent")
			LFDQueueFrameFindGroupButton:Point("BOTTOMLEFT", LFDParentFrame.backdrop, "BOTTOMLEFT", 4, 4)
			LFDQueueFrameCancelButton:Point("BOTTOMRIGHT", LFDParentFrame.backdrop, "BOTTOMRIGHT", -6, 4)
			LFDQueueFrameRandomScrollFrame:Height(LFDQueueFrameRandomScrollFrame:GetHeight() + 10)
		end

		-- Quest Frame
		do
			QuestFrame:StripTextures(true)
			QuestFrameDetailPanel:StripTextures(true)
			QuestDetailScrollFrame:StripTextures(true)
			QuestDetailScrollChildFrame:StripTextures(true)
			QuestRewardScrollFrame:StripTextures(true)
			QuestRewardScrollChildFrame:StripTextures(true)
			QuestFrameProgressPanel:StripTextures(true)
			QuestFrameRewardPanel:StripTextures(true)
			QuestFrame:CreateBackdrop("Transparent")
			QuestFrame.backdrop:Point("TOPLEFT", 16, -12)
			QuestFrame.backdrop:Point("BOTTOMRIGHT", -30, 65)
			QuestFrameAcceptButton:SkinButton(true)
			QuestFrameDeclineButton:SkinButton(true)
			QuestFrameCompleteButton:SkinButton(true)
			QuestFrameGoodbyeButton:SkinButton(true)
			QuestFrameCompleteQuestButton:SkinButton(true)
			SkinCloseButton(QuestFrameCloseButton, QuestFrame.backdrop)

			for i = 1, 6 do
				local button = _G["QuestProgressItem"..i]
				local texture = _G["QuestProgressItem"..i.."IconTexture"]
				button:StripTextures()
				button:StyleButton()
				button:Width(_G["QuestProgressItem"..i]:GetWidth() - 4)
				button:SetFrameLevel(button:GetFrameLevel() + 2)
				texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				texture:SetDrawLayer("OVERLAY")
				texture:Point("TOPLEFT", 2, -2)
				texture:Size(texture:GetWidth() - 2, texture:GetHeight() - 2)
				_G["QuestProgressItem"..i.."Count"]:SetDrawLayer("OVERLAY")
				button:SetTemplate("Default")
			end

			hooksecurefunc("QuestFrameProgressItems_Update", function()
				QuestProgressTitleText:SetTextColor(1, 0.8, 0)
				QuestProgressTitleText:SetShadowColor(0, 0, 0)
				QuestProgressText:SetTextColor(1, 1, 1)
				QuestProgressRequiredItemsText:SetTextColor(1, 0.8, 0)
				QuestProgressRequiredItemsText:SetShadowColor(0, 0, 0)
				QuestProgressRequiredMoneyText:SetTextColor(1, 0.8, 0)
			end)

			QuestNPCModel:StripTextures()
			QuestNPCModel:CreateBackdrop("Transparent")
			QuestNPCModelTextFrame:StripTextures()
			QuestNPCModelTextFrame:CreateBackdrop("Overlay")
			QuestNPCModelTextFrame.backdrop:Point("TOPLEFT", QuestNPCModel.backdrop, "BOTTOMLEFT", 0, -1)

			QuestLogDetailFrame:StripTextures()
			QuestLogDetailFrame:CreateBackdrop("Transparent")
			QuestLogDetailFrame.backdrop:Point("TOPLEFT", 16, -12)
			QuestLogDetailFrame.backdrop:Point("BOTTOMRIGHT", 0, 4)
			QuestLogDetailScrollFrame:StripTextures()
			SkinCloseButton(QuestLogDetailFrameCloseButton, QuestLogDetailFrame.backdrop)

			hooksecurefunc("QuestFrame_ShowQuestPortrait", function(parentFrame, portrait, text, name, x, y)
				QuestNPCModel:ClearAllPoints()
				QuestNPCModel:SetPoint("TOPLEFT", parentFrame, "TOPRIGHT", x + 10, y + 48)
			end)
		end

		-- Petition Frame
		do
			PetitionFrame:StripTextures(true)
			PetitionFrame:CreateBackdrop("Transparent")
			PetitionFrame.backdrop:Point("TOPLEFT", 16, -12)
			PetitionFrame.backdrop:Point("BOTTOMRIGHT", -30, -3)

			PetitionFrameSignButton:SkinButton()
			PetitionFrameRequestButton:SkinButton()
			PetitionFrameRenameButton:SkinButton()
			PetitionFrameCancelButton:SkinButton()
			SkinCloseButton(PetitionFrameCloseButton, PetitionFrame.backdrop)

			PetitionFrameCharterTitle:SetTextColor(1, 0.8, 0)
			PetitionFrameCharterTitle:SetShadowColor(0, 0, 0)
			PetitionFrameCharterName:SetTextColor(1, 1, 1)
			PetitionFrameMasterTitle:SetTextColor(1, 0.8, 0)
			PetitionFrameMasterTitle:SetShadowColor(0, 0, 0)
			PetitionFrameMasterName:SetTextColor(1, 1, 1)
			PetitionFrameMemberTitle:SetTextColor(1, 0.8, 0)
			PetitionFrameMemberTitle:SetShadowColor(0, 0, 0)

			for i = 1, 9 do
				_G["PetitionFrameMemberName"..i]:SetTextColor(1, 1, 1)
			end

			PetitionFrameInstructions:SetTextColor(1, 1, 1)

			PetitionFrameRenameButton:Point("LEFT", PetitionFrameRequestButton, "RIGHT", 3, 0)
			PetitionFrameRenameButton:Point("RIGHT", PetitionFrameCancelButton, "LEFT", -3, 0)
			PetitionFrame:Height(PetitionFrame:GetHeight() - 80)

			PetitionFrameCancelButton:Point("BOTTOMRIGHT", PetitionFrame, "BOTTOMRIGHT", -40, 3)
			PetitionFrameRequestButton:Point("BOTTOMLEFT", PetitionFrame, "BOTTOMLEFT", 25, 3)
		end

		-- Quest Log
		do
			QuestLogFrame:StripTextures()
			QuestLogFrame:CreateBackdrop("Transparent")
			QuestLogFrame.backdrop:Point("TOPLEFT", 16, -12)
			QuestLogFrame.backdrop:Point("BOTTOMRIGHT", 0, 11)
			SkinCloseButton(QuestLogFrameCloseButton, QuestLogFrame.backdrop)

			QuestLogCount:StripTextures()

			EmptyQuestLogFrame:StripTextures()

			QuestLogFrameShowMapButton:StripTextures()
			QuestLogFrameShowMapButton:SkinButton()
			QuestLogFrameShowMapButton.text:ClearAllPoints()
			QuestLogFrameShowMapButton.text:SetPoint("CENTER")
			QuestLogFrameShowMapButton:Size(QuestLogFrameShowMapButton:GetWidth() - 30, QuestLogFrameShowMapButton:GetHeight(), - 40)

			local buttons = {
				"QuestLogFrameAbandonButton",
				"QuestLogFramePushQuestButton",
				"QuestLogFrameTrackButton",
				"QuestLogFrameCancelButton",
				"QuestLogFrameCompleteButton",
			}

			QuestLogFrameCompleteButton:StripTextures()
			for _, button in pairs(buttons) do
				_G[button]:SkinButton()
			end
			QuestLogFramePushQuestButton:Point("LEFT", QuestLogFrameAbandonButton, "RIGHT", 3, 0)
			QuestLogFramePushQuestButton:Point("RIGHT", QuestLogFrameTrackButton, "LEFT", -3, 0)
			QuestLogFrameCancelButton:Point("BOTTOMRIGHT", QuestLogFrame.backdrop, "BOTTOMRIGHT", -4, 4)

			for i = 1, MAX_NUM_ITEMS do
				_G["QuestInfoItem"..i]:StripTextures()
				_G["QuestInfoItem"..i]:StyleButton()
				_G["QuestInfoItem"..i]:Width(_G["QuestInfoItem"..i]:GetWidth() - 4)
				_G["QuestInfoItem"..i]:SetFrameLevel(_G["QuestInfoItem"..i]:GetFrameLevel() + 2)
				_G["QuestInfoItem"..i.."IconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				_G["QuestInfoItem"..i.."IconTexture"]:SetDrawLayer("OVERLAY")
				_G["QuestInfoItem"..i.."IconTexture"]:Point("TOPLEFT", 2, -2)
				_G["QuestInfoItem"..i.."IconTexture"]:Size(_G["QuestInfoItem"..i.."IconTexture"]:GetWidth() - 2, _G["QuestInfoItem"..i.."IconTexture"]:GetHeight() - 2)
				_G["QuestInfoItem"..i]:SetTemplate("Default")
				_G["QuestInfoItem"..i.."Count"]:SetDrawLayer("OVERLAY")
			end

			QuestInfoSkillPointFrame:StripTextures()
			QuestInfoSkillPointFrame:StyleButton()
			QuestInfoSkillPointFrame:Width(QuestInfoSkillPointFrame:GetWidth() - 4)
			QuestInfoSkillPointFrame:SetFrameLevel(QuestInfoSkillPointFrame:GetFrameLevel() + 2)
			QuestInfoSkillPointFrameIconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			QuestInfoSkillPointFrameIconTexture:SetDrawLayer("OVERLAY")
			QuestInfoSkillPointFrameIconTexture:Point("TOPLEFT", 2, -2)
			QuestInfoSkillPointFrameIconTexture:Size(QuestInfoSkillPointFrameIconTexture:GetWidth() - 2, QuestInfoSkillPointFrameIconTexture:GetHeight() - 2)
			QuestInfoSkillPointFrame:SetTemplate("Default")
			QuestInfoSkillPointFrameCount:SetDrawLayer("OVERLAY")
			QuestInfoSkillPointFramePoints:ClearAllPoints()
			QuestInfoSkillPointFramePoints:Point("BOTTOMRIGHT", QuestInfoSkillPointFrameIconTexture, "BOTTOMRIGHT")

			QuestInfoItemHighlight:StripTextures()
			QuestInfoItemHighlight:SetTemplate("Default")
			QuestInfoItemHighlight:SetBackdropBorderColor(1, 0.8, 0)
			QuestInfoItemHighlight:SetBackdropColor(0, 0, 0, 0)
			QuestInfoItemHighlight:Size(142, 40)

			hooksecurefunc("QuestInfoItem_OnClick", function(self)
				QuestInfoItemHighlight:ClearAllPoints()
				QuestInfoItemHighlight:SetAllPoints(self)
			end)

			-- Everything here to make the text a readable color
			local function QuestObjectiveText()
				local numObjectives = GetNumQuestLeaderBoards()
				local objective
				local type, finished
				local numVisibleObjectives = 0
				for i = 1, numObjectives do
					_, type, finished = GetQuestLogLeaderBoard(i)
					if type ~= "spell" then
						numVisibleObjectives = numVisibleObjectives+1
						objective = _G["QuestInfoObjective"..numVisibleObjectives]
						if finished then
							objective:SetTextColor(1, 0.8, 0)
						else
							objective:SetTextColor(0.6, 0.6, 0.6)
						end
					end
				end
			end

			hooksecurefunc("QuestInfo_Display", function(template, parentFrame, acceptButton, material)
				local textColor = {1, 1, 1}
				local titleTextColor = {1, 0.8, 0}
				local titleTextShadow = {0, 0, 0}

				-- Headers
				QuestInfoTitleHeader:SetTextColor(unpack(titleTextColor))
				QuestInfoTitleHeader:SetShadowColor(unpack(titleTextShadow))
				QuestInfoDescriptionHeader:SetTextColor(unpack(titleTextColor))
				QuestInfoDescriptionHeader:SetShadowColor(unpack(titleTextShadow))
				QuestInfoObjectivesHeader:SetTextColor(unpack(titleTextColor))
				QuestInfoObjectivesHeader:SetShadowColor(unpack(titleTextShadow))
				QuestInfoRewardsHeader:SetTextColor(unpack(titleTextColor))
				QuestInfoRewardsHeader:SetShadowColor(unpack(titleTextShadow))
				-- Other text
				QuestInfoDescriptionText:SetTextColor(unpack(textColor))
				QuestInfoObjectivesText:SetTextColor(unpack(textColor))
				QuestInfoGroupSize:SetTextColor(unpack(textColor))
				QuestInfoRewardText:SetTextColor(unpack(textColor))
				-- Reward frame text
				QuestInfoItemChooseText:SetTextColor(unpack(textColor))
				QuestInfoItemReceiveText:SetTextColor(unpack(textColor))
				QuestInfoSpellLearnText:SetTextColor(unpack(textColor))
				QuestInfoXPFrameReceiveText:SetTextColor(unpack(textColor))

				QuestObjectiveText()
			end)

			hooksecurefunc("QuestInfo_ShowRequiredMoney", function()
				local requiredMoney = GetQuestLogRequiredMoney()
				if requiredMoney > 0 then
					if requiredMoney > GetMoney() then
						QuestInfoRequiredMoneyText:SetTextColor(0.6, 0.6, 0.6)
					else
						QuestInfoRequiredMoneyText:SetTextColor(1, 0.8, 0)
					end
				end
			end)

			QuestLogFrame:HookScript("OnShow", function()
				QuestLogScrollFrame:Height(QuestLogScrollFrame:GetHeight() - 3)
				QuestLogDetailScrollFrame:Height(QuestLogScrollFrame:GetHeight() - 3)
			end)
		end

		-- Dressing Room Frame
		do
			DressUpFrame:StripTextures(true)
			DressUpFrame:CreateBackdrop("Transparent")
			DressUpFrame.backdrop:Point("TOPLEFT", 16, -12)
			DressUpFrame.backdrop:Point("BOTTOMRIGHT", -30, 76)

			DressUpFrameResetButton:SkinButton()
			DressUpFrameCancelButton:SkinButton()
			SkinCloseButton(DressUpFrameCloseButton, DressUpFrame.backdrop)
			SkinRotateButton(DressUpModelRotateLeftButton)
			SkinRotateButton(DressUpModelRotateRightButton)
			DressUpModelRotateRightButton:Point("TOPLEFT", DressUpModelRotateLeftButton, "TOPRIGHT", 2, 0)
			DressUpFrameCancelButton:Point("BOTTOMRIGHT", DressUpFrame.backdrop, "BOTTOMRIGHT", -4, 4)
			DressUpFrameResetButton:Point("RIGHT", DressUpFrameCancelButton, "LEFT", -2, 0)
		end

		-- Honor/Conquest Panel
		do
			local buttons = {
				"PVPFrameLeftButton",
				"PVPFrameRightButton",
				"PVPColorPickerButton1",
				"PVPColorPickerButton2",
				"PVPColorPickerButton3",
				"PVPBannerFrameAcceptButton",
			}

			if not T.PTRVersion() then
				tinsert(buttons, "PVPHonorFrameWarGameButton")
			end

			for i = 1, #buttons do
				_G[buttons[i]]:StripTextures()
				_G[buttons[i]]:SkinButton()
			end

			local KillTextures = {
				"PVPHonorFrameBGTex",
				"PVPHonorFrameInfoScrollFrameScrollBar",
				"PVPConquestFrameInfoButtonInfoBG",
				"PVPConquestFrameInfoButtonInfoBGOff",
				"PVPTeamManagementFrameFlag2GlowBG",
				"PVPTeamManagementFrameFlag3GlowBG",
				"PVPTeamManagementFrameFlag5GlowBG",
				"PVPTeamManagementFrameFlag2HeaderSelected",
				"PVPTeamManagementFrameFlag3HeaderSelected",
				"PVPTeamManagementFrameFlag5HeaderSelected",
				"PVPTeamManagementFrameFlag2Header",
				"PVPTeamManagementFrameFlag3Header",
				"PVPTeamManagementFrameFlag5Header",
				"PVPTeamManagementFrameWeeklyDisplayLeft",
				"PVPTeamManagementFrameWeeklyDisplayRight",
				"PVPTeamManagementFrameWeeklyDisplayMiddle",
				"PVPBannerFramePortrait",
				"PVPBannerFramePortraitFrame",
				"PVPBannerFrameInset",
				"PVPBannerFrameEditBoxLeft",
				"PVPBannerFrameEditBoxRight",
				"PVPBannerFrameEditBoxMiddle",
				"PVPBannerFrameCancelButton_LeftSeparator",
			}

			for _, texture in pairs(KillTextures) do
				_G[texture]:Kill()
			end

			local StripAllTextures = {
				"PVPFrame",
				"PVPFrameInset",
				"PVPHonorFrame",
				"PVPConquestFrame",
				"PVPTeamManagementFrame",
				"PVPHonorFrameTypeScrollFrame",
				"PVPFrameTopInset",
				"PVPTeamManagementFrameInvalidTeamFrame",
				"PVPBannerFrame",
				"PVPBannerFrameCustomization1",
				"PVPBannerFrameCustomization2",
				"PVPBannerFrameCustomizationFrame",
			}

			for _, object in pairs(StripAllTextures) do
				_G[object]:StripTextures()
			end

			local function ArenaHeader(self, first, i)
				local button = _G["PVPTeamManagementFrameHeader"..i]

				if first then
					button:StripTextures()
				end
			end

			for i = 1, 4 do
				ArenaHeader(nil, true, i)
			end

			PVPBannerFrame:ClearAllPoints()
			PVPBannerFrame:Point("TOPLEFT", PVPFrame, "TOPRIGHT", 3, 0)
			PVPBannerFrame.SetPoint = T.dummy
			PVPBannerFrameEditBox:CreateBackdrop("Overlay")
			PVPBannerFrameEditBox.backdrop:Point("TOPLEFT", PVPBannerFrameEditBox, "TOPLEFT" , -5, -5)
			PVPBannerFrameEditBox.backdrop:Point("BOTTOMRIGHT", PVPBannerFrameEditBox, "BOTTOMRIGHT", 5, 5)
			PVPHonorFrameInfoScrollFrameChildFrameDescription:SetTextColor(1, 1, 1)
			PVPHonorFrameInfoScrollFrameChildFrameRewardsInfo.description:SetTextColor(1, 1, 1)
			PVPTeamManagementFrameInvalidTeamFrame:CreateBackdrop("Overlay")
			PVPTeamManagementFrameInvalidTeamFrame:SetFrameLevel(PVPTeamManagementFrameInvalidTeamFrame:GetFrameLevel() + 1)
			PVPTeamManagementFrameInvalidTeamFrame.backdrop:Point("TOPLEFT", PVPTeamManagementFrameInvalidTeamFrame, "TOPLEFT")
			PVPTeamManagementFrameInvalidTeamFrame.backdrop:Point("BOTTOMRIGHT", PVPTeamManagementFrameInvalidTeamFrame, "BOTTOMRIGHT")
			PVPTeamManagementFrameInvalidTeamFrame.backdrop:SetFrameLevel(PVPTeamManagementFrameInvalidTeamFrame:GetFrameLevel())

			if not T.PTRVersion() then
				PVPFrameConquestBar:StripTextures()
				PVPFrameConquestBar:SetStatusBarTexture(C.media.texture)
				PVPFrameConquestBar:CreateBackdrop("Overlay")
			else
				PVPFrameConquestBarLeft:Kill()
				PVPFrameConquestBarRight:Kill()
				PVPFrameConquestBarMiddle:Kill()
				PVPFrameConquestBarBG:Kill()
				PVPFrameConquestBarShadow:Kill()
				PVPFrameConquestBar.progress:SetTexture(C.media.texture)
				PVPFrameConquestBar:CreateBackdrop("Overlay")
				PVPFrameConquestBar.backdrop:Point("TOPLEFT", PVPFrameConquestBar.progress, "TOPLEFT", -2, 2)
				PVPFrameConquestBar.backdrop:Point("BOTTOMRIGHT", PVPFrameConquestBar, "BOTTOMRIGHT", -2, 2)
			end

			PVPBannerFrame:CreateBackdrop("Transparent")
			PVPBannerFrame.backdrop:Point("TOPLEFT", PVPBannerFrame, "TOPLEFT")
			PVPBannerFrame.backdrop:Point("BOTTOMRIGHT", PVPBannerFrame, "BOTTOMRIGHT")
			PVPBannerFrameCustomization1:CreateBackdrop("Overlay")
			PVPBannerFrameCustomization1.backdrop:Point("TOPLEFT", PVPBannerFrameCustomization1LeftButton, "TOPRIGHT" , 2, 0)
			PVPBannerFrameCustomization1.backdrop:Point("BOTTOMRIGHT", PVPBannerFrameCustomization1RightButton, "BOTTOMLEFT", -2, 0)
			PVPBannerFrameCustomization2:CreateBackdrop("Overlay")
			PVPBannerFrameCustomization2.backdrop:Point("TOPLEFT", PVPBannerFrameCustomization2LeftButton, "TOPRIGHT", 2, 0)
			PVPBannerFrameCustomization2.backdrop:Point("BOTTOMRIGHT", PVPBannerFrameCustomization2RightButton, "BOTTOMLEFT", -2, 0)
			SkinCloseButton(PVPBannerFrameCloseButton, PVPBannerFrame)
			SkinNextPrevButton(PVPBannerFrameCustomization1LeftButton)
			PVPBannerFrameCustomization1LeftButton:Height(PVPBannerFrameCustomization1:GetHeight())
			SkinNextPrevButton(PVPBannerFrameCustomization1RightButton)
			PVPBannerFrameCustomization1RightButton:Height(PVPBannerFrameCustomization1:GetHeight())
			SkinNextPrevButton(PVPBannerFrameCustomization2LeftButton)
			PVPBannerFrameCustomization2LeftButton:Height(PVPBannerFrameCustomization1:GetHeight())
			SkinNextPrevButton(PVPBannerFrameCustomization2RightButton)
			PVPBannerFrameCustomization2RightButton:Height(PVPBannerFrameCustomization1:GetHeight())
			PVPFrame:CreateBackdrop("Transparent")
			PVPFrame.backdrop:Point("TOPLEFT", PVPFrame, "TOPLEFT")
			PVPFrame.backdrop:Point("BOTTOMRIGHT", PVPFrame, "BOTTOMRIGHT")
			SkinCloseButton(PVPFrameCloseButton, PVPFrame)
			SkinNextPrevButton(PVPTeamManagementFrameWeeklyToggleLeft)
			SkinNextPrevButton(PVPTeamManagementFrameWeeklyToggleRight)
			PVPColorPickerButton1:Height(PVPColorPickerButton1:GetHeight() - 5)
			PVPColorPickerButton2:Height(PVPColorPickerButton1:GetHeight())
			PVPColorPickerButton3:Height(PVPColorPickerButton1:GetHeight())

			-- War Games
			if T.PTRVersion() then
				WarGameStartButton:SkinButton(true)
				WarGamesFrame:StripTextures()
				WarGamesFrameInfoScrollFrameScrollBar:StripTextures()
				SkinScrollBar(WarGamesFrameScrollFrameScrollBar)

				WarGameStartButton:ClearAllPoints()
				WarGameStartButton:Point("LEFT", PVPFrameLeftButton, "RIGHT", 2, 0)

				WarGamesFrameDescription:SetTextColor(1, 1, 1)
			end

			-- Cancel Button FFSlocal
			local f = PVPBannerFrameCancelButton
			local l = _G[f:GetName().."Left"]
			local m = _G[f:GetName().."Middle"]
			local r = _G[f:GetName().."Right"]
			if l then l:SetAlpha(0) end
			if m then m:SetAlpha(0) end
			if r then r:SetAlpha(0) end
			f:CreateBackdrop("Overlay")
			f:SetFrameLevel(PVPBannerFrameAcceptButton:GetFrameLevel() + 1)
			f.backdrop:Point("TOPLEFT", PVPBannerFrameAcceptButton, "TOPLEFT", PVPBannerFrame:GetWidth() - PVPBannerFrameAcceptButton:GetWidth() - 10, 0)
			f.backdrop:Point("BOTTOMRIGHT", PVPBannerFrameAcceptButton, "BOTTOMRIGHT", PVPBannerFrame:GetWidth() - PVPBannerFrameAcceptButton:GetWidth() - 10, 0)
			f.backdrop:SetFrameLevel(f:GetFrameLevel() - 1)

			-- Bottom Tabs
			if not T.PTRVersion() then
				for i = 1, 3 do
					SkinTab(_G["PVPFrameTab"..i])
				end
			else
				for i = 1, 4 do
					SkinTab(_G["PVPFrameTab"..i])
				end
			end

			-- Reposition tabs
			PVPFrameTab1:ClearAllPoints()
			PVPFrameTab1:SetPoint("TOPLEFT", PVPFrame, "BOTTOMLEFT", 0, 2)
		end

		-- Non Raid Frame
		do
			local StripAllTextures = {
				"RaidInfoFrame",
				"RaidInfoInstanceLabel",
				"RaidInfoIDLabel",
			}

			local KillTextures = {
				"RaidInfoScrollFrameScrollBarBG",
				"RaidInfoScrollFrameScrollBarTop",
				"RaidInfoScrollFrameScrollBarBottom",
				"RaidInfoScrollFrameScrollBarMiddle",
			}
			local buttons = {
				"RaidFrameConvertToRaidButton",
				"RaidFrameRaidInfoButton",
				"RaidFrameNotInRaidRaidBrowserButton",
				"RaidInfoExtendButton",
				"RaidInfoCancelButton",
			}

			for _, object in pairs(StripAllTextures) do
				_G[object]:StripTextures()
			end

			for _, texture in pairs(KillTextures) do
				_G[texture]:Kill()
			end

			for i = 1, #buttons do
				_G[buttons[i]]:SkinButton()
			end
			RaidInfoScrollFrame:StripTextures()
			RaidInfoFrame:CreateBackdrop("Transparent")
			RaidInfoFrame.backdrop:Point("TOPLEFT", RaidInfoFrame, "TOPLEFT")
			RaidInfoFrame.backdrop:Point("BOTTOMRIGHT", RaidInfoFrame, "BOTTOMRIGHT")
			SkinCloseButton(RaidInfoCloseButton, RaidInfoFrame)
		end

		-- Friends/Social Panel
		do
			local StripAllTextures = {
				"FriendsListFrame",
				"FriendsTabHeader",
				"FriendsFrameFriendsScrollFrame",
				"WhoFrameColumnHeader1",
				"WhoFrameColumnHeader2",
				"WhoFrameColumnHeader3",
				"WhoFrameColumnHeader4",
				"ChannelListScrollFrame",
				"ChannelRoster",
				"FriendsFramePendingButton1",
				"FriendsFramePendingButton2",
				"FriendsFramePendingButton3",
				"FriendsFramePendingButton4",
				"ChannelFrameDaughterFrame",
				"AddFriendFrame",
				"AddFriendNoteFrame",
				"FriendsFriendsFrame",
				"FriendsFriendsNoteFrame",
				"FriendsFriendsList",
				"BNConversationInviteDialog",
				"BNConversationInviteDialogList",
			}

			local KillTextures = {
				"FriendsFrameTopLeft",
				"FriendsFrameTopRight",
				"FriendsFrameBottomLeft",
				"FriendsFrameBottomRight",
				"ChannelFrameVerticalBar",
				"FriendsFrameBroadcastInputLeft",
				"FriendsFrameBroadcastInputRight",
				"FriendsFrameBroadcastInputMiddle",
				"ChannelFrameDaughterFrameChannelNameLeft",
				"ChannelFrameDaughterFrameChannelNameRight",
				"ChannelFrameDaughterFrameChannelNameMiddle",
				"ChannelFrameDaughterFrameChannelPasswordLeft",
				"ChannelFrameDaughterFrameChannelPasswordRight",
				"ChannelFrameDaughterFrameChannelPasswordMiddle",
			}

			local buttons = {
				"FriendsFrameAddFriendButton",
				"FriendsFrameSendMessageButton",
				"WhoFrameWhoButton",
				"WhoFrameAddFriendButton",
				"WhoFrameGroupInviteButton",
				"ChannelFrameNewButton",
				"FriendsFrameIgnorePlayerButton",
				"FriendsFrameUnsquelchButton",
				"FriendsFramePendingButton1AcceptButton",
				"FriendsFramePendingButton1DeclineButton",
				"FriendsFramePendingButton2AcceptButton",
				"FriendsFramePendingButton2DeclineButton",
				"FriendsFramePendingButton3AcceptButton",
				"FriendsFramePendingButton3DeclineButton",
				"FriendsFramePendingButton4AcceptButton",
				"FriendsFramePendingButton4DeclineButton",
				"ChannelFrameDaughterFrameOkayButton",
				"ChannelFrameDaughterFrameCancelButton",
				"AddFriendEntryFrameAcceptButton",
				"AddFriendEntryFrameCancelButton",
				"AddFriendInfoFrameContinueButton",
				"FriendsFriendsCloseButton",
				"FriendsFriendsSendRequestButton",
				"BNConversationInviteDialogCancelButton",
				"BNConversationInviteDialogInviteButton",
			}

			for _, button in pairs(buttons) do
				_G[button]:SkinButton()
			end

			FriendsFrame:StripTextures(true)

			-- Reposition buttons
			WhoFrameWhoButton:Point("RIGHT", WhoFrameAddFriendButton, "LEFT", -2, 0)
			WhoFrameAddFriendButton:Point("RIGHT", WhoFrameGroupInviteButton, "LEFT", -2, 0)
			WhoFrameGroupInviteButton:Point("BOTTOMRIGHT", WhoFrame, "BOTTOMRIGHT", -44, 82)

			-- Resize Buttons
			WhoFrameWhoButton:Size(WhoFrameWhoButton:GetWidth() - 4, WhoFrameWhoButton:GetHeight())
			WhoFrameAddFriendButton:Size(WhoFrameAddFriendButton:GetWidth() - 4, WhoFrameAddFriendButton:GetHeight())
			WhoFrameGroupInviteButton:Size(WhoFrameGroupInviteButton:GetWidth() - 4, WhoFrameGroupInviteButton:GetHeight())
			SkinEditBox(WhoFrameEditBox)
			WhoFrameEditBox:Height(WhoFrameEditBox:GetHeight() - 15)
			WhoFrameEditBox:Point("BOTTOM", WhoFrame, "BOTTOM", -10, 108)
			WhoFrameEditBox:Width(WhoFrameEditBox:GetWidth() + 17)

			for _, texture in pairs(KillTextures) do
				_G[texture]:Kill()
			end

			for _, object in pairs(StripAllTextures) do
				_G[object]:StripTextures()
			end

			SkinEditBox(AddFriendNameEditBox)
			AddFriendFrame:SetTemplate("Transparent")
			FriendsFriendsFrame:SetTemplate("Transparent")
			FriendsFriendsNoteFrame:SetTemplate("Overlay")
			FriendsFriendsList:SetTemplate("Overlay")

			-- Who Frame
			local function UpdateWhoSkins()
				WhoListScrollFrame:StripTextures()
			end
			-- Channel Frame
			local function UpdateChannel()
				ChannelRosterScrollFrame:StripTextures()
			end
			-- BNet Frame
			FriendsFrameBroadcastInput:CreateBackdrop("Overlay")
			FriendsFrameBroadcastInput.backdrop:Point("TOPLEFT", -2, 2)
			FriendsFrameBroadcastInput.backdrop:Point("BOTTOMRIGHT", 0, 1)
			ChannelFrameDaughterFrameChannelName:CreateBackdrop("Overlay")
			ChannelFrameDaughterFrameChannelPassword:CreateBackdrop("Overlay")
			BNConversationInviteDialog:SetTemplate("Transparent")
			BNConversationInviteDialogList:SetTemplate("Overlay")

			ChannelFrame:HookScript("OnShow", UpdateChannel)
			hooksecurefunc("FriendsFrame_OnEvent", UpdateChannel)

			WhoFrame:HookScript("OnShow", UpdateWhoSkins)
			hooksecurefunc("FriendsFrame_OnEvent", UpdateWhoSkins)

			ChannelFrameDaughterFrame:CreateBackdrop("Transparent")
			FriendsFrame:CreateBackdrop("Transparent")
			FriendsFrame.backdrop:Point("TOPLEFT", FriendsFrame, "TOPLEFT", 16, -12)
			FriendsFrame.backdrop:Point("BOTTOMRIGHT", FriendsFrame, "BOTTOMRIGHT", -30, 76)
			SkinCloseButton(ChannelFrameDaughterFrameDetailCloseButton, ChannelFrameDaughterFrame)
			SkinCloseButton(FriendsFrameCloseButton, FriendsFrame.backdrop)
			SkinDropDownBox(WhoFrameDropDown, 150)
			SkinDropDownBox(FriendsFrameStatusDropDown, 70)
			SkinDropDownBox(FriendsFriendsFrameDropDown)
			FriendsFrameAddFriendButton:Point("BOTTOMLEFT", FriendsFrame.backdrop, "BOTTOMLEFT", 5, 5)
			FriendsFrameIgnorePlayerButton:Point("BOTTOMLEFT", FriendsFrame.backdrop, "BOTTOMLEFT", 5, 5)

			-- Bottom Tabs
			for i = 1, 5 do
				SkinTab(_G["FriendsFrameTab"..i])
			end

			for i = 1, 3 do
				_G["FriendsTabHeaderTab"..i]:StripTextures()
			end

			local function Channel()
				for i = 1, MAX_DISPLAY_CHANNEL_BUTTONS do
					local button = _G["ChannelButton"..i]
					if button then
						button:StripTextures()
						button:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")
					end
				end
			end
			hooksecurefunc("ChannelList_Update", Channel)
		end

		-- Spellbook
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
			pagebackdrop:SetTemplate("Overlay")
			pagebackdrop:Point("TOPLEFT", SpellBookFrame, "TOPLEFT", 50, -50)
			pagebackdrop:Point("BOTTOMRIGHT", SpellBookPage1, "BOTTOMRIGHT", 5, 35)

			SkinNextPrevButton(SpellBookPrevPageButton)
			SkinNextPrevButton(SpellBookNextPageButton)
			SpellBookNextPageButton:Point("BOTTOMRIGHT", pagebackdrop, "BOTTOMRIGHT", -15, 10)
			SpellBookPrevPageButton:Point("BOTTOMRIGHT", SpellBookNextPageButton, "BOTTOMLEFT", -6, 0)

			-- Skin SpellButtons
			local function SpellButtons(self, first)
				for i = 1, SPELLS_PER_PAGE do
					local button = _G["SpellButton"..i]
					local icon = _G["SpellButton"..i.."IconTexture"]

					if first then
						for i = 1, button:GetNumRegions() do
							local region = select(i, button:GetRegions())
							if region:GetObjectType() == "Texture" then
								if region:GetTexture() ~= "Interface\\Buttons\\ActionBarFlyoutButton" then
									region:SetTexture(nil)
								end
							end
						end
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

						if not button.backdrop then
							button:SetFrameLevel(button:GetFrameLevel() + 1)
							button:CreateBackdrop("Default", true)
						end
					end

					local r, g, b = _G["SpellButton"..i.."SpellName"]:GetTextColor()

					if r < 0.8 then
						_G["SpellButton"..i.."SpellName"]:SetTextColor(0.6, 0.6, 0.6)
					end
					_G["SpellButton"..i.."SubSpellName"]:SetTextColor(0.6, 0.6, 0.6)
					_G["SpellButton"..i.."RequiredLevelString"]:SetTextColor(0.6, 0.6, 0.6)
				end
			end
			SpellButtons(nil, true)
			hooksecurefunc("SpellButton_UpdateButton", SpellButtons)

			SpellBookPageText:SetTextColor(0.6, 0.6, 0.6)

			-- Skill Line Tabs
			for i = 1, MAX_SKILLLINE_TABS do
				local tab = _G["SpellBookSkillLineTab"..i]
				_G["SpellBookSkillLineTab"..i.."Flash"]:Kill()
				if tab then
					tab:StripTextures()
					tab:GetNormalTexture():ClearAllPoints()
					tab:GetNormalTexture():Point("TOPLEFT", 2, -2)
					tab:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
					tab:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)

					tab:CreateBackdrop("Default")
					tab.backdrop:SetAllPoints()
					tab:StyleButton(true)

					local point, relatedTo, point2, x, y = tab:GetPoint()
					tab:Point(point, relatedTo, point2, 16, -1)
				end
			end

			local function SkinSkillLine()
				for i = 1, MAX_SKILLLINE_TABS do
					local tab = _G["SpellBookSkillLineTab"..i]
					local _, _, _, _, isGuild = GetSpellTabInfo(i)
					if isGuild then
						tab:GetNormalTexture():ClearAllPoints()
						tab:GetNormalTexture():Point("TOPLEFT", 2, -2)
						tab:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
						tab:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
					end
				end
			end
			hooksecurefunc("SpellBookFrame_UpdateSkillLineTabs", SkinSkillLine)

			SpellBookFrame:CreateBackdrop("Transparent")
			SpellBookFrame.backdrop:Point("TOPLEFT", 5, -1)
			SpellBookFrame.backdrop:Point("BOTTOMRIGHT", 15, -1)

			SkinCloseButton(SpellBookFrameCloseButton, SpellBookFrame.backdrop)

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

			local professionheaders = {
				"PrimaryProfession1",
				"PrimaryProfession2",
				"SecondaryProfession1",
				"SecondaryProfession2",
				"SecondaryProfession3",
				"SecondaryProfession4",
			}

			for _, header in pairs(professionheaders) do
				_G[header.."Missing"]:SetTextColor(1, 0.8, 0)
				_G[header.."Missing"]:SetShadowColor(0, 0, 0)
				_G[header.."Missing"]:SetShadowOffset(1, -1)
				_G[header].missingText:SetTextColor(0.6, 0.6, 0.6)
			end

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
				statusbar:CreateBackdrop("Overlay")

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
			SpellBookCompanionModelFrame:SetTemplate("Overlay")
			SpellBookCompanionsFrame:SetFrameLevel(SpellBookCompanionsFrame:GetFrameLevel() + 2)

			SkinRotateButton(SpellBookCompanionModelFrameRotateRightButton)
			SkinRotateButton(SpellBookCompanionModelFrameRotateLeftButton)
			SpellBookCompanionModelFrameRotateRightButton:Point("TOPLEFT", SpellBookCompanionModelFrameRotateLeftButton, "TOPRIGHT", 3, 0)

			-- Bottom Tabs
			for i = 1, 5 do
				SkinTab(_G["SpellBookFrameTabButton"..i])
			end
			_G["SpellBookFrameTabButton1"]:ClearAllPoints()
			_G["SpellBookFrameTabButton1"]:Point("TOPLEFT", _G["SpellBookFrame"], "BOTTOMLEFT", -5, 1)
		end

		-- Character Frame
		do
			SkinCloseButton(CharacterFrameCloseButton)

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

			for _, scrollbar in pairs(scrollbars) do
				SkinScrollBar(_G[scrollbar])
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
				GearManagerDialogPopupEditBox:StripTextures(true)
				GearManagerDialogPopupEditBox:SetTemplate("Default")
				GearManagerDialogPopupEditBox:SetTextInsets(3, 0, 0, 0)
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
							for i = 1, tab:GetNumRegions() do
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
				ReputationFrame:StripTextures(true)
				for i = 1, GetNumFactions() do
					local statusbar = _G["ReputationBar"..i.."ReputationBar"]

					if statusbar then
						statusbar:SetStatusBarTexture(C.media.texture)

						if not statusbar.backdrop then
							statusbar:CreateBackdrop("Overlay")
						end

						_G["ReputationBar"..i.."Background"]:SetTexture(nil)
						_G["ReputationBar"..i.."LeftLine"]:Kill()
						_G["ReputationBar"..i.."BottomLine"]:Kill()
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
				SkinCloseButton(ReputationDetailCloseButton)
				SkinCheckBox(ReputationDetailMainScreenCheckBox)
				SkinCheckBox(ReputationDetailInactiveCheckBox)
				SkinCheckBox(ReputationDetailAtWarCheckBox)
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
				SkinCloseButton(TokenFramePopupCloseButton)
				SkinCheckBox(TokenFramePopupBackpackCheckBox)
				SkinCheckBox(TokenFramePopupInactiveCheckBox)
			end)

			-- Pet
			PetModelFrame:CreateBackdrop("Default")
			PetModelFrame.backdrop:Point("TOPLEFT", -2, 2)
			PetModelFrame.backdrop:Point("BOTTOMRIGHT", 1, -2)
			PetPaperDollFrameExpBar:StripTextures()
			PetPaperDollFrameExpBar:SetStatusBarTexture(C.media.texture)
			PetPaperDollFrameExpBar:CreateBackdrop("Overlay")
			SkinRotateButton(PetModelFrameRotateRightButton)
			SkinRotateButton(PetModelFrameRotateLeftButton)
			PetModelFrameRotateLeftButton:ClearAllPoints()
			PetModelFrameRotateLeftButton:Point("TOPLEFT", PetModelFrame.backdrop, "TOPLEFT", 6, -6)
			PetModelFrameRotateRightButton:ClearAllPoints()
			PetModelFrameRotateRightButton:Point("LEFT", PetModelFrameRotateLeftButton, "RIGHT", 4, 0)

			local xtex = PetPaperDollPetInfo:GetRegions()
			xtex:SetTexCoord(0.12, 0.63, 0.15, 0.55)
			PetPaperDollPetInfo:CreateBackdrop("Default")
			PetPaperDollPetInfo:Size(24, 24)

			CharacterFrame:SetTemplate("Transparent")
			CharacterFrame:SetFrameStrata("DIALOG")
		end

		-- Interface Frame
		do
			local checkbox = {
				-- Controls
				"ControlsPanelStickyTargeting",
				"ControlsPanelAutoDismount",
				"ControlsPanelAutoClearAFK",
				"ControlsPanelBlockTrades",
				"ControlsPanelBlockGuildInvites",
				"ControlsPanelLootAtMouse",
				"ControlsPanelAutoLootCorpse",
				-- Combat
				"CombatPanelAutoSelfCast",
				"CombatPanelAttackOnAssist",
				"CombatPanelStopAutoAttack",
				"CombatPanelNameplateClassColors",
				"CombatPanelTargetOfTarget",
				"CombatPanelShowSpellAlerts",
				"CombatPanelReducedLagTolerance",
				"CombatPanelActionButtonUseKeyDown",
				"CombatPanelEnemyCastBarsOnPortrait",
				"CombatPanelEnemyCastBarsOnNameplates",
				-- Display
				"DisplayPanelShowCloak",
				"DisplayPanelShowHelm",
				"DisplayPanelShowAggroPercentage",
				"DisplayPanelPlayAggroSounds",
				"DisplayPanelDetailedLootInfo",
				"DisplayPanelShowSpellPointsAvg",
				"DisplayPanelemphasizeMySpellEffects",
				"DisplayPanelShowFreeBagSpace",
				"DisplayPanelCinematicSubtitles",
				"DisplayPanelRotateMinimap",
				"DisplayPanelScreenEdgeFlash",
				--Objectives
				"ObjectivesPanelAutoQuestTracking",
				"ObjectivesPanelAutoQuestProgress",
				"ObjectivesPanelMapQuestDifficulty",
				"ObjectivesPanelAdvancedWorldMap",
				"ObjectivesPanelWatchFrameWidth",
				-- Social
				"SocialPanelProfanityFilter",
				"SocialPanelSpamFilter",
				"SocialPanelChatBubbles",
				"SocialPanelPartyChat",
				"SocialPanelChatHoverDelay",
				"SocialPanelGuildMemberAlert",
				"SocialPanelChatMouseScroll",
				-- Action bars
				"ActionBarsPanelLockActionBars",
				"ActionBarsPanelSecureAbilityToggle",
				-- Names
				"NamesPanelMyName",
				"NamesPanelFriendlyPlayerNames",
				"NamesPanelFriendlyPets",
				"NamesPanelFriendlyGuardians",
				"NamesPanelFriendlyTotems",
				"NamesPanelUnitNameplatesFriends",
				"NamesPanelUnitNameplatesFriendlyGuardians",
				"NamesPanelUnitNameplatesFriendlyPets",
				"NamesPanelUnitNameplatesFriendlyTotems",
				"NamesPanelGuilds",
				"NamesPanelGuildTitles",
				"NamesPanelTitles",
				"NamesPanelNonCombatCreature",
				"NamesPanelEnemyPlayerNames",
				"NamesPanelEnemyPets",
				"NamesPanelEnemyGuardians",
				"NamesPanelEnemyTotems",
				"NamesPanelUnitNameplatesEnemyPets",
				"NamesPanelUnitNameplatesEnemies",
				"NamesPanelUnitNameplatesEnemyGuardians",
				"NamesPanelUnitNameplatesEnemyTotems",
				-- CombatText
				"CombatTextPanelTargetDamage",
				"CombatTextPanelPeriodicDamage",
				"CombatTextPanelPetDamage",
				"CombatTextPanelHealing",
				"CombatTextPanelTargetEffects",
				"CombatTextPanelOtherTargetEffects",
				"CombatTextPanelEnableFCT",
				"CombatTextPanelDodgeParryMiss",
				"CombatTextPanelDamageReduction",
				"CombatTextPanelRepChanges",
				"CombatTextPanelReactiveAbilities",
				"CombatTextPanelFriendlyHealerNames",
				"CombatTextPanelCombatState",
				"CombatTextPanelComboPoints",
				"CombatTextPanelLowManaHealth",
				"CombatTextPanelEnergyGains",
				"CombatTextPanelPeriodicEnergyGains",
				"CombatTextPanelHonorGains",
				"CombatTextPanelAuras",
				"CombatTextPanelAutoSelfCast",
				-- Buffs
				"BuffsPanelBuffDurations",
				"BuffsPanelDispellableDebuffs",
				"BuffsPanelCastableBuffs",
				"BuffsPanelShowCastableDebuffs",
				"BuffsPanelConsolidateBuffs",
				-- Battlenet
				"BattlenetPanelConversations",
				"BattlenetPanelOnlineFriends",
				"BattlenetPanelOfflineFriends",
				"BattlenetPanelBroadcasts",
				"BattlenetPanelFriendRequests",
				"BattlenetPanelOnlineFriendsConversations",
				"BattlenetPanelShowToastWindow",
				-- Camera
				"CameraPanelFollowTerrain",
				"CameraPanelHeadBob",
				"CameraPanelWaterCollision",
				"CameraPanelSmartPivot",
				-- Mouse
				"MousePanelInvertMouse",
				"MousePanelClickToMove",
				"MousePanelWoWMouse",
				-- Help
				"HelpPanelShowTutorials",
				"HelpPanelLoadingScreenTips",
				"HelpPanelEnhancedTooltips",
				"HelpPanelBeginnerTooltips",
				"HelpPanelShowLuaErrors",
				"HelpPanelColorblindMode",
				"HelpPanelMovePad",
			}

			if not T.PTRVersion() then
				tinsert(checkbox, "DisplayPanelColorblindMode")
			end

			for i = 1, getn(checkbox) do
				local button = _G["InterfaceOptions"..checkbox[i]]
				if button then
					SkinCheckBox(button)
				end
			end

			local dropdown ={
				"ControlsPanelAutoLootKeyDropDown",
				"CombatPanelTOTDropDown",
				"CombatPanelFocusCastKeyDropDown",
				"CombatPanelSelfCastKeyDropDown",
				"DisplayPanelAggroWarningDisplay",
				"DisplayPanelWorldPVPObjectiveDisplay",
				"SocialPanelChatStyle",
				"SocialPanelWhisperMode",
				"SocialPanelTimestamps",
				"SocialPanelBnWhisperMode",
				"ActionBarsPanelPickupActionKeyDropDown",
				"NamesPanelNPCNamesDropDown",
				"NamesPanelUnitNameplatesMotionDropDown",
				"CombatTextPanelFCTDropDown",
				"CameraPanelStyleDropDown",
				"MousePanelClickMoveStyleDropDown",
				"LanguagesPanelLocaleDropDown",
			}

			for i = 1, getn(dropdown) do
				local frame = _G["InterfaceOptions"..dropdown[i]]
				if frame then
					SkinDropDownBox(frame)
				end
			end
		end

		-- Options Frame
		do
			local checkbox = {
				"Advanced_MaxFPSCheckBox",
				"Advanced_MaxFPSBKCheckBox",
				"AudioOptionsSoundPanelEnableSound",
				"AudioOptionsSoundPanelSoundEffects",
				"AudioOptionsSoundPanelErrorSpeech",
				"AudioOptionsSoundPanelEmoteSounds",
				"AudioOptionsSoundPanelPetSounds",
				"AudioOptionsSoundPanelMusic",
				"AudioOptionsSoundPanelLoopMusic",
				"AudioOptionsSoundPanelAmbientSounds",
				"AudioOptionsSoundPanelSoundInBG",
				"AudioOptionsSoundPanelReverb",
				"AudioOptionsSoundPanelHRTF",
				"AudioOptionsSoundPanelEnableDSPs",
				"AudioOptionsSoundPanelUseHardware",
				"AudioOptionsVoicePanelEnableVoice",
				"AudioOptionsVoicePanelEnableMicrophone",
				"AudioOptionsVoicePanelPushToTalkSound",
				"NetworkOptionsPanelOptimizeSpeed",
				"NetworkOptionsPanelUseIPv6",
			}

			for i = 1, getn(checkbox) do
				local button = _G[checkbox[i]]
				if button then
					SkinCheckBox(button)
				end
			end

			local dropdown = {
				"Graphics_DisplayModeDropDown",
				"Graphics_ResolutionDropDown",
				"Graphics_RefreshDropDown",
				"Graphics_PrimaryMonitorDropDown",
				"Graphics_MultiSampleDropDown",
				"Graphics_VerticalSyncDropDown",
				"Graphics_TextureResolutionDropDown",
				"Graphics_FilteringDropDown",
				"Graphics_ProjectedTexturesDropDown",
				"Graphics_ViewDistanceDropDown",
				"Graphics_EnvironmentalDetailDropDown",
				"Graphics_GroundClutterDropDown",
				"Graphics_ShadowsDropDown",
				"Graphics_LiquidDetailDropDown",
				"Graphics_SunshaftsDropDown",
				"Graphics_ParticleDensityDropDown",
				"Advanced_BufferingDropDown",
				"Advanced_LagDropDown",
				"Advanced_HardwareCursorDropDown",
				"Advanced_GraphicsAPIDropDown",
				"AudioOptionsSoundPanelHardwareDropDown",
				"AudioOptionsSoundPanelSoundChannelsDropDown",
				"AudioOptionsVoicePanelInputDeviceDropDown",
				"AudioOptionsVoicePanelChatModeDropDown",
				"AudioOptionsVoicePanelOutputDeviceDropDown",
			}

			for i = 1, getn(dropdown) do
				local frame = _G[dropdown[i]]
				if frame then
					SkinDropDownBox(frame, 165)
				end
			end
		end

		-- Other buttons
		OpenAllButton:SkinButton()
		OpenAllButton2:SkinButton()
		DressUpFrameUndressButton:SkinButton()
		SkinCloseButton(RolePollPopupCloseButton)
		if C.bag.enable == true then
			SkinCloseButton(Stuffing_CloseButtonBags)
			Stuffing_CloseButtonBags:Size(Stuffing_CloseButtonBags:GetWidth() - 2, Stuffing_CloseButtonBags:GetHeight() - 2)
		end
		if C.extra_general.click_cast == true then
			SpellBinderMainFrame:StripTextures()
			SpellBinderMainFrame:SetTemplate("Transparent")
			SpellBinderOpenButton:SkinButton()
			SpellBinderOpenButton:ClearAllPoints()
			SpellBinderOpenButton:Point("TOPLEFT", SpellBookFrame.backdrop, "TOPLEFT", 4, -4)
			btn_SpellBinderMainFrame:SkinButton()
			SkinCloseButton(SpellBinderCloseButton)
			SkinNextPrevButton(SpellBinderSlideButton)
		end
	end
end)