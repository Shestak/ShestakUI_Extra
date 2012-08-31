﻿local T, C, L, _ = unpack(ShestakUI)
if C.extra_general.color_picker ~= true then return end

----------------------------------------------------------------------------------------
--	ColorPickerPlus(by Jaslm)
----------------------------------------------------------------------------------------
local initialized = nil
local colorBuffer = {}
local editingText

local function UpdateAlphaText()
	local a = OpacitySliderFrame:GetValue()
	a = a * 100
	a = math.floor(a + 0.05)
	ColorPPBoxA:SetText(string.format("%d", a))
end

local function UpdateAlpha(tbox)
	local a = tbox:GetNumber()
	if a > 100 then
		a = 100
		ColorPPBoxA:SetText(string.format("%d", a))
	end
	a = a / 100
	editingText = true
	OpacitySliderFrame:SetValue(a)
	editingText = nil
end

local function UpdateColorTexts(r, g, b)
	if not r then r, g, b = ColorPickerFrame:GetColorRGB() end
	r = r * 255
	g = g * 255
	b = b * 255
	ColorPPBoxR:SetText(string.format("%d", r))
	ColorPPBoxG:SetText(string.format("%d", g))
	ColorPPBoxB:SetText(string.format("%d", b))
	ColorPPBoxH:SetText(string.format("%.2x", r)..string.format("%.2x", g)..string.format("%.2x", b))
end

local function UpdateColor(tbox)
	local r, g, b = ColorPickerFrame:GetColorRGB()
	local id = tbox:GetID()

	if id == 1 then
		r = string.format("%d", tbox:GetNumber())
		if not r then r = 0 end
		r = r / 255
	elseif id == 2 then
		g = string.format("%d", tbox:GetNumber())
		if not g then g = 0 end
		g = g / 255
	elseif id == 3 then
		b = string.format("%d", tbox:GetNumber())
		if not b then b = 0 end
		b = b / 255
	elseif id == 4 then
		-- hex values
		if tbox:GetNumLetters() == 6 then
			local rgb = tbox:GetText()
			r, g, b = tonumber("0x"..strsub(rgb, 0, 2)), tonumber("0x"..strsub(rgb, 3, 4)), tonumber("0x"..strsub(rgb, 5, 6))
			if not r then r = 0 else r = r / 255 end
			if not g then g = 0 else g = g / 255 end
			if not b then b = 0 else b = b / 255 end
		else
			return
		end
	end

	-- This takes care of updating the hex entry when changing rgb fields and vice versa
	UpdateColorTexts(r, g, b)

	editingText = true
	ColorPickerFrame:SetColorRGB(r, g, b)
	ColorSwatch:SetTexture(r, g, b)
	editingText = nil
end

local load = CreateFrame("Frame")
load:RegisterEvent("PLAYER_ENTERING_WORLD")
load:SetScript("OnEvent", function(self, event)
	self:UnregisterAllEvents()

	if IsAddOnLoaded("ColorPickerPlus") then return	end

	ColorPickerFrame:HookScript("OnShow", function(self)
		-- Get color that will be replaced
		local r, g, b = ColorPickerFrame:GetColorRGB()
		ColorPPOldColorSwatch:SetTexture(r, g, b)

		-- Show/hide the alpha box
		if ColorPickerFrame.hasOpacity then
			ColorPPBoxA:Show()
			ColorPPBoxLabelA:Show()
			ColorPPBoxH:SetScript("OnTabPressed", function(self) ColorPPBoxA:SetFocus() end)
			UpdateAlphaText()
		else
			ColorPPBoxA:Hide()
			ColorPPBoxLabelA:Hide()
			ColorPPBoxH:SetScript("OnTabPressed", function(self) ColorPPBoxR:SetFocus() end)
		end
	end)

	ColorPickerFrame:HookScript("OnColorSelect", function(self, r, g, b)
		ColorSwatch:SetTexture(r, g, b)
		if not editingText then
			UpdateColorTexts(r, g, b)
		end
	end)

	ColorPickerOkayButton:HookScript("OnClick", function()
		collectgarbage("collect")
	end)

	OpacitySliderFrame:HookScript("OnValueChanged", function(self)
		if not editingText then
			UpdateAlphaText()
		end
	end)

	-- Make the Color Picker dialog a bit taller, to make room for edit boxes
	ColorPickerFrame:Height(ColorPickerFrame:GetHeight() + 40)

	-- Move the Color Swatch
	ColorSwatch:ClearAllPoints()
	ColorSwatch:Point("TOPLEFT", ColorPickerFrame, "TOPLEFT", 230, -45)

	-- Add Color Swatch for original color
	local t = ColorPickerFrame:CreateTexture("ColorPPOldColorSwatch")
	local w, h = ColorSwatch:GetSize()
	t:Size(w * 0.75, h * 0.75)
	t:SetTexture(0, 0, 0)

	-- OldColorSwatch to appear beneath ColorSwatch
	t:SetDrawLayer("BORDER")
	t:Point("BOTTOMLEFT", "ColorSwatch", "TOPRIGHT", -(w / 2), -(h / 3))

	-- Add Color Swatch for the copied color
	t = ColorPickerFrame:CreateTexture("ColorPPCopyColorSwatch")
	t:SetSize(w, h)
	t:SetTexture(0, 0, 0)
	t:Hide()

	-- Add copy button to the ColorPickerFrame
	local b = CreateFrame("Button", "ColorPPCopy", ColorPickerFrame, "UIPanelButtonTemplate")
	b:SkinButton()
	b:SetText(CALENDAR_COPY_EVENT)
	b:Width(85)
	b:Height(22)
	b:SetPoint("TOPLEFT", "ColorSwatch", "BOTTOMLEFT", -15, -5)

	-- Copy color into buffer on button click
	b:SetScript("OnClick", function(self)
		-- Copy current dialog colors into buffer
		colorBuffer.r, colorBuffer.g, colorBuffer.b = ColorPickerFrame:GetColorRGB()

		-- Enable Paste button and display copied color into swatch
		ColorPPPaste:Enable()
		ColorPPCopyColorSwatch:SetTexture(colorBuffer.r, colorBuffer.g, colorBuffer.b)
		ColorPPCopyColorSwatch:Show()

		if ColorPickerFrame.hasOpacity then
			colorBuffer.a = OpacitySliderFrame:GetValue()
		else
			colorBuffer.a = nil
		end
	end)

	-- Paste button
	b = CreateFrame("Button", "ColorPPPaste", ColorPickerFrame, "UIPanelButtonTemplate")
	b:SetText(CALENDAR_PASTE_EVENT)
	b:SkinButton()
	b:Width(85)
	b:Height(22)
	b:Point("TOPLEFT", "ColorPPCopy", "BOTTOMLEFT", 0, -7)
	b:Disable() -- Enable when something has been copied

	-- Paste color on button click, updating frame components
	b:SetScript("OnClick", function(self)
		ColorPickerFrame:SetColorRGB(colorBuffer.r, colorBuffer.g, colorBuffer.b)
		ColorSwatch:SetTexture(colorBuffer.r, colorBuffer.g, colorBuffer.b)
		if ColorPickerFrame.hasOpacity then
			if colorBuffer.a then -- Color copied had an alpha value
				OpacitySliderFrame:SetValue(colorBuffer.a)
			end
		end
	end)

	-- ClassColor button
	b = CreateFrame("Button", "ColorPPClass", ColorPickerFrame, "UIPanelButtonTemplate")
	b:SkinButton()
	b:SetText("C")
	b:Width(18)
	b:Height(22)
	b:Point("TOPRIGHT", "ColorPPPaste", "BOTTOMRIGHT", 0, -7)

	b:SetScript("OnClick", function()
		local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[T.class]
		ColorPickerFrame:SetColorRGB(color.r, color.g, color.b)
		ColorSwatch:SetTexture(color.r, color.g, color.b)
		if ColorPickerFrame.hasOpacity then
			OpacitySliderFrame:SetValue(0)
		end
	end)

	-- Locate Color Swatch for copy color
	ColorPPCopyColorSwatch:SetPoint("LEFT", "ColorSwatch", "LEFT")
	ColorPPCopyColorSwatch:Point("TOP", "ColorPPPaste", "BOTTOM", 0, -5)

	-- Move the Opacity Slider Frame to align with bottom of Copy ColorSwatch
	OpacitySliderFrame:ClearAllPoints()
	OpacitySliderFrame:Point("BOTTOM", "ColorPPCopyColorSwatch", "BOTTOM", 0, 23)
	OpacitySliderFrame:Point("RIGHT", "ColorPickerFrame", "RIGHT", -35, 18)

	-- Set up edit box frames and interior label and text areas
	local boxes = {"R", "G", "B", "H", "A"}
	for i = 1, table.getn(boxes) do

		local rgb = boxes[i]
		local box = CreateFrame("EditBox", "ColorPPBox"..rgb, ColorPickerFrame, "InputBoxTemplate")
		T.SkinEditBox(box)
		box:SetID(i)
		box:SetFrameStrata("DIALOG")
		box:SetAutoFocus(false)
		box:SetTextInsets(0, 7, 0, 0)
		box:SetJustifyH("RIGHT")
		box:Height(20)

		if i == 4 then
			-- Hex entry box
			box:SetMaxLetters(6)
			box:Width(60)
			box:SetNumeric(false)
		else
			box:SetMaxLetters(3)
			box:Width(40)
			box:SetNumeric(true)
		end
		box:SetPoint("TOP", "ColorPickerWheel", "BOTTOM", 0, -15)

		-- Label
		local label = box:CreateFontString("ColorPPBoxLabel"..rgb, "ARTWORK", "GameFontNormalSmall")
		label:SetTextColor(1, 1, 1)
		label:Point("RIGHT", "ColorPPBox"..rgb, "LEFT", -5, 0)
		if i == 4 then
			label:SetText("#")
		else
			label:SetText(rgb)
		end

		-- Set up scripts to handle event appropriately
		if i == 5 then
			box:SetScript("OnEscapePressed", function(self) self:ClearFocus() UpdateAlphaText() end)
			box:SetScript("OnEnterPressed", function(self) self:ClearFocus() UpdateAlphaText() end)
			box:SetScript("OnTextChanged", function(self) UpdateAlpha(self) end)
		else
			box:SetScript("OnEscapePressed", function(self) self:ClearFocus() UpdateColorTexts() end)
			box:SetScript("OnEnterPressed", function(self) self:ClearFocus() UpdateColorTexts() end)
			box:SetScript("OnTextChanged", function(self) UpdateColor(self) end)
		end

		box:SetScript("OnEditFocusGained", function(self) self:SetCursorPosition(0) self:HighlightText() end)
		box:SetScript("OnEditFocusLost", function(self) self:HighlightText(0, 0) end)
		box:SetScript("OnTextSet", function(self) self:ClearFocus() end)
		box:Show()
	end

	-- Finish up with placement
	ColorPPBoxR:Point("BOTTOMLEFT", "ColorPickerOkayButton", "TOPLEFT", 13, 18)
	ColorPPBoxG:Point("LEFT", "ColorPPBoxR", "RIGHT", 18, 0)
	ColorPPBoxB:Point("LEFT", "ColorPPBoxG", "RIGHT", 18, 0)
	ColorPPBoxA:Point("BOTTOMRIGHT", "ColorPickerCancelButton", "TOPRIGHT", 0, 18)
	ColorPPBoxH:Point("RIGHT", "ColorPPBoxA", "LEFT", -20, 0)

	-- Define the order of tab cursor movement
	ColorPPBoxR:SetScript("OnTabPressed", function(self) ColorPPBoxG:SetFocus() end)
	ColorPPBoxG:SetScript("OnTabPressed", function(self) ColorPPBoxB:SetFocus() end)
	ColorPPBoxB:SetScript("OnTabPressed", function(self) ColorPPBoxH:SetFocus() end)
	ColorPPBoxA:SetScript("OnTabPressed", function(self) ColorPPBoxR:SetFocus() end)

	-- Make the color picker movable
	local mover = CreateFrame("Frame", nil, ColorPickerFrame)
	mover:SetPoint("TOPLEFT", ColorPickerFrame, "TOPLEFT", 0, 0)
	mover:SetPoint("BOTTOMRIGHT", ColorPickerFrame, "TOPRIGHT", 0, -15)
	mover:EnableMouse(true)
	mover:SetScript("OnMouseDown", function() ColorPickerFrame:StartMoving() end)
	mover:SetScript("OnMouseUp", function() ColorPickerFrame:StopMovingOrSizing() end)
	ColorPickerFrame:SetUserPlaced(true)
	ColorPickerFrame:EnableKeyboard(false)
end)