local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Event = ReplicatedStorage.AdminBarEvent
local TextBox = script.Parent
local TextLabel = script.Parent.Parent
local commands = {
	"kill";
	"anchor";
	"walkspeed";
	"bring";
	"teleport";
	"loadchar";
	"invisible";
	"uninvisible";
	"setdiplay";
	"kick";
	"removegrass";
	"addgrass";
	"kidnap";
	"sword";
	"headsize";
	"jumppower";
	"char";
	"settempadmin";
	"settempmode";
	"removetempadmin";
	"removetempmod";
	"freeze";
	"unfreeze";
	"rejoin"
}

TextBox:GetPropertyChangedSignal("Text"):Connect(function()
	local text = TextBox.Text
	if string.len(text) < 2 then
		return
	else
		for i, v in commands do
			if string.match(v, text) then
				TextLabel.Text = v
			end
		end		
	end
end)

TextBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLost)
	if enterPressed then
		local input = TextBox.Text
		Event:FireServer(input)
	else
		TextBox.Text = ""
	end
end)
