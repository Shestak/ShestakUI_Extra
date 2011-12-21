local T, C, L = unpack(ShestakUI)
if C.extra_general.skip_cinematic ~= true then return end

----------------------------------------------------------------------------------------
--	Cancel cinematics after they start(by Pigmonkey)
----------------------------------------------------------------------------------------
local f = CreateFrame("Frame")
f:RegisterEvent("CINEMATIC_START")
f:SetScript("OnEvent", function(_, event)
	if event == "CINEMATIC_START" then
		if InCinematic() and not IsControlKeyDown() then
			StopCinematic()
		end
	end
end)

----------------------------------------------------------------------------------------
--	Hook movies and stop them before they get called(by Pigmonkey)
----------------------------------------------------------------------------------------
local PlayMovie_hook = MovieFrame_PlayMovie
MovieFrame_PlayMovie = function(...)
	if IsControlKeyDown() then
		PlayMovie_hook(...)
	else
		GameMovieFinished()
	end
end
