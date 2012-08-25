local T, C, L = unpack(ShestakUI)
if C.extra_skins.dominos ~= true then return end

----------------------------------------------------------------------------------------
--	Dominos skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("Dominos") then return end

	local function CreateBorder(self)
		local name = self:GetName()
		if name:match("MultiCast") or name:match("ExtraActionButton") then return end
		local action = self.action
		local button = self
		local icon = _G[name.."Icon"]
		local count = _G[name.."Count"]
		local flash = _G[name.."Flash"]
		local hotkey = _G[name.."HotKey"]
		local border = _G[name.."Border"]
		local normal = _G[name.."NormalTexture"]

		flash:SetTexture("")
		button:SetNormalTexture("")

		if border then
			border:Hide()
			border = function() return end
		end

		if count then
			count:ClearAllPoints()
			count:Point("BOTTOMRIGHT", 0, 2)
			count:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
			count:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
		end

		if hotkey then
			hotkey:ClearAllPoints()
			hotkey:Point("TOPRIGHT", 0, 0)
			hotkey:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
			hotkey:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
			hotkey:Width(button:GetWidth() - 1)
			hotkey.ClearAllPoints = T.dummy
			hotkey.SetPoint = T.dummy
		end

		if not _G[name.."Panel"] then
			local panel = CreateFrame("Frame", name.."Panel", self)
			panel:CreatePanel("Transparent", button:GetWidth(), button:GetHeight(), "CENTER", self, "CENTER", 0, 0)

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:SetPoint("TOPLEFT", button, 2, -2)
			icon:SetPoint("BOTTOMRIGHT", button, -2, 2)
		end

		if normal then
			normal:ClearAllPoints()
			normal:SetPoint("TOPLEFT")
			normal:SetPoint("BOTTOMRIGHT")
		end
	end

	do
		for i = 1, 60 do
			_G["DominosActionButton"..i]:StyleButton()
		end

		for i = 1, 12 do
			_G["ActionButton"..i]:StyleButton()
			_G["MultiBarBottomLeftButton"..i]:StyleButton()
			_G["MultiBarBottomRightButton"..i]:StyleButton()
			_G["MultiBarLeftButton"..i]:StyleButton()
			_G["MultiBarRightButton"..i]:StyleButton()
		end

		for i = 1, 10 do
			_G["ShapeshiftButton"..i]:StyleButton()
			_G["PetActionButton"..i]:StyleButton()
		end
	end

	hooksecurefunc("ActionButton_Update", CreateBorder)
end)