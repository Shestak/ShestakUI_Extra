local T, C, L = unpack(ShestakUI)
if C.extra_bar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Extra ActionBar(ExtraBar by Cowmonster)
----------------------------------------------------------------------------------------
local bar = CreateFrame("Frame", "ExtraBarAnchor", UIParent)
bar:CreatePanel("Invisible", 1, 1, "BOTTOM", ActionBarAnchor, "TOP", 0, C.actionbar.button_space)
if C.extra_bar.style == "1*12" then
	bar:Width(C.actionbar.button_size)
	bar:Height((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
elseif C.extra_bar.style == "12*1" then
	bar:Width((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
	bar:Height(C.actionbar.button_size)
elseif C.extra_bar.style == "6*2" then
	bar:Width((C.actionbar.button_size * 6) + (C.actionbar.button_space * 5))
	bar:Height((C.actionbar.button_size * 2) + C.actionbar.button_space)
elseif C.extra_bar.style == "4*3" then
	bar:Width((C.actionbar.button_size * 4) + (C.actionbar.button_space * 3))
	bar:Height((C.actionbar.button_size * 3) + C.actionbar.button_space * 2)
else
	bar:Width((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
	bar:Height(C.actionbar.button_size)
end
bar:SetFrameStrata("LOW")
tinsert(T.MoverFrames, ExtraBarAnchor)

for i = 13, 24 do
	local f = CreateFrame("CheckButton", "ExtraBarButton"..(i-12), UIParent, "ActionBarButtonTemplate")

	f:Size(C.actionbar.button_size, C.actionbar.button_size)
	f:SetAttribute("action", i)
	if C.extra_bar.show_grid == true then
		f:SetAttribute("showgrid", 1)
	end
	f:SetID(i)

	f:ClearAllPoints()
	if C.extra_bar.style == "1*12" then
		if i == 13 then
			f:Point("TOPLEFT", ExtraBarAnchor, "TOPLEFT", 0, 0)
		else
			f:Point("TOP", "ExtraBarButton"..i-13, "BOTTOM", 0, -C.actionbar.button_space)
		end
	elseif C.extra_bar.style == "12*1" then
		if i == 13 then
			f:Point("TOPLEFT", ExtraBarAnchor, "TOPLEFT", 0, 0)
		else
			f:Point("LEFT", "ExtraBarButton"..i-13, "RIGHT", C.actionbar.button_space, 0)
		end
	elseif C.extra_bar.style == "6*2" then
		if i == 13 then
			f:Point("TOPLEFT", ExtraBarAnchor, "TOPLEFT", 0, 0)
		elseif i == 19 then
			f:Point("TOPLEFT", "ExtraBarButton1", "BOTTOMLEFT", 0, -C.actionbar.button_space)
		else
			f:Point("LEFT", "ExtraBarButton"..i-13, "RIGHT", C.actionbar.button_space, 0)
		end
	elseif C.extra_bar.style == "4*3" then
		if i == 13 then
			f:Point("TOPLEFT", ExtraBarAnchor, "TOPLEFT", 0, 0)
		elseif i == 17 then
			f:Point("TOPLEFT", "ExtraBarButton1", "BOTTOMLEFT", 0, -C.actionbar.button_space)
		elseif i == 21 then
			f:Point("TOPLEFT", "ExtraBarButton5", "BOTTOMLEFT", 0, -C.actionbar.button_space)
		else
			f:Point("LEFT", "ExtraBarButton"..i-13, "RIGHT", C.actionbar.button_space, 0)
		end
	else
		if i == 13 then
			f:Point("TOPLEFT", ExtraBarAnchor, "TOPLEFT", 0, 0)
		else
			f:Point("LEFT", "ExtraBarButton"..i-13, "RIGHT", C.actionbar.button_space, 0)
		end
	end

	f:StyleButton(true)
	f:Show()
end

BINDING_HEADER_EXTRABAR_HEADER = "Extra Bar"