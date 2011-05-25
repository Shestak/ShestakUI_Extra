﻿local T, C, L = unpack(ShestakUI)
if C.extra_skins.minimap_buttons ~= true or C.minimap.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Skin addons icons on minimap
----------------------------------------------------------------------------------------
local buttons = {
	"MiniMapBattlefieldFrame",
	"MiniMapLFGFrame",
	"MiniMapTrackingButton",
	"MiniMapMailFrame",
	"HelpOpenTicketButton"
}

local function SkinButton(f)
	if f:GetObjectType() ~= "Button" then return end

	for i, buttons in pairs(buttons) do
		if f:GetName():match(buttons) then return end
	end

	f:SetPushedTexture(nil)
	f:SetHighlightTexture(nil)
	f:SetDisabledTexture(nil)
	f:Size(24, 24)

	for i = 1, f:GetNumRegions() do
		local region = select(i, f:GetRegions())
		if region:GetObjectType() == "Texture" then
			local tex = region:GetTexture()

			if tex:find("Border") or tex:find("Background") then
				region:SetTexture(nil)
			else
				region:ClearAllPoints()
				region:Point("TOPLEFT", f, "TOPLEFT", 2, -2)
				region:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
				region:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			end
		end
	end

	f:SetTemplate("ClassColor")
end

local x = CreateFrame("Frame")
x:RegisterEvent("PLAYER_LOGIN")
x:SetScript("OnEvent", function(self, event)

	for i = 1, Minimap:GetNumChildren() do
		SkinButton(select(i, Minimap:GetChildren()))
	end

	self = nil
end)