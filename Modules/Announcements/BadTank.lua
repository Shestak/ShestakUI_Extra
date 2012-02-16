local T, C, L = unpack(ShestakUI)
if C.extra_announce.bad_tank ~= true then return end

----------------------------------------------------------------------------------------
--	Announce taunt from not tanks(BadGroup by Rainrider)
----------------------------------------------------------------------------------------
local redColor = "|cffff0000"
local greenColor = "|cff00ff00"
local yellowColor = "|cffffff00"

local defaults = {
	["socialOutput"] = false,
	["customTanks"] = {}
}

local spellList = {
	-- Warrior
	355,	-- Taunt
	1161,	-- Challenging Shout
	694,	-- Mocking Blow
	-- Paladin
	31789,	-- Rghteous Defense
	62124,	-- Hand of Reckoning
	-- Death Knight
	49576,	-- Death Grip
	56222,	-- Dark Command
	-- Druid
	6795,	-- Growl
	5209,	-- Challenging Roar
	-- Hunter
	20736,	-- Distracting Shot
	-- Hunter's pet
	--2649,	-- Growl (Stupid hunters will never turn off this ability)
	-- Warlock's pets
	33698,	-- Anguish 
	3716,	-- Torment
	17735,	-- Suffering
}

local badAuras = {
	["DEATHKNIGHT"] = 48263,	-- Blood Presence
	["PALADIN"] = 25780,		-- Righteous Fury
	["WARRIOR"] = 71,			-- Defensive Stance
}

local numMembers = 0
local groupType = ""

local raidIcons = {}
local rtmask

local metaSV = {
	__tostring = function(tbl)
		local str = ""

		for k, v in pairs(tbl) do
			str = str..greenColor..k..":|r "..tostring(v).." "
		end
		return str
	end
}

local BadGroup = CreateFrame("Frame", "BadGroup", UIParent)
BadGroup:SetScript("OnEvent", function(self, event, ...) self[event](self, event, ...) end)
BadGroup:RegisterEvent("ADDON_LOADED")

function BadGroup:ADDON_LOADED(event, name)
	if name == "ShestakUI_Extra" then
		-- Set slash commands
		SLASH_BadGroup1 = "/bgr"
		SLASH_BadGroup2 = "/bgrp"
		SLASH_BadGroup3 = "/badgroup"
		SlashCmdList.BadGroup = self.Command

		-- Set SavedVariables
		ExtraTanksDB = ExtraTanksDB or defaults
		ExtraTanksDB = setmetatable(ExtraTanksDB, metaSV)
		ExtraTanksDB.customTanks = setmetatable(ExtraTanksDB.customTanks, metaSV)

		-- Register events
		self:RegisterEvent("PLAYER_ENTERING_WORLD")
		self:RegisterEvent("PARTY_MEMBERS_CHANGED")
		self:RegisterEvent("RAID_ROSTER_UPDATE")
	end
end

function BadGroup:PARTY_MEMBERS_CHANGED()
	self:CountGroupMembers()
end

function BadGroup:RAID_ROSTER_UPDATE()
	self:CountGroupMembers()
end

function BadGroup:PLAYER_ENTERING_WORLD()
	local _, locType = GetInstanceInfo()

	if locType ~= "raid" or locType ~= "party" then
		if self:IsEventRegistered("COMBAT_LOG_EVENT_UNFILTERED") then
			self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
	end

	if locType == "raid" or locType == "party" then
		if not self:IsEventRegistered("COMBAT_LOG_EVENT_UNFILTERED") then
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
	end

	self:CreateRaidIcons()
	self:CountGroupMembers()
end

function BadGroup:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
	local _, eventType, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, spellid, spellname = ...

	if eventType == "SPELL_CAST_SUCCESS" and not self:IsOutsider(srcFlags) and self:CheckSpellid(spellid) and not self:IsTank(srcName) then
		return self:ChatOutput(srcName, srcGUID, srcRaidFlags, dstName, dstRaidFlags, spellid)
	end
end

function BadGroup:CountGroupMembers(event)
	numMembers = GetNumRaidMembers()
	if numMembers > 0 then
		groupType = "raid"
		return
	end

	numMembers = GetNumPartyMembers()
	if numMembers > 0 then
		groupType = "party"
		return
	end

	numMembers = 0
	groupType = ""
end

function BadGroup:IsOutsider(srcFlags)
	return bit.band(srcFlags, COMBATLOG_OBJECT_AFFILIATION_MASK) >= COMBATLOG_OBJECT_AFFILIATION_OUTSIDER
end

function BadGroup:IsTank(srcName)
	for i, tankName in ipairs(ExtraTanksDB.customTanks) do
		if srcName == tankName then
			return true
		end
	end

	if (groupType == "party" and UnitGroupRolesAssigned(srcName) == "TANK") or (groupType == "raid" and GetPartyAssignment("MAINTANK", srcName, exactMatch)) then
		return true
	end
end

function BadGroup:CheckSpellid(spellid)
	for i, v in ipairs(spellList) do
		if v == spellid then
			return true
		end
	end
end

function BadGroup:GetPetOwner(srcGUID)
	local petGUID

	if numMembers > 0 then
		for i = 1, numMembers do
			petGUID = UnitGUID(groupType.."pet"..i)
			if petGUID and petGUID == srcGUID then
				return UnitName(groupType..i)
			end
		end
	end

	petGUID = UnitGUID("pet")
	if petGUID and petGUID == srcGUID then
		return UnitName("player")
	end
end

function BadGroup:ClassColoredName(srcName)
	local _, playerClass = UnitClass(srcName)
	local classColor = RAID_CLASS_COLORS[playerClass]
	return string.format("|cff%02x%02x%02x%s|r", classColor.r * 255, classColor.g * 255, classColor.b * 255, srcName)
end

function BadGroup:CreateRaidIcons()
	rtmask = _G.COMBATLOG_OBJECT_RAIDTARGET_MASK

	for i = 1, #_G.ICON_LIST do
		local iconbit = _G["COMBATLOG_OBJECT_RAIDTARGET"..i]
		local icon = _G["COMBATLOG_ICON_RAIDTARGET"..i]
		raidIcons[iconbit] = {iconString = TEXT_MODE_A_STRING_DEST_ICON:format(iconbit, icon), icon = icon, rt = i,}
	end
end

function BadGroup:GetRaidIcon(flag, social)
	if flag == nil then return "" end

	local icon = raidIcons[bit.band(flag, rtmask)]
	if not icon then return "" end

	if social then
		return ("{rt%d}"):format(icon.rt)
	else
		return icon.iconString
	end
end

function BadGroup:ChatOutput(srcName, srcGUID, srcRaidFlags, dstName, dstRaidFlags, spellid)
	local spellLink = GetSpellLink(spellid)
	local srcRaidIcon = self:GetRaidIcon(srcRaidFlags, ExtraTanksDB.socialOutput)
	local owner = self:GetPetOwner(srcGUID)

	local message
	local prvtMessage

	if not owner then
		message = ("%s used by %s%s"):format(spellLink, srcRaidIcon, srcName)
		prvtMessage = ("%s used by %s%s"):format(spellLink, srcRaidIcon, self:ClassColoredName(srcName))
	else
		message = ("%s used by %s's pet %s"):format(spellLink, owner, srcName)
		prvtMessage = ("%s used by %s's pet %s%s|r"):format(spellLink, self:ClassColoredName(owner), greenColor, srcName)
	end

	if dstName then
		local dstRaidIcon = self:GetRaidIcon(dstRaidFlags, ExtraTanksDB.socialOutput)
		message = ("%s on %s%s"):format(message, dstRaidIcon, dstName)
		prvtMessage = ("%s on %s%s%s|r"):format(prvtMessage, dstRaidIcon, redColor, dstName)
	end

	if ExtraTanksDB.socialOutput and numMembers > 0 then
		SendChatMessage(message, string.upper(groupType))
	else
		self:Print(prvtMessage)
	end
end

function BadGroup:ScanAuras(unitID, groupType)
	local _, playerClass = UnitClass(unitID)
	local auraID = badAuras[playerClass]
	local auraName

	if auraID then
		auraName = GetSpellInfo(auraID)
	else
		return
	end

	if UnitAura(unitID, auraName) == auraName then
		local playerName = UnitName(unitID)
		if ExtraTanksDB.socialOutput and groupType == "raid" or groupType == "party" and not self:IsTank(playerName) then
			SendChatMessage("Non-tank "..playerName.." has "..GetSpellLink(auraID).." on.", groupType == "raid" and "RAID" or "PARTY")
		elseif not self:IsTank(playerName) then
			self:Print("Non-tank "..self:ClassColoredName(playerName).." has "..GetSpellLink(auraID).." on.")
		end
	end
end

function BadGroup:CheckAuras()
	if numMembers > 0 then
		for i = 1, numMembers do
			self:ScanAuras(groupType..i, groupType)
		end
	end

	self:ScanAuras("player", groupType)
	self:Print("Auras check done.")
end

function BadGroup:AddTank(tankName)
	if tankName == UnitName("player") or tankName == UnitName("pet") or UnitPlayerOrPetInParty(tankName) or UnitPlayerOrPetInRaid(tankName) then
		for i, v in ipairs(ExtraTanksDB.customTanks) do
			if v == tankName then
				self:Print(tankName.." is already in the list.")
				return
			end
		end

		table.insert(ExtraTanksDB.customTanks, tankName)
		self:Print("Added tank "..self:ClassColoredName(tankName))
	else
		self:Print("You have to target a group member first.")
	end
end

function BadGroup:RemoveTank(tankName)
	for i, name in ipairs(ExtraTanksDB.customTanks) do
		if tankName == name then
			table.remove(ExtraTanksDB.customTanks, i)
			self:Print("Removed "..tankName.." from the list.")
		end
	end
end

function BadGroup:WipeTanks()
	table.wipe(ExtraTanksDB.customTanks)
	self:Print("All custom tanks removed.")
end

function BadGroup:Print(...)
	local str = tostring(...)
	DEFAULT_CHAT_FRAME:AddMessage("|cff0099CCBadTank:|r "..str)
end

function BadGroup.Command(str, editbox)
	if str == "social" then
		ExtraTanksDB.socialOutput = true
		BadGroup:Print("Output set to "..yellowColor.."social|r.")
	elseif str == "private" then
		ExtraTanksDB.socialOutput = false
		BadGroup:Print("Output set to "..yellowColor.."private|r.")
	elseif str == "status" then 
		BadGroup:Print(ExtraTanksDB)
	elseif str == "add" then
		if not UnitExists("target") then
			BadGroup:Print("You have to target something")
		else
			BadGroup:AddTank(UnitName("target"))
		end
	elseif str == "del" then
		if not UnitExists("target") then
			BadGroup:Print("You have to target something")
		else
			BadGroup:RemoveTank(UnitName("target"))
		end
	elseif str == "wipe" then
		BadGroup:WipeTanks()
	elseif str == "tanks" then
		BadGroup:Print(ExtraTanksDB.customTanks)
	elseif str == "auras" then
		BadGroup:CheckAuras()
	else
		BadGroup:Print(redColor.."Unknown command:|r "..str)
	end
end