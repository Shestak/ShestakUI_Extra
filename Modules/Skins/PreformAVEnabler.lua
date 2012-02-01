local T, C, L = unpack(ShestakUI)
if C.extra_skins.preform_av ~= true then return end

----------------------------------------------------------------------------------------
--	PreformAVEnabler skin
----------------------------------------------------------------------------------------
local SkinPAV = CreateFrame("Frame")
SkinPAV:RegisterEvent("PLAYER_ENTERING_WORLD")
SkinPAV:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("PreformAVEnabler") then return end

	PreformAVEnablerFrame:StripTextures()
	PreformAVEnablerFrame:SetClampedToScreen(true)
	PreformAVEnablerFrame:SetTemplate("Transparent")

	T.SkinCheckBox(PreformAVEnablerButtonizeCheckButton)

	PreformAVEnablerPVPBGButton:SkinButton()
	PreformAVEnablerFrameCloseButton:SkinButton()
	PreformAVEnablerFrameStatusButton:SkinButton()
end)