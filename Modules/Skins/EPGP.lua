local T, C, L = unpack(ShestakUI)
if C.extra_skins.epgp ~= true then return end

----------------------------------------------------------------------------------------
--	EPGP skin
----------------------------------------------------------------------------------------
local EPGPSkin = CreateFrame("Frame")
EPGPSkin:RegisterEvent("PLAYER_LOGIN")
EPGPSkin:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("epgp") then return end
	EPGPFrame:StripTextures()
	EPGPFrame:CreateBackdrop("Transparent")
	EPGPFrame.backdrop:Point("TOPLEFT", 10, 0)
	EPGPFrame.backdrop:Point("BOTTOMRIGHT", -35, 70)

	EPGPScrollFrameScrollBarBorder:StripTextures()

	for i = 1, EPGPFrame:GetNumChildren() do
		local child = select(i, EPGPFrame:GetChildren())
		if child.GetPushedTexture and child:GetPushedTexture() and not child:GetName() then
			T.SkinCloseButton(child, EPGPFrame.backdrop)
		end
	end

	EPGPSideFrame:StripTextures()
	EPGPSideFrame:SetTemplate("Transparent")

	T.SkinDropDownBox(EPGPSideFrameEPControlDropDown, 180)
	T.SkinDropDownBox(EPGPSideFrameGPControlDropDown, 180)

	T.SkinEditBox(EPGPSideFrameEPControlEditBox)
	T.SkinEditBox(EPGPSideFrameGPControlEditBox)

	for i = 1, EPGPSideFrame:GetNumChildren() do
		local child = select(i, EPGPSideFrame:GetChildren())
		if child.GetPushedTexture and child:GetPushedTexture() and not child:GetName() then
			T.SkinCloseButton(child)
		end
	end

	EPGPLogFrame:StripTextures()
	EPGPLogFrame:SetTemplate("Transparent")

	for i = 1, EPGPLogFrame:GetNumChildren() do
		local child = select(i, EPGPLogFrame:GetChildren())
		if child.GetPushedTexture and child:GetPushedTexture() and not child:GetName() and not child:GetText() then
			T.SkinCloseButton(child)
		elseif child:GetObjectType() == "Button" and child:GetText() then
			child:SkinButton()
		end
	end
end)