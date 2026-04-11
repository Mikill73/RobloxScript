local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local NPCFolder = workspace:FindFirstChild("NPCs") or workspace
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.Size = UDim2.new(0, 280, 0, 320)
main.Position = UDim2.new(0, 30, 0, 100)
main.BorderSizePixel = 0

local topBar = Instance.new("TextButton", main)
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
topBar.Text = "MTI2 - HACKS"
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

local container = Instance.new("ScrollingFrame", main)
container.BackgroundTransparency = 1
container.Position = UDim2.new(0, 0, 0, 30)
container.Size = UDim2.new(1, 0, 1, -30)
container.CanvasSize = UDim2.new(0, 0, 0, 400)
container.ScrollBarThickness = 5

local function criarBotao(texto, yPos, cor)
	local btn = Instance.new("TextButton", container)
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, yPos)
	btn.BackgroundColor3 = cor or Color3.fromRGB(45, 45, 45)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.TextScaled = true
	btn.Text = texto
	btn.BorderSizePixel = 0
	return btn
end

local function criarTextArea(texto, yPos, valorPadrao)
	local label = Instance.new("TextLabel", container)
	label.Size = UDim2.new(1, -20, 0, 20)
	label.Position = UDim2.new(0, 10, 0, yPos)
	label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextScaled = true
	label.Text = texto
	label.BorderSizePixel = 0
	
	local box = Instance.new("TextBox", container)
	box.Size = UDim2.new(1, -20, 0, 30)
	box.Position = UDim2.new(0, 10, 0, yPos + 22)
	box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	box.TextColor3 = Color3.new(1, 1, 1)
	box.TextScaled = true
	box.Text = tostring(valorPadrao)
	box.PlaceholderText = texto
	box.BorderSizePixel = 0
	
	return box
end

local yAtual = 10

local puxarBtn = criarBotao("PUXAR NPCs", yAtual, Color3.fromRGB(45, 45, 45))
yAtual = yAtual + 45

local qntLabel = Instance.new("TextLabel", container)
qntLabel.Size = UDim2.new(1, -20, 0, 20)
qntLabel.Position = UDim2.new(0, 10, 0, yAtual)
qntLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
qntLabel.TextColor3 = Color3.new(1, 1, 1)
qntLabel.TextScaled = true
qntLabel.Text = "Quantidade de NPCs para puxar:"
qntLabel.BorderSizePixel = 0
yAtual = yAtual + 22

local quantidadeBox = Instance.new("TextBox", container)
quantidadeBox.Size = UDim2.new(1, -20, 0, 30)
quantidadeBox.Position = UDim2.new(0, 10, 0, yAtual)
quantidadeBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
quantidadeBox.TextColor3 = Color3.new(1, 1, 1)
quantidadeBox.TextScaled = true
quantidadeBox.Text = "10"
quantidadeBox.PlaceholderText = "Digite um numero"
quantidadeBox.BorderSizePixel = 0
yAtual = yAtual + 40

local ataqueBtn = criarBotao("VELOCIDADE DE ATAQUE (SUPER RAPIDO)", yAtual, Color3.fromRGB(100, 50, 50))
yAtual = yAtual + 50

local colisaoBtn = criarBotao("DESATIVAR COLISAO", yAtual, Color3.fromRGB(50, 50, 100))
yAtual = yAtual + 50

local criarNPCBtn = criarBotao("CRIAR NPC", yAtual, Color3.fromRGB(50, 100, 50))
yAtual = yAtual + 45

local qntCriarLabel = Instance.new("TextLabel", container)
qntCriarLabel.Size = UDim2.new(1, -20, 0, 20)
qntCriarLabel.Position = UDim2.new(0, 10, 0, yAtual)
qntCriarLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
qntCriarLabel.TextColor3 = Color3.new(1, 1, 1)
qntCriarLabel.TextScaled = true
qntCriarLabel.Text = "Quantidade de NPCs para criar:"
qntCriarLabel.BorderSizePixel = 0
yAtual = yAtual + 22

local criarQuantidadeBox = Instance.new("TextBox", container)
criarQuantidadeBox.Size = UDim2.new(1, -20, 0, 30)
criarQuantidadeBox.Position = UDim2.new(0, 10, 0, yAtual)
criarQuantidadeBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
criarQuantidadeBox.TextColor3 = Color3.new(1, 1, 1)
criarQuantidadeBox.TextScaled = true
criarQuantidadeBox.Text = "1"
criarQuantidadeBox.PlaceholderText = "Digite um numero"
criarQuantidadeBox.BorderSizePixel = 0
yAtual = yAtual + 45

local statusLabel = Instance.new("TextLabel", container)
statusLabel.Size = UDim2.new(1, -20, 0, 25)
statusLabel.Position = UDim2.new(0, 10, 0, yAtual)
statusLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
statusLabel.TextColor3 = Color3.new(1, 1, 1)
statusLabel.TextScaled = true
statusLabel.Text = "Status: Pronto"
statusLabel.BorderSizePixel = 0

container.CanvasSize = UDim2.new(0, 0, 0, yAtual + 40)

local bringing = false
local puxando = false

puxarBtn.MouseButton1Click:Connect(function()
	bringing = not bringing
	
	if bringing then
		puxarBtn.Text = "PUXANDO..."
		puxarBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
		statusLabel.Text = "Status: Puxando NPCs..."
		
		local quantidadeDesejada = tonumber(quantidadeBox.Text)
		if not quantidadeDesejada or quantidadeDesejada <= 0 then
			quantidadeDesejada = 10
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
				
				local chaoY = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position.Y or 0
				
				for _, npc in pairs(npcsParaPuxar) do
					local npcHRP = npc:FindFirstChild("HumanoidRootPart")
					local playerHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
					
					if npcHRP and playerHRP then
						local novaPosicao = Vector3.new(playerHRP.Position.X, chaoY, playerHRP.Position.Z)
						npc:MoveTo(novaPosicao)
						npcHRP.CFrame = CFrame.new(novaPosicao)
					end
				end
				
				task.wait(0.5)
			end
		end)
	else
		bringing = false
		puxando = false
		puxarBtn.Text = "PUXAR NPCs"
		puxarBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		statusLabel.Text = "Status: Parado"
	end
end)

local velocidadeAtaqueAtiva = false
local conexaoAtaque

ataqueBtn.MouseButton1Click:Connect(function()
	velocidadeAtaqueAtiva = not velocidadeAtaqueAtiva
	
	if velocidadeAtaqueAtiva then
		ataqueBtn.Text = "VELOCIDADE ATIVA"
		ataqueBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
		statusLabel.Text = "Status: Velocidade de ataque ativada"
		
		if LocalPlayer.Character then
			local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
			if humanoid then
				conexaoAtaque = humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
				end)
			end
		end
		
		task.spawn(function()
			while velocidadeAtaqueAtiva do
				local character = LocalPlayer.Character
				if character then
					for _, tool in pairs(character:GetChildren()) do
						if tool:IsA("Tool") then
							for _, script in pairs(tool:GetDescendants()) do
								if script:IsA("LocalScript") or script:IsA("Script") then
									if script:FindFirstChild("Cooldown") then
										script.Cooldown = 0
									end
									if script:FindFirstChild("HitTime") then
										script.HitTime = 0
									end
									if script:FindFirstChild("AttackCooldown") then
										script.AttackCooldown = 0
									end
									if script:FindFirstChild("SwingCooldown") then
										script.SwingCooldown = 0
									end
								end
							end
						end
					end
				end
				
				local args = {
					[1] = "Attack"
				}
				game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvent"):FireServer(unpack(args))
				
				task.wait(0.05)
			end
		end)
	else
		velocidadeAtaqueAtiva = false
		ataqueBtn.Text = "VELOCIDADE DE ATAQUE"
		ataqueBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 50)
		statusLabel.Text = "Status: Velocidade desativada"
		if conexaoAtaque then
			conexaoAtaque:Disconnect()
		end
	end
end)

local colisaoAtiva = false
local colisoesOriginais = {}

colisaoBtn.MouseButton1Click:Connect(function()
	colisaoAtiva = not colisaoAtiva
	
	if colisaoAtiva then
		colisaoBtn.Text = "COLISAO DESATIVADA"
		colisaoBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
		statusLabel.Text = "Status: Colisao desativada"
		
		local function desativarColisao(part)
			if part:IsA("BasePart") and part.CanCollide then
				colisoesOriginais[part] = part.CanCollide
				part.CanCollide = false
			end
		end
		
		local character = LocalPlayer.Character
		if character then
			for _, part in pairs(character:GetDescendants()) do
				desativarColisao(part)
			end
		end
		
		LocalPlayer.CharacterAdded:Connect(function(newChar)
			task.wait(0.5)
			for _, part in pairs(newChar:GetDescendants()) do
				desativarColisao(part)
			end
		end)
	else
		colisaoBtn.Text = "DESATIVAR COLISAO"
		colisaoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
		statusLabel.Text = "Status: Colisao ativada"
		
		for part, valor in pairs(colisoesOriginais) do
			if part and part.Parent then
				part.CanCollide = valor
			end
		end
		colisoesOriginais = {}
	end
end)

criarNPCBtn.MouseButton1Click:Connect(function()
	local quantidade = tonumber(criarQuantidadeBox.Text)
	if not quantidade or quantidade <= 0 then
		quantidade = 1
	end
	
	statusLabel.Text = "Status: Criando " .. quantidade .. " NPC(s)..."
	
	local playerPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not playerPos then
		statusLabel.Text = "Status: Erro - Personagem nao encontrado"
		return
	end
	
	local posicaoBase = playerPos.Position + Vector3.new(5, 0, 5)
	
	for i = 1, quantidade do
		local novoNPC = Instance.new("Model")
		novoNPC.Name = "NPC_Criado_" .. i
		
		local humanoid = Instance.new("Humanoid", novoNPC)
		humanoid.MaxHealth = 100
		humanoid.Health = 100
		
		local hrp = Instance.new("Part", novoNPC)
		hrp.Name = "HumanoidRootPart"
		hrp.Size = Vector3.new(2, 2, 1)
		hrp.Anchored = false
		hrp.CanCollide = true
		
		local torso = Instance.new("Part", novoNPC)
		torso.Name = "Torso"
		torso.Size = Vector3.new(2, 1.5, 1)
		torso.Anchored = false
		torso.CanCollide = true
		
		local head = Instance.new("Part", novoNPC)
		head.Name = "Head"
		head.Size = Vector3.new(1.5, 1.5, 1.5)
		head.Anchored = false
		head.CanCollide = true
		
		humanoid.HumanoidRootPart = hrp
		
		local posOffset = Vector3.new(math.random(-3, 3), 0, math.random(-3, 3))
		hrp.CFrame = CFrame.new(posicaoBase + posOffset)
		torso.CFrame = hrp.CFrame * CFrame.new(0, -1, 0)
		head.CFrame = hrp.CFrame * CFrame.new(0, 1.5, 0)
		
		local weld1 = Instance.new("WeldConstraint", torso)
		weld1.Part0 = torso
		weld1.Part1 = hrp
		
		local weld2 = Instance.new("WeldConstraint", head)
		weld2.Part0 = head
		weld2.Part1 = torso
		
		novoNPC.Parent = workspace
		
		task.wait(0.2)
	end
	
	statusLabel.Text = "Status: " .. quantidade .. " NPC(s) criado(s)"
	task.wait(2)
	statusLabel.Text = "Status: Pronto"
end)

local collapsed = false
topBar.MouseButton1Click:Connect(function()
	collapsed = not collapsed
	container.Visible = not collapsed
	main.Size = collapsed and UDim2.new(0, 280, 0, 30) or UDim2.new(0, 280, 0, 320)
end)
