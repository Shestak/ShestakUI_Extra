local T, C, L = unpack(ShestakUI)
if C.extra_skins.recount ~= true then return end

----------------------------------------------------------------------------------------
--	Recount skin
----------------------------------------------------------------------------------------
if not IsAddOnLoaded("Recount") then return end
local Recount = _G.Recount

--[[RecountDB["profiles"][T.name.." - "..GetRealmName()]["Locked"] = true
RecountDB["profiles"][T.name.." - "..GetRealmName()]["Scaling"] = 1
RecountDB["profiles"][T.name.." - "..GetRealmName()]["MainWindow"]["Buttons"]["ReportButton"] = false
RecountDB["profiles"][T.name.." - "..GetRealmName()]["MainWindow"]["Buttons"]["FileButton"] = false
RecountDB["profiles"][T.name.." - "..GetRealmName()]["MainWindow"]["RowHeight"] = 14
RecountDB["profiles"][T.name.." - "..GetRealmName()]["MainWindow"]["RowSpacing"] = 7
RecountDB["profiles"][T.name.." - "..GetRealmName()]["MainWindow"]["ShowScrollbar"] = false
RecountDB["profiles"][T.name.." - "..GetRealmName()]["MainWindow"]["HideTotalBar"] = true
RecountDB["profiles"][T.name.." - "..GetRealmName()]["MainWindow"]["Position"]["x"] = 284
RecountDB["profiles"][T.name.." - "..GetRealmName()]["MainWindow"]["Position"]["y"] = -305
RecountDB["profiles"][T.name.." - "..GetRealmName()]["MainWindow"]["Position"]["w"] = 221
RecountDB["profiles"][T.name.." - "..GetRealmName()]["MainWindow"]["Position"]["h"] = 178
RecountDB["profiles"][T.name.." - "..GetRealmName()]["MainWindowWidth"] = 221
RecountDB["profiles"][T.name.." - "..GetRealmName()]["MainWindowHeight"] = 178
RecountDB["profiles"][T.name.." - "..GetRealmName()]["ClampToScreen"] = true]]

Recount.db.profile.Locked = true
Recount.db.profile.Scaling = 1
Recount.db.profile.MainWindow.Buttons.ReportButton = false
Recount.db.profile.MainWindow.Buttons.FileButton = false
Recount.db.profile.MainWindow.RowHeight = 14
Recount.db.profile.MainWindow.RowSpacing = 7
Recount.db.profile.MainWindow.ShowScrollbar = false
Recount.db.profile.MainWindow.HideTotalBar = true
Recount.db.profile.MainWindow.Position.x = 284
Recount.db.profile.MainWindow.Position.y = -305
Recount.db.profile.MainWindow.Position.w = 221
Recount.db.profile.MainWindow.Position.h = 178
Recount.db.profile.MainWindowWidth = 221
Recount.db.profile.MainWindowHeight = 178
Recount.db.profile.ClampToScreen = true

local function SkinFrame(frame)
	frame.bgMain = CreateFrame("Frame", nil, frame)
	if frame ~= Recount.MainWindow then
		frame.bgMain:SetTemplate("Transparent")
	end
	if frame == Recount.MainWindow then
		frame.Title:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		frame.Title:SetShadowColor(0, 0, 0, C.font.stylization_font_shadow and 1 or 0)
	end
	frame.bgMain:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT")
	frame.bgMain:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
	frame.bgMain:SetPoint("TOP", frame, "TOP", 0, -7)
	frame.bgMain:SetFrameLevel(frame:GetFrameLevel())
	frame.CloseButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -9)
	frame:SetBackdrop(nil)
end

-- Override bar textures
Recount.UpdateBarTextures = function(self)
	for k, v in pairs(Recount.MainWindow.Rows) do
		v.StatusBar:SetStatusBarTexture(C.media.texture)
		v.StatusBar:GetStatusBarTexture():SetHorizTile(false)
		v.StatusBar:GetStatusBarTexture():SetVertTile(false)
		
		v.background = v.StatusBar:CreateTexture("$parentBackground", "BACKGROUND")
		v.background:SetAllPoints(v.StatusBar)
		v.background:SetTexture(C.media.texture)
		v.background:SetVertexColor(0.15, 0.15, 0.15, 0.75)
		
		v.overlay = CreateFrame("Frame", nil, v.StatusBar)
		v.overlay:SetTemplate("Default")
		v.overlay:SetFrameStrata("BACKGROUND")
		v.overlay:SetPoint("TOPLEFT", -2, 2)
		v.overlay:SetPoint("BOTTOMRIGHT", 2, -2)
		
		v.LeftText:ClearAllPoints()
		v.LeftText:SetPoint("LEFT", v.StatusBar, "LEFT", 2, 0)
		v.LeftText:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		v.LeftText:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		
		v.RightText:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		v.RightText:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	end
end
Recount.SetBarTextures = Recount.UpdateBarTextures

-- Fix bar textures as they're created
Recount.SetupBar_ = Recount.SetupBar
Recount.SetupBar = function(self, bar)
	self:SetupBar_(bar)
	bar.StatusBar:SetStatusBarTexture(C.media.texture)
end

-- Skin frames when they're created
Recount.CreateFrame_ = Recount.CreateFrame
Recount.CreateFrame = function(self, Name, Title, Height, Width, ShowFunc, HideFunc)
	local frame = self:CreateFrame_(Name, Title, Height, Width, ShowFunc, HideFunc)
	SkinFrame(frame)
	return frame
end

-- Skin existing frames
if Recount.MainWindow then SkinFrame(Recount.MainWindow) end
if Recount.ConfigWindow then SkinFrame(Recount.ConfigWindow) end
if Recount.GraphWindow then SkinFrame(Recount.GraphWindow) end
if Recount.DetailWindow then SkinFrame(Recount.DetailWindow) end
if Recount.ResetFrame then SkinFrame(Recount.ResetFrame) end
if _G["Recount_Realtime_!RAID_DAMAGE"] then SkinFrame(_G["Recount_Realtime_!RAID_DAMAGE"].Window) end
if _G["Recount_Realtime_!RAID_HEALING"] then SkinFrame(_G["Recount_Realtime_!RAID_HEALING"].Window) end
if _G["Recount_Realtime_!RAID_HEALINGTAKEN"] then SkinFrame(_G["Recount_Realtime_!RAID_HEALINGTAKEN"].Window) end
if _G["Recount_Realtime_!RAID_DAMAGETAKEN"] then SkinFrame(_G["Recount_Realtime_!RAID_DAMAGETAKEN"].Window) end
if _G["Recount_Realtime_Bandwidth Available_AVAILABLE_BANDWIDTH"] then SkinFrame(_G["Recount_Realtime_Bandwidth Available_AVAILABLE_BANDWIDTH"].Window) end
if _G["Recount_Realtime_FPS_FPS"] then SkinFrame(_G["Recount_Realtime_FPS_FPS"].Window) end
if _G["Recount_Realtime_Latency_LAG"] then SkinFrame(_G["Recount_Realtime_Latency_LAG"].Window) end
if _G["Recount_Realtime_Downstream Traffic_DOWN_TRAFFIC"] then SkinFrame(_G["Recount_Realtime_Downstream Traffic_DOWN_TRAFFIC"].Window) end
if _G["Recount_Realtime_Upstream Traffic_UP_TRAFFIC"] then SkinFrame(_G["Recount_Realtime_Upstream Traffic_UP_TRAFFIC"].Window) end

-- Update Textures
Recount:UpdateBarTextures()