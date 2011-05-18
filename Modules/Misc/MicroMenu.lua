local T, C, L = unpack(ShestakUI)
if C.extra_general.micro_menu ~= true then return end

----------------------------------------------------------------------------------------
--	Micro menu(by Elv22)
----------------------------------------------------------------------------------------
local microbuttons = {
	"CharacterMicroButton",
	"SpellbookMicroButton",
	"TalentMicroButton",
	"QuestLogMicroButton",
	"PVPMicroButton",
	"GuildMicroButton",
	"LFDMicroButton",
	"HelpMicroButton",
	"MainMenuMicroButton",
	"AchievementMicroButton"
}
if T.PTRVersion() then
	tinsert(microbuttons, "EJMicroButton")
	tinsert(microbuttons, "RaidMicroButton")
end

local f = CreateFrame("Frame", "MicroParent", UIParent)
UpdateMicroButtonsParent(f)

for i, button in pairs(microbuttons) do
	local m = _G[button]
	local pushed = m:GetPushedTexture()
	local normal = m:GetNormalTexture()
	local disabled = m:GetDisabledTexture()

	m:SetParent(MicroParent)
	m.SetParent = T.dummy
	_G[button.."Flash"]:SetTexture("")
	m:SetHighlightTexture("")
	m.SetHighlightTexture = T.dummy

	local f = CreateFrame("Frame", nil, m)
	f:SetFrameLevel(1)
	f:SetFrameStrata("BACKGROUND")
	f:Point("BOTTOMLEFT", m, "BOTTOMLEFT", 2, 0)
	f:Point("TOPRIGHT", m, "TOPRIGHT", -2, -28)
	f:SetTemplate("Default", true)
	m.frame = f
	
	pushed:SetTexCoord(0.17, 0.87, 0.5, 0.908)
	pushed:ClearAllPoints()
	pushed:Point("TOPLEFT", m.frame, "TOPLEFT", 2, -2)
	pushed:Point("BOTTOMRIGHT", m.frame, "BOTTOMRIGHT", -2, 2)
	
	normal:SetTexCoord(0.17, 0.87, 0.5, 0.908)
	normal:ClearAllPoints()
	normal:Point("TOPLEFT", m.frame, "TOPLEFT", 2, -2)
	normal:Point("BOTTOMRIGHT", m.frame, "BOTTOMRIGHT", -2, 2)
	
	if disabled then
		disabled:SetTexCoord(0.17, 0.87, 0.5, 0.908)
		disabled:ClearAllPoints()
		disabled:Point("TOPLEFT", m.frame, "TOPLEFT", 2, -2)
		disabled:Point("BOTTOMRIGHT", m.frame, "BOTTOMRIGHT", -2, 2)
	end
end

-- Fix/Create textures for buttons
do
	MicroButtonPortrait:ClearAllPoints()
	MicroButtonPortrait:Point("TOPLEFT", CharacterMicroButton.frame, "TOPLEFT", 2, -2)
	MicroButtonPortrait:Point("BOTTOMRIGHT", CharacterMicroButton.frame, "BOTTOMRIGHT", -2, 2)
	
	GuildMicroButtonTabard:ClearAllPoints()
	GuildMicroButtonTabard:Point("TOP", GuildMicroButton.frame, "TOP", 0, 25)
	GuildMicroButtonTabard.SetPoint = T.dummy
	GuildMicroButtonTabard.ClearAllPoints = T.dummy
end

MicroParent:Point(unpack(C.extra_position.micro_menu))
if T.PTRVersion() then
	MicroParent:Width(((CharacterMicroButton:GetWidth() + 4) * 9) + 12)
else
	MicroParent:Width(((CharacterMicroButton:GetWidth() + 4) * 7) + 2)
end
MicroParent:Height(CharacterMicroButton:GetHeight() - 28)

CharacterMicroButton:ClearAllPoints()
CharacterMicroButton:Point("BOTTOMLEFT", MicroParent, "BOTTOMLEFT", 0,  0)
CharacterMicroButton.SetPoint = T.dummy
CharacterMicroButton.ClearAllPoints = T.dummy