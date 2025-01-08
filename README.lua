-- maded by Robote1122
local plr =game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

if game.Workspace:FindFirstChild(plr.Name.."Folder")~=nil then
	game.Workspace:FindFirstChild(plr.Name.."Folder"):Destroy()
end

if plr.PlayerGui:FindFirstChild("TestGui")~=nil then
	plr.PlayerGui:FindFirstChild("TestGui"):Destroy()
end

local Stop = false

local Moved = false

local InField = false

local PeolesField = nil

local speed=100

local StumpField=game.Workspace.FlowerZones["Stump Field"]
local SnailModel=nil
local AllTokens = game.Workspace.Collectibles

local DecalsID={
	["rbxassetid://1442725244"]="Bomb",
	["rbxassetid://1629547638"]="TokenLink",
	["rbxassetid://2000457501"]="Inspire",
	["rbxassetid://1629649299"]="Look",
	["rbxassetid://2319083910"]="Spike",
	["rbxassetid://1442700745"]="Rage"
}

local PeopleFolder= Instance.new("Folder",game.Workspace)
PeopleFolder.Name=plr.Name.."Folder"

local Gui = Instance.new("ScreenGui",plr.PlayerGui)
Gui.Name="TestGui"
local frame = Instance.new("Frame",Gui)
frame.Size=UDim2.new(0.5,0,0.5,0)
frame.Position=UDim2.new(0.25,0,0.25,0)
frame.BackgroundColor3=Color3.new(0,0,0)
frame.BackgroundTransparency=0.6

local Frame1= Instance.new("Frame",frame)
Frame1.BackgroundTransparency=1
Frame1.Size=UDim2.new(0.2,0,0.08,0)
Frame1.Position=UDim2.new(0.75,0,0.1,0)
Frame1.BorderSizePixel=0

local EnableButton1=Instance.new("TextButton",Frame1)
EnableButton1.Text=""
EnableButton1.Size=UDim2.new(0.3,0,1,0)
EnableButton1.Position=UDim2.new(0.8,0,0,0)
EnableButton1.Name="Button"
EnableButton1.BorderSizePixel=0
EnableButton1.BackgroundColor3=Color3.fromRGB(103, 103, 103)

local TextLabel1=Instance.new("TextLabel",Frame1)
TextLabel1.Name="Text"
TextLabel1.Size=UDim2.new(0.7,0,1,0)
TextLabel1.Position=UDim2.new(0,0,0,0)
TextLabel1.BorderSizePixel=0
TextLabel1.BackgroundTransparency=1
TextLabel1.TextScaled=true
TextLabel1.Text="Train Snail"
TextLabel1.TextColor3=Color3.fromRGB(0, 170, 255)
TextLabel1.FontFace=Font.fromName("Rubik")

local UICorner = Instance.new("UICorner",EnableButton1)
UICorner.CornerRadius=UDim.new(0,100)
local UICR = Instance.new("UIAspectRatioConstraint",EnableButton1)
UICR.AspectRatio=1
local SnailIndicator = Instance.new("BoolValue",EnableButton1)
EnableButton1.MouseButton1Click:Connect(function()
	if SnailIndicator.Value==false then
		SnailIndicator.Value=true
		EnableButton1.BackgroundColor3=Color3.fromRGB(0, 255, 0)
	else
		EnableButton1.BackgroundColor3=Color3.fromRGB(103, 103, 103)
		SnailIndicator.Value=false
	end
end)

PeopleFolder.ChildAdded:Connect(function(child)
	print("New child")
	print(child.BackDecal.Texture)
end)

AllTokens.ChildAdded:Connect(function(child)
	local FrontDecal = child:WaitForChild("FrontDecal")
	print(FrontDecal.Texture,DecalsID[FrontDecal.Texture])
	child.Name=DecalsID[FrontDecal.Texture] or "C"
end)

local function checkIfPlayerIsInPart(player,part)
	if player and player.Character and player.Character:FindFirstChild("Humanoid") then
		local hPartPosition = player.Character.HumanoidRootPart.Position
		local relPos = part.CFrame:PointToObjectSpace(hPartPosition)
		if math.abs(relPos.X) < part.Size.X * 0.5 and math.abs(relPos.Y) < part.Size.Y * 0.5 and math.abs(relPos.Z) < part.Size.Z * 0.5 then
			return true
		end
	end
	return false
end


game.Workspace.Monsters.ChildAdded:Connect(function(child)
	if child.Name=="Stump Snail(Lvl 6)" then
		if child.Hunter.Value==plr.UserId then
			SnailModel=child
		end
	end
end)

plr.Character.PrimaryPart:GetPropertyChangedSignal("Position"):Connect(function()
	if InField==true then
		print(checkIfPlayerIsInPart(plr,PeolesField),PeolesField)
		if checkIfPlayerIsInPart(plr,PeolesField)==false then
			InField=false
			PeolesField=nil
		end
	end
end)


function DisableColision()
	for i,v in pairs(plr.Character:GetChildren()) do
		if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("UnionOperation") or v:IsA("Part") then
			v.CanCollide=false
		end
	end
end

function GetTokens()
	if SnailModel==nil then
		if AllTokens:FindFirstChild("TokenLink")~=nil then
			if (plr.Character.PrimaryPart.Position-AllTokens:FindFirstChild("TokenLink").Position).Magnitude<100 then
				return AllTokens:FindFirstChild("TokenLink")
			end
		else
			if AllTokens:FindFirstChild("Spike")~=nil then
				if (plr.Character.PrimaryPart.Position-AllTokens:FindFirstChild("Spike").Position).Magnitude<100 then
					return AllTokens:FindFirstChild("Spike")
				end
			elseif AllTokens:FindFirstChild("Look")~=nil then
				if (plr.Character.PrimaryPart.Position-AllTokens:FindFirstChild("Look").Position).Magnitude<100 then
					return AllTokens:FindFirstChild("Look")
				end
			elseif AllTokens:FindFirstChild("Rage")~=nil then
				if (plr.Character.PrimaryPart.Position-AllTokens:FindFirstChild("Rage").Position).Magnitude<100 then
					return AllTokens:FindFirstChild("Rage")
				end
			end
		end
	else
		local sub1={
			["Spike"]=nil,
			["TokenLink"]=nil,
			["Look"]=nil,
			["Rage"]=nil
		}
		local smallest={
			["Spike"]=100,
			["TokenLink"]=100,
			["Look"]=100,
			["Rage"]=100,
		}
		for i,v in pairs(AllTokens:GetChildren()) do
			if smallest[v.Name]~=nil and v.Transparency<0.5 then
				if (plr.Character.PrimaryPart.Position-v.Position).Magnitude<smallest[v.Name] and (plr.Character.PrimaryPart.Position-SnailModel.PrimaryPart.Position).Magnitude<15 then
					smallest[v.Name]=(plr.Character.PrimaryPart.Position-v.Position).Magnitude
					sub1[v.Name]=v
				end
			end
		end
	end
end

RunService.RenderStepped:Connect(function()
	if Stop==false then
		if Moved==false then
			if SnailIndicator.Value==true then
				if InField==false or PeolesField~=StumpField then
					local BodyVel = Instance.new("BodyVelocity",plr.Character.PrimaryPart)
					BodyVel.Name="BodyVel"
					BodyVel.MaxForce=Vector3.new(math.huge,math.huge,math.huge)
					Moved=true
					BodyVel.Velocity=(StumpField.Position-plr.Character.PrimaryPart.Position+Vector3.new(0,4,0)).Unit*speed
					while InField==false do
						print((StumpField.Position-plr.Character.PrimaryPart.Position+Vector3.new(0,4,0)).Magnitude)
						if SnailIndicator.Value==false then
							break
						end
						if (StumpField.Position-plr.Character.PrimaryPart.Position+Vector3.new(0,4,0)).Magnitude<6 then
							PeolesField=StumpField
							InField=true
						end
						DisableColision()
						task.wait(0.01)
					end
					BodyVel:Destroy()
					Moved=false
				else
					local NextObj = GetTokens()
					if NextObj~=nil then
						Moved=true
						plr.Character.Humanoid:MoveTo(NextObj.Position,NextObj)
						plr.Character.Humanoid.MoveToFinished:Wait()
						Moved=false
					else
						Moved=true
						plr.Character.Humanoid:MoveTo(StumpField.Position,StumpField)
						plr.Character.Humanoid.MoveToFinished:Wait()
						Moved=false
					end
				end
			else
				if plr.Character.PrimaryPart:FindFirstChild("BodyVel")~=nil then
					plr.Character.PrimaryPart:FindFirstChild("BodyVel"):Destroy()
				end
			end
		end
	end
end)

UIS.InputBegan:Connect(function(input,chat)
	if chat then return end
	if input.KeyCode==Enum.KeyCode.L then
		Gui.Enabled=not Gui.Enabled
	end
end)

UIS.InputEnded:Connect(function(input,chat)
	if chat then return end
end)

while true do
    game.ReplicatedStorage.Events.ToolCollect:FireServer()
    task.wait(0.2)
end
