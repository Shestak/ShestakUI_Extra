local T, C, L = unpack(ShestakUI)
if C.extra_skins.preform_av ~= true then return end

----------------------------------------------------------------------------------------
--	PreformAVEnabler skin(Not Ready)
----------------------------------------------------------------------------------------
local SkinPAV = CreateFrame("Frame")
SkinPAV:RegisterEvent("PLAYER_ENTERING_WORLD")
SkinPAV:SetScript("OnEvent", function(self, event)
	
end)