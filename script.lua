local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.Size = UDim2.new(0, 300, 0, 450)
main.Position = UDim2.new(0, 30, 0, 100)
main.BorderSizePixel = 0

local topBar = Instance.new("TextButton", main)
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
topBar.Text = "MTI2 - PUXAR ITENS"
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

local atualizarBtn = Instance.new("TextButton", container)
atualizarBtn.Size = UDim2.new(1, -20, 0, 35)
atualizarBtn.Position = UDim2.new(0, 10, 0, 5)
atualizarBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
atualizarBtn.TextColor3 = Color3.new(1, 1, 1)
atualizarBtn.TextScaled = true
atualizarBtn.Text = "ATUALIZAR LISTA"
atualizarBtn.BorderSizePixel = 0

local scrollingFrame = Instance.new("ScrollingFrame", container)
scrollingFrame.Size = UDim2.new(1, -20, 1, -50)
scrollingFrame.Position = UDim2.new(0, 10, 0, 45)
scrollingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
scrollingFrame.BorderSizePixel = 0
scrollingFrame.ScrollBarThickness = 8
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

local listLayout = Instance.new("UIListLayout", scrollingFrame)
listLayout.SortOrder = Enum.SortOrder.Name
listLayout.Padding = UDim.new(0, 2)

local function atualizarLista()
	for _, child in pairs(scrollingFrame:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
	
	local itens = {}
	
	local function buscarItens(objeto)
		for _, item in pairs(objeto:GetChildren()) do
			if item:IsA("Tool") or item:IsA("BasePart") then
				local nome = item.Name
				if not itens[nome] then
					itens[nome] = {}
				end
				table.insert(itens[nome], item)
			end
			buscarItens(item)
		end
	end
	
	buscarItens(workspace)
	
	local yOffset = 0
	for nome, lista in pairs(itens) do
		local botao = Instance.new("TextButton", scrollingFrame)
		botao.Size = UDim2.new(1, -10, 0, 35)
		botao.Position = UDim2.new(0, 5, 0, yOffset)
		botao.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		botao.TextColor3 = Color3.new(1, 1, 1)
		botao.Text = nome .. " (" .. #lista .. ")"
		botao.TextScaled = true
		botao.BorderSizePixel = 0
		
		local instancias = lista
		
		botao.MouseButton1Click:Connect(function()
			local playerChar = LocalPlayer.Character
			local playerHRP = playerChar and playerChar:FindFirstChild("HumanoidRootPart")
			
			if playerHRP then
				local alvo = instancias[1]
				if alvo then
					local posicaoAlvo = alvo:FindFirstChild("Handle") and alvo.Handle.Position or alvo:IsA("BasePart") and alvo.Position or alvo:GetPivot().Position
					
					local clone = Instance.new("Part")
					clone.Size = Vector3.new(1, 1, 1)
					clone.Anchored = true
					clone.CanCollide = false
					clone.Transparency = 1
					clone.Position = playerHRP.Position
					clone.Parent = workspace
					
					local tween = game:GetService("TweenService"):Create(clone, TweenInfo.new(0.2), {Position = posicaoAlvo})
					tween:Play()
					tween.Completed:Connect(function()
						alvo:SetPrimaryPartCFrame(CFrame.new(playerHRP.Position))
						if alvo:IsA("BasePart") then
							alvo.Position = playerHRP.Position
						end
						clone:Destroy()
					end)
				end
			end
		end)
		
		yOffset = yOffset + 37
	end
	
	scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset + 10)
end

atualizarBtn.MouseButton1Click:Connect(function()
	atualizarBtn.Text = "CARREGANDO..."
	task.wait()
	atualizarLista()
	atualizarBtn.Text = "ATUALIZAR LISTA"
end)

local collapsed = false
topBar.MouseButton1Click:Connect(function()
	collapsed = not collapsed
	container.Visible = not collapsed
	topBar.Text = collapsed and "MTI2 - PUXAR ITENS" or "MTI2 - PUXAR ITENS"
	main.Size = collapsed and UDim2.new(0, 300, 0, 30) or UDim2.new(0, 300, 0, 450)
end)

atualizarLista()
