local swt = CreateFrame("Frame", "Switchin",UIParent)
swt.Pushed = false

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
			alpha = 1
		else
			alpha = 0
		end
		Minimap:SetAlpha(alpha)
end

function swt:COMPANION_UPDATE()
		if(IsMounted()) then
			Minimap:SetAlpha(1)
		else
			Minimap:SetAlpha(0)
		end
end

swt.PLAYER_ENTERING_WORLD = swt.COMPANION_UPDATE
	