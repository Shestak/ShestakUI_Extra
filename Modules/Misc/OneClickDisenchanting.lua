﻿local T, C, L = unpack(ShestakUI)
if C.extra_general.disenchanting ~= true then return end

----------------------------------------------------------------------------------------
--	One-click Milling, Prospecting and Disenchanting(Molinari by p3lim)
----------------------------------------------------------------------------------------
local button = CreateFrame("Button", "OneClickMPD", UIParent, "SecureActionButtonTemplate, AutoCastShineTemplate")
button:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
button:RegisterEvent("PLAYER_LOGIN")

local function ScanTooltip(self, spells)
	for index = 1, self:NumLines() do
		local info = spells[_G["GameTooltipTextLeft" .. index]:GetText()]
		if info then
			return unpack(info)
		end
	end
end

function button:PLAYER_LOGIN()
	local spells, disenchanter, rogue = {}
	local ARMOR_TYPE = T.client == "ruRU" and "Доспехи" or ARMOR

	if IsSpellKnown(51005) then
		spells[ITEM_MILLABLE] = {GetSpellInfo(51005), 0.5, 1, 0.5}
	end

	if IsSpellKnown(31252) then
		spells[ITEM_PROSPECTABLE] = {GetSpellInfo(31252), 1, 0.33, 0.33}
	end

	if IsSpellKnown(13262) then
		disenchanter = true
	end

	if IsSpellKnown(1804) then
		rogue = ITEM_MIN_SKILL:gsub("%%s", (T.client == "ruRU" and "Взлом замков" or GetSpellInfo(1809))):gsub("%%d", "%(.*%)")
	end

	GameTooltip:HookScript("OnTooltipSetItem", function(self)
		local item, link = self:GetItem()
		if item and not InCombatLockdown() and IsAltKeyDown() and not (AuctionFrame and AuctionFrame:IsShown()) then
			local spell, r, g, b = ScanTooltip(self, spells)

			if not spell and disenchanter then
				local _, _, itemRarity, _, _, itemType = GetItemInfo(item)
				if not (itemType == ARMOR_TYPE or itemType == ENCHSLOT_WEAPON) or not (itemRarity and (itemRarity > 1 and itemRarity < 5)) then return end
				spell, r, g, b = GetSpellInfo(13262), 0.5, 0.5, 1
			elseif not spell and rogue then
				for index = 1, self:NumLines() do
					if string.match(_G['GameTooltipTextLeft' .. index]:GetText() or '', rogue) then
						spell, r, g, b = GetSpellInfo(1804), 0, 1, 1
					end
				end
			end

			local bag, slot = GetMouseFocus():GetParent(), GetMouseFocus()
			if spell and GetContainerItemLink(bag:GetID(), slot:GetID()) == link then
				button:SetAttribute("macrotext", string.format("/cast %s\n/use %s %s", spell, bag:GetID(), slot:GetID()))
				button:SetAllPoints(slot)
				button:Show()
				AutoCastShine_AutoCastStart(button, r, g, b)
			end
		end
	end)

	self:SetFrameStrata("TOOLTIP")
	self:SetAttribute("*type1", "macro")
	self:SetScript("OnLeave", self.MODIFIER_STATE_CHANGED)

	self:RegisterEvent("MODIFIER_STATE_CHANGED")
	self:Hide()

	for _, sparks in pairs(self.sparkles) do
		sparks:SetHeight(sparks:GetHeight() * 3)
		sparks:SetWidth(sparks:GetWidth() * 3)
	end
end

function button:MODIFIER_STATE_CHANGED(key)
	if not self:IsShown() and not key and key ~= "LALT" and key ~= "RALT" then return end

	if InCombatLockdown() then
		self:SetAlpha(0)
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
	else
		self:ClearAllPoints()
		self:SetAlpha(1)
		self:Hide()
		AutoCastShine_AutoCastStop(self)
	end
end

function button:PLAYER_REGEN_ENABLED()
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:MODIFIER_STATE_CHANGED()
end