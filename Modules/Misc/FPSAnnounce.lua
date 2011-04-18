local T, C, L = unpack(ShestakUI)
if C.extra_general.fps_announce ~= true then return end

----------------------------------------------------------------------------------------
--	Announce fps to guild chat(FPSAnnounce by Slushe) 
----------------------------------------------------------------------------------------
local throttleSpam = 15
local sentTime = 0

local onEvent = function(self, event, ...)
	self[event](self, ...)
end

FPSAnnounce = CreateFrame("Frame", "FPSAnnounce")
FPSAnnounce:SetScript("OnEvent", onEvent)
FPSAnnounce:RegisterEvent("CHAT_MSG_GUILD")

function FPSAnnounce:CHAT_MSG_GUILD(msg, ...)
	if msg == "!fps" then
		if (difftime(time(), sentTime) >= throttleSpam) then
			sentTime = time()
			SendChatMessage("My current FPS is " .. floor(GetFramerate()), "GUILD")
		end
	end
end