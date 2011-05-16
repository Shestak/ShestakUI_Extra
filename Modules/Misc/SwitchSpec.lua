local T, C, L = unpack(ShestakUI)
if C.extra_general.switch_spec ~= true then return end

----------------------------------------------------------------------------------------
--	Switch spec panel(by Epic)
----------------------------------------------------------------------------------------
local cp = "|cff319f1b" -- +
local cm = "|cff9a1212" -- -
local dr, dg, db = unpack({ 0.4, 0.4, 0.4 })
local panelcolor = ("|cff%.2x%.2x%.2x"):format(dr * 255, dg * 255, db * 255)

-- Functions
local function enableDPS()
	DisableAddOn("ShestakUI_Heal")
	EnableAddOn("ShestakUI_DPS")
	ReloadUI()
end

local function enableHeal()
	DisableAddOn("ShestakUI_DPS")
	EnableAddOn("ShestakUI_Heal")
	ReloadUI()
end

-- Spec
local spec = CreateFrame("Button", "Spec", UIParent)
spec:CreatePanel("Transparent", 125, 20, unpack(C.extra_position.switch_spec))
spec:EnableMouse(true)
spec:SetMovable(true)
spec:SetClampedToScreen(true)
spec:RegisterForDrag("LeftButton")
spec:SetScript("OnDragStart", function(self) self:StartMoving() end)
spec:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)

spec.t = spec:CreateFontString(spec, "OVERLAY")
spec.t:SetPoint("CENTER")
spec.t:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)

local specfunc = CreateFrame("Frame")	
specfunc:RegisterEvent("PLAYER_TALENT_UPDATE")
specfunc:RegisterEvent("PLAYER_ENTERING_WORLD")
specfunc:SetScript("OnEvent", function(self)
	if not GetPrimaryTalentTree() then
		spec.t:SetText(NO.." "..TALENTS)
		return
	end

	local tree = {}

	for i = 1, 3 do
		tree[i] = select(5, GetTalentTabInfo(i))
	end

	local name = select(2, GetTalentTabInfo(GetPrimaryTalentTree()))

	spec.t:SetText(name..": "..panelcolor..tree[1].."/"..tree[2].."/"..tree[3])
	spec:SetScript("OnEnter", function(self)
		if T.level > 29 then
			spec.t:SetText(L_EXTRA_SWITCH_SPEC)
		end
		self:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
	end)
	spec:SetScript("OnLeave", function(self)
		spec.t:SetText(name..": "..panelcolor..tree[1].."/"..tree[2].."/"..tree[3])
		self:SetBackdropBorderColor(unpack(C.media.border_color))
	end)
end)
spec:SetScript("OnClick", function(self) 
	if GetActiveTalentGroup() == 1 then
		SetActiveTalentGroup(2)
	else
		SetActiveTalentGroup(1)
	end
end)

-- Toggle Button
local toggle = CreateFrame("Button", "Toggle", Spec)
toggle:CreatePanel("Transparent", 20, 20, "TOPLEFT", Spec, "TOPRIGHT", 3, 0)

toggle.t = toggle:CreateFontString(nil, "OVERLAY")
toggle.t:SetPoint("CENTER", 1, 0)
toggle.t:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
toggle.t:SetText(cp.."+|r")
toggle:SetScript("OnEnter", T.SetModifiedBackdrop)
toggle:SetScript("OnLeave", T.SetOriginalBackdrop)
toggle:SetScript("OnClick", function(self) 
	if DPS:IsShown() then	
		DPS:Hide()
		toggle.t:SetText(cp.."+|r")
	else
		DPS:Show()
		toggle.t:SetText(cm.."-|r")
	end
end)

-- DPS layout
local dps = CreateFrame("Button", "DPS", Toggle)
dps:CreatePanel("Transparent", 28, 19, "BOTTOMRIGHT", Toggle, "TOPRIGHT", 0, 3)
dps:Hide()		
dps.t = dps:CreateFontString(nil, "OVERLAY")
dps.t:SetPoint("CENTER", 1, 0)
dps.t:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
dps.t:SetText("DPS")
dps:SetScript("OnEnter", T.SetModifiedBackdrop)
dps:SetScript("OnLeave", T.SetOriginalBackdrop)
dps:SetScript("OnClick", function(self) enableDPS() end)

-- Heal layout
local heal = CreateFrame("Button", "HEAL", DPS)
heal:CreatePanel("Transparent", 29, 19, "RIGHT", DPS, "LEFT", -3, 0)
heal.t = heal:CreateFontString(nil, "OVERLAY")
heal.t:SetPoint("CENTER", 1, 0)
heal.t:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
heal.t:SetText("HEAL")
heal:SetScript("OnEnter", T.SetModifiedBackdrop)
heal:SetScript("OnLeave", T.SetOriginalBackdrop)
heal:SetScript("OnClick", function(self) enableHeal() end)
	
-- Gear switching
local gearSets = CreateFrame("Frame", "gearSets", HEAL)	
for i = 1, 10 do
	gearSets[i] = CreateFrame("Button", "gearSets"..i, HEAL)
	gearSets[i]:CreatePanel("Transparent", 19, 19, "CENTER", HEAL, "CENTER", 0, 0)

	if i == 1 then
		gearSets[i]:Point("BOTTOMRIGHT", HEAL, "BOTTOMLEFT", -3, 0)
	else
		gearSets[i]:SetPoint("BOTTOMRIGHT", gearSets[i-1], "BOTTOMLEFT", -3, 0)
	end

	gearSets[i].texture = gearSets[i]:CreateTexture(nil, "BORDER")
	gearSets[i].texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	gearSets[i].texture:SetPoint("TOPLEFT", gearSets[i] ,"TOPLEFT", 2, -2)
	gearSets[i].texture:SetPoint("BOTTOMRIGHT", gearSets[i] ,"BOTTOMRIGHT", -2, 2)
	gearSets[i].texture:SetTexture(select(2, GetEquipmentSetInfo(i)))

	gearSets[i]:Hide()

	gearSets[i]:RegisterEvent("PLAYER_ENTERING_WORLD")
	gearSets[i]:RegisterEvent("EQUIPMENT_SETS_CHANGED")
	gearSets[i]:SetScript("OnEvent", function(self, event)
		local points, pt = 0, GetNumEquipmentSets()
		local frames = {
			gearSets[1]:IsShown(), gearSets[2]:IsShown(), gearSets[3]:IsShown(), gearSets[4]:IsShown(),	gearSets[5]:IsShown(),
			gearSets[6]:IsShown(), gearSets[7]:IsShown(), gearSets[8]:IsShown(), gearSets[9]:IsShown(), gearSets[10]:IsShown()
		}

		if pt > points then
			for i = points + 1, pt do
				gearSets[i]:Show()
			end
		end

		if frames[pt+1] == 1 then
			gearSets[pt+1]:Hide()
		end

		gearSets[i].texture = gearSets[i]:CreateTexture(nil, "BORDER")
		gearSets[i].texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		gearSets[i].texture:SetPoint("TOPLEFT", gearSets[i] ,"TOPLEFT", 2, -2)
		gearSets[i].texture:SetPoint("BOTTOMRIGHT", gearSets[i] ,"BOTTOMRIGHT", -2, 2)
		gearSets[i].texture:SetTexture(select(2, GetEquipmentSetInfo(i)))

		gearSets[i]:SetScript("OnEnter", T.SetModifiedBackdrop)
		gearSets[i]:SetScript("OnLeave", T.SetOriginalBackdrop)
		gearSets[i]:SetScript("OnClick", function(self) UseEquipmentSet(GetEquipmentSetInfo(i)) end)
	end)
end