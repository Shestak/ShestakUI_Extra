local T, C, L = unpack(ShestakUI)
if C.extra_bar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Extra ActionBar(by )
----------------------------------------------------------------------------------------
local SpellListTest = {45438, 12051, 122, 82676}
local totalspells = table.getn(SpellListTest)

local custombar = CreateFrame("Frame", "CustomActionBar", UIParent, "SecureHandlerStateTemplate")
custombar:CreatePanel("Invisible", 1, C.extra_bar.button_size, unpack(C.extra_position.extra_bar))
custombar:SetWidth((totalspells * C.extra_bar.button_size) + ((totalspells - 1) * C.extra_bar.button_space))

local custombutton = CreateFrame("Button", "CustomButton", custombar, "SecureActionButtonTemplate")

if totalspells then
	for i, v in ipairs(SpellListTest) do
		-- Buttons
		custombutton[i] = CreateFrame("Button", "CustomButton"..i, custombar, "SecureActionButtonTemplate")
		custombutton[i]:CreatePanel("Transparent", C.extra_bar.button_size, C.extra_bar.button_size, "TOPLEFT", custombar, "TOPLEFT", 0, 0)
		custombutton[i]:StyleButton()
		custombutton[i]:SetAttribute("type", "spell")
		custombutton[i]:SetAttribute("spell", SpellListTest[i])
		
		-- Positions
		if i ~= 1 then
			custombutton[i]:SetPoint("TOPLEFT", custombutton[i-1], "TOPRIGHT", C.extra_bar.button_space, 0)
		end
		
		-- Textures
		custombutton[i].texture = custombutton[i]:CreateTexture(nil, "BORDER")
		custombutton[i].texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		custombutton[i].texture:SetPoint("TOPLEFT", custombutton[i] ,"TOPLEFT", 2, -2)
		custombutton[i].texture:SetPoint("BOTTOMRIGHT", custombutton[i] ,"BOTTOMRIGHT", -2, 2)
		custombutton[i].texture:SetTexture(select(3, GetSpellInfo(SpellListTest[i])))
	
		-- Texts
		custombutton[i].value = custombutton[i]:CreateFontString(nil, "ARTWORK")
		custombutton[i].value:SetFont(C.font.action_bars_font, C.font.action_bars_font_size * 2, C.font.action_bars_font_style)
		custombutton[i].value:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
		custombutton[i].value:Point("CENTER", custombutton[i], "CENTER")

		-- Cooldowns
		custombutton[i].cooldown = CreateFrame("Cooldown", "$parentCD", custombutton[i], "CooldownFrameTemplate")
		custombutton[i].cooldown:SetAllPoints(custombutton[i].texture)

		custombutton[i]:SetScript("OnUpdate", function()
			custombutton[i].texture:SetTexture(select(3, GetSpellInfo(SpellListTest[i])))
			local start, duration, enabled = GetSpellCooldown(SpellListTest[i])
			if not duration then duration = 0 end
			if not start then start = 0	end			
			if not enabled then	enabled = 0	end
			if duration > 1.5 then
				if enabled ~= 0 then
					custombutton[i].texture:SetVertexColor(1, 1, 1)
					custombutton[i].cooldown:SetCooldown(start, duration)
				else
					custombutton[i].texture:SetVertexColor(0.35, 0.35, 0.35)
				end
			end
		end)
	end
else
	custombar:Hide()
end