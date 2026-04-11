local Players = game:GetService("Services")
local LocalPlayer = Players.LocalPlayer
local NPCFolder = workspace:FindFirstChild("NPCs") or workspace

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.Size = UDim2.new(0, 250, 0, 180)
main.Position = UDim2.new(0, 30, 0, 100)
main.BorderSizePixel = 0

local topBar = Instance.new("TextButton", main)
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
topBar.Text = "MTI2 - PUXAR NPCs"
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

local bringBtn = Instance.new("TextButton", container)
bringBtn.Size = UDim2.new(1, -20, 0, 35)
bringBtn.Position = UDim2.new(0, 10, 0, 10)
bringBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
bringBtn.TextColor3 = Color3.new(1, 1, 1)
bringBtn.TextScaled = true
bringBtn.Text = "PUXAR NPCs"
bringBtn.BorderSizePixel = 0
bringBtn.AutoButtonColor = true

local quantidadeLabel = Instance.new("TextLabel", container)
quantidadeLabel.Size = UDim2.new(1, -20, 0, 25)
quantidadeLabel.Position = UDim2.new(0, 10, 0, 50)
quantidadeLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
quantidadeLabel.TextColor3 = Color3.new(1, 1, 1)
quantidadeLabel.TextScaled = true
quantidadeLabel.Text = "Quantidade de NPCs:"
quantidadeLabel.BorderSizePixel = 0

local quantidadeBox = Instance.new("TextBox", container)
quantidadeBox.Size = UDim2.new(1, -20, 0, 35)
quantidadeBox.Position = UDim2.new(0, 10, 0, 78)
quantidadeBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
quantidadeBox.TextColor3 = Color3.new(1, 1, 1)
quantidadeBox.TextScaled = true
quantidadeBox.Text = "10"
quantidadeBox.PlaceholderText = "Digite um numero"
quantidadeBox.BorderSizePixel = 0

local bringing = false
local puxando = false
local posicaoSalva = nil

bringBtn.MouseButton1Click:Connect(function()
	bringing = not bringing
	
	if bringing then
		bringBtn.Text = "PUXANDO..."
		bringBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
		
		local quantidadeDesejada = tonumber(quantidadeBox.Text)
		if not quantidadeDesejada or quantidadeDesejada <= 0 then
			quantidadeDesejada = 10
		end
		
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			posicaoSalva = LocalPlayer.Character.HumanoidRootPart.Position
		end
		
		puxando = true
		
		task.spawn(function()
			while puxando and bringing do
				local npcsEncontrados = {}
				
				for _, npc in pairs(NPCFolder:GetDescendants()) do
					if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
						table.insert(npcsEncontrados, npc)
					end
				end
				
				local npcsParaPuxar = {}
				for i = 1, math.min(quantidadeDesejada, #npcsEncontrados) do
					table.insert(npcsParaPuxar, npcsEncontrados[i])
				end
				
				local chaoY = posicaoSalva and posicaoSalva.Y or 0
				
				for _, npc in pairs(npcsParaPuxar) do
					local npcHRP = npc:FindFirstChild("HumanoidRootPart")
					
					if npcHRP and posicaoSalva then
						local novaPosicao = Vector3.new(posicaoSalva.X, chaoY, posicaoSalva.Z)
						npc:MoveTo(novaPosicao)
						npcHRP.CFrame = CFrame.new(novaPosicao)
					end
				end
				
				if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and posicaoSalva then
					LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(posicaoSalva)
				end
				
				task.wait(0.5)
			end
		end)
	else
		bringing = false
		puxando = false
		bringBtn.Text = "PUXAR NPCs"
		bringBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		posicaoSalva = nil
	end
end)

local collapsed = false
topBar.MouseButton1Click:Connect(function()
	collapsed = not collapsed
	container.Visible = not collapsed
	topBar.Text = collapsed and "MTI2 - PUXAR NPCs" or "MTI2 - PUXAR NPCs"
	main.Size = collapsed and UDim2.new(0, 250, 0, 30) or UDim2.new(0, 250, 0, 180)
end)
