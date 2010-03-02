local swt = CreateFrame("Frame", "Switchin",UIParent)
local origH = Minimap.Hide
swt.Pushed = false -- true: show; false: hide

swt:RegisterEvent("MODIFIER_STATE_CHANGED")
swt:RegisterEvent("COMPANION_UPDATE")
swt:RegisterEvent("PLAYER_ENTERING_WORLD")
swt:SetScript("OnEvent", function(self, event, ...) if self[event] then self[event](self, ...) end end)

function swt:MODIFIER_STATE_CHANGED(key, state)
	-- Check that shift has been pushed and use state 1 to unsure that we only see one push
	if((key == "LSHIFT" or key == "RSHIFT") and (state == 1)) then
		self:Alpha()
	else
		return
	end
end

function swt:Alpha()
		swt.Pushed = not swt.Pushed
		local alpha
		if(swt.Pushed) then
			Minimap:Show()
		else
			Minimap:Hide()
		end
end

function swt:COMPANION_UPDATE()
		if(IsMounted()) then
			Minimap:Show()
			Minimap.Hide = function() end -- No hiding
			swt.Pushed = true
		else
			Minimap.Hide = origH -- Re-allow hiding
			Minimap:Hide()
			swt.Pushed = false
		end
end

swt.PLAYER_ENTERING_WORLD = swt.COMPANION_UPDATE
	