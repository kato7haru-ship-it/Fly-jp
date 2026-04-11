-- 作成者: TikTokID:Robloxscriptsdistribution

local parentGui = (gethui and gethui()) or game:GetService("CoreGui")

local player = game.Players.LocalPlayer
local fly = false
local speed = 40
local vertical = 0
local landing = false

local char, hrp, hum
local bv

local function setup()
	char = player.Character or player.CharacterAdded:Wait()
	hrp = char:WaitForChild("HumanoidRootPart")
	hum = char:WaitForChild("Humanoid")
end

setup()
player.CharacterAdded:Connect(setup)

local gui = Instance.new("ScreenGui", parentGui)
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,230,0,250)
frame.Position = UDim2.new(0.75,0,0.45,0)
frame.BackgroundColor3 = Color3.fromRGB(18,18,18)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame)

local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1,0,0,20)
credit.Position = UDim2.new(0,0,0,0)
credit.Text = "TikTokID:Robloxscriptsdistribution"
credit.TextScaled = true
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(0,200,255)

local flyBtn = Instance.new("TextButton", frame)
flyBtn.Size = UDim2.new(0.9,0,0,30)
flyBtn.Position = UDim2.new(0.05,0,0.10,0)
flyBtn.Text = "飛行：OFF"
flyBtn.TextScaled = true
flyBtn.BackgroundColor3 = Color3.fromRGB(0,170,255)
Instance.new("UICorner", flyBtn)

local speedLabel = Instance.new("TextLabel", frame)
speedLabel.Size = UDim2.new(1,0,0,25)
speedLabel.Position = UDim2.new(0,0,0.25,0)
speedLabel.Text = "設定速度: "..speed
speedLabel.BackgroundTransparency = 1
speedLabel.TextScaled = true
speedLabel.TextColor3 = Color3.new(1,1,1)

local plus = Instance.new("TextButton", frame)
plus.Size = UDim2.new(0.42,0,0,30)
plus.Position = UDim2.new(0.05,0,0.40,0)
plus.Text = "速さ＋"
plus.TextScaled = true
plus.BackgroundColor3 = Color3.fromRGB(0,200,120)
Instance.new("UICorner", plus)

local minus = Instance.new("TextButton", frame)
minus.Size = UDim2.new(0.42,0,0,30)
minus.Position = UDim2.new(0.53,0,0.40,0)
minus.Text = "速さ−"
minus.TextScaled = true
minus.BackgroundColor3 = Color3.fromRGB(220,80,80)
Instance.new("UICorner", minus)

local up = Instance.new("TextButton", frame)
up.Size = UDim2.new(0.42,0,0,30)
up.Position = UDim2.new(0.05,0,0.58,0)
up.Text = "上昇"
up.TextScaled = true
up.BackgroundColor3 = Color3.fromRGB(255,170,0)
Instance.new("UICorner", up)

local down = Instance.new("TextButton", frame)
down.Size = UDim2.new(0.42,0,0,30)
down.Position = UDim2.new(0.53,0,0.58,0)
down.Text = "下降"
down.TextScaled = true
down.BackgroundColor3 = Color3.fromRGB(140,120,255)
Instance.new("UICorner", down)

local stop = Instance.new("TextButton", frame)
stop.Size = UDim2.new(0.9,0,0,28)
stop.Position = UDim2.new(0.05,0,0.78,0)
stop.Text = "停止"
stop.TextScaled = true
stop.BackgroundColor3 = Color3.fromRGB(120,120,120)
Instance.new("UICorner", stop)

frame.Active = true
frame.Draggable = true

flyBtn.MouseButton1Click:Connect(function()
	fly = not fly
	flyBtn.Text = fly and "飛行：ON" or "飛行：OFF"

	if fly then
		bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(9e9,9e9,9e9)
		bv.Velocity = Vector3.zero
		bv.Parent = hrp
	else
		landing = true
	end
end)

plus.MouseButton1Click:Connect(function()
	speed += 10
	speedLabel.Text = "設定速度: "..speed
end)

minus.MouseButton1Click:Connect(function()
	speed = math.max(10, speed - 10)
	speedLabel.Text = "設定速度: "..speed
end)

up.MouseButton1Click:Connect(function()
	vertical = 1
end)

down.MouseButton1Click:Connect(function()
	vertical = -1
end)

stop.MouseButton1Click:Connect(function()
	vertical = 0
end)

game:GetService("RunService").RenderStepped:Connect(function()
	if bv and hrp and hum then
		
		if landing then
			bv.Velocity = Vector3.new(0,-25,0)
			if hum.FloorMaterial ~= Enum.Material.Air then
				if bv then bv:Destroy() bv = nil end
				landing = false
				vertical = 0
			end
		elseif fly then
			local move = hum.MoveDirection * speed
			bv.Velocity = Vector3.new(move.X, vertical * speed, move.Z)
		end
		
	end
end)
