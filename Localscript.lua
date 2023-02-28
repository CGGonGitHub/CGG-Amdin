local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Event = ReplicatedStorage.AdminBarEvent
local TextBox = script.Parent
local TextLabel = script.Parent.Parent.TextLabel
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

TextBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLost)
	if enterPressed then
		local input = TextBox.Text
		Event:FireServer(input)
	else
		TextBox.Text = ""
	end
end)
