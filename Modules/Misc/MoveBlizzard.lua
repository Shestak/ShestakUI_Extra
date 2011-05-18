local T, C, L = unpack(ShestakUI)
if C.extra_general.move_blizzard ~= true then return end

----------------------------------------------------------------------------------------
--	Move Blizzard frames
----------------------------------------------------------------------------------------
for i, v in pairs({
	"CharacterFrame",
	"PlayerTalentFrameHeaderFrame",
	"SpellBookFrame",
	"PVPFrame",
	"GuildFrame",
	"AchievementFrameHeader",
	"TaxiFrame",
	"QuestFrame",
	"QuestLogFrame",
	"QuestLogDetailFrame",
	"MerchantFrame",
	"TradeFrame",
	"FriendsFrame",
	"CinematicFrame",
	"TabardFrame",
	"PVPBannerFrame",
	"GuildRegistrarFrame",
	"ArenaRegistrarFrame",
	"PetitionFrame",
	"HelpFrame",
	"GossipFrame",
	"MailFrame",
	"BattlefieldFrame",
	"PetStableFrame",
	"WorldStateScoreFrame",
	"DressUpFrame",
	"MinigameFrame",
	"LFGParentFrame",
	"LFDParentFrame",
	"LFRParentFrame",
	"ArenaFrame",
	"ChatConfigFrame",
	"PVPParentFrame",
	"GameMenuFrame",
	"InterfaceOptionsFrame",
	"VideoOptionsFrame",
	"aLoadFrame",
	"EncounterJournal",
})
do
	if _G[v] then
		_G[v]:EnableMouse(true)
		_G[v]:SetMovable(true)
		_G[v]:SetClampedToScreen(true)
		_G[v]:RegisterForDrag("LeftButton")
		_G[v]:SetScript("OnDragStart", function(self) self:StartMoving() end)
		_G[v]:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	end
end