--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
-- MTI2 - Bring All NPCs GUI | CodeX (Mobile Pure Lua)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local NPCFolder = workspace:FindFirstChild("NPCs") or workspace

-- GUI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.Size = UDim2.new(0, 220, 0, 120)
main.Position = UDim2.new(0, 30, 0, 100)
main.BorderSizePixel = 0

-- Top Bar (Draggable)
local topBar = Instance.new("TextButton", main)
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
topBar.Text = "▼ MTI2 - NPC BRINGER"
topBar.TextColor3 = Color3.new(1, 1, 1)
topBar.TextScaled = true
topBar.BorderSizePixel = 0

-- Draggable Support (Mobile)
local dragging, dragStart, startPos
topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
topBar.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Container Frame
local container = Instance.new("Frame", main)
container.BackgroundTransparency = 1
container.Position = UDim2.new(0, 0, 0, 30)
container.Size = UDim2.new(1, 0, 1, -30)

-- Bring NPCs Button
local bringBtn = Instance.new("TextButton", container)
bringBtn.Size = UDim2.new(1, -20, 0, 35)
bringBtn.Position = UDim2.new(0, 10, 0, 10)
bringBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
bringBtn.TextColor3 = Color3.new(1, 1, 1)
bringBtn.TextScaled = true
bringBtn.Text = "🔁 Bring All NPCs"
bringBtn.BorderSizePixel = 0
bringBtn.AutoButtonColor = true

-- Toggle Loop
local bringing = false
bringBtn.MouseButton1Click:Connect(function()
	bringing = not bringing
	bringBtn.Text = bringing and "✅ Bringing NPCs" or "🔁 Bring All NPCs"

	if bringing then
		task.spawn(function()
			while bringing do
				for _, npc in pairs(NPCFolder:GetDescendants()) do
					if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
						npc:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-4, 4), 0, math.random(-4, 4)))
					end
				end
				wait(1)
			end
		end)
	end
end)

-- Collapse Button Toggle
local collapsed = false
topBar.MouseButton1Click:Connect(function()
	collapsed = not collapsed
	container.Visible = not collapsed
	topBar.Text = collapsed and "▲ MTI2 - NPC BRINGER" or "▼ MTI2 - NPC BRINGER"
	main.Size = collapsed and UDim2.new(0, 220, 0, 30) or UDim2.new(0, 220, 0, 120)
end)
