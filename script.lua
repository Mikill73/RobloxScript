local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local NPCFolder = workspace:FindFirstChild("NPCs") or workspace

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.Size = UDim2.new(0, 250, 0, 180)
main.Position = UDim2.new(0, 30, 0, 300)
main.BorderSizePixel = 0

local topBar = Instance.new("TextButton", main)
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
topBar.Text = "MTI2 - AFASTAR NPCs"
topBar.TextColor3 = Color3.new(1, 1, 1)
topBar.TextScaled = true
topBar.BorderSizePixel = 0

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

local container = Instance.new("Frame", main)
container.BackgroundTransparency = 1
container.Position = UDim2.new(0, 0, 0, 30)
container.Size = UDim2.new(1, 0, 1, -30)

local afastarBtn = Instance.new("TextButton", container)
afastarBtn.Size = UDim2.new(1, -20, 0, 35)
afastarBtn.Position = UDim2.new(0, 10, 0, 10)
afastarBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
afastarBtn.TextColor3 = Color3.new(1, 1, 1)
afastarBtn.TextScaled = true
afastarBtn.Text = "AFASTAR NPCs"
afastarBtn.BorderSizePixel = 0
afastarBtn.AutoButtonColor = true

local distanciaLabel = Instance.new("TextLabel", container)
distanciaLabel.Size = UDim2.new(1, -20, 0, 25)
distanciaLabel.Position = UDim2.new(0, 10, 0, 50)
distanciaLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
distanciaLabel.TextColor3 = Color3.new(1, 1, 1)
distanciaLabel.TextScaled = true
distanciaLabel.Text = "Distancia de afastamento:"
distanciaLabel.BorderSizePixel = 0

local distanciaBox = Instance.new("TextBox", container)
distanciaBox.Size = UDim2.new(1, -20, 0, 35)
distanciaBox.Position = UDim2.new(0, 10, 0, 78)
distanciaBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
distanciaBox.TextColor3 = Color3.new(1, 1, 1)
distanciaBox.TextScaled = true
distanciaBox.Text = "500"
distanciaBox.PlaceholderText = "Digite a distancia"
distanciaBox.BorderSizePixel = 0

local afastando = false
local ativo = false

afastarBtn.MouseButton1Click:Connect(function()
	afastando = not afastando
	
	if afastando then
		afastarBtn.Text = "AFSTANDO..."
		afastarBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
		
		local distanciaDesejada = tonumber(distanciaBox.Text)
		if not distanciaDesejada or distanciaDesejada <= 0 then
			distanciaDesejada = 500
		end
		
		ativo = true
		
		task.spawn(function()
			while ativo and afastando do
				local jogadorPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				
				if jogadorPos then
					for _, npc in pairs(NPCFolder:GetDescendants()) do
						if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
							local npcHRP = npc.HumanoidRootPart
							local direcao = (npcHRP.Position - jogadorPos.Position).Unit
							local novaPosicao = jogadorPos.Position + (direcao * distanciaDesejada)
							
							npc:MoveTo(novaPosicao)
							npcHRP.CFrame = CFrame.new(novaPosicao)
						end
					end
				end
				
				task.wait(0.5)
			end
		end)
	else
		afastando = false
		ativo = false
		afastarBtn.Text = "AFASTAR NPCs"
		afastarBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	end
end)

local collapsed = false
topBar.MouseButton1Click:Connect(function()
	collapsed = not collapsed
	container.Visible = not collapsed
	topBar.Text = collapsed and "MTI2 - AFASTAR NPCs" or "MTI2 - AFASTAR NPCs"
	main.Size = collapsed and UDim2.new(0, 250, 0, 30) or UDim2.new(0, 250, 0, 180)
end)
