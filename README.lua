-- made By Robote1122
task.wait(1)
local plr =game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

while plr.Character==nil do task.wait() end

local Stop = false
local Moved = false
local InField = false
local PeolesField = nil
local speed=100

local CapacityFull=false

if game.Workspace:FindFirstChild(plr.Name.."Folder")~=nil then
	game.Workspace:FindFirstChild(plr.Name.."Folder"):Destroy()
end

if plr.PlayerGui:FindFirstChild("TestGui")~=nil then
	plr.PlayerGui:FindFirstChild("TestGui"):Destroy()
end


if plr.CoreStats.Pollen.Value>=plr.CoreStats.Capacity.Value then
	CapacityFull=true
end

function DisableColision()
	for i,v in pairs(plr.Character:GetChildren()) do
		if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("UnionOperation") or v:IsA("Part") then
			v.CanCollide=false
		end
	end
end

function ConvertHive()
	
end

function CheckPeopleHive() 
	for i,v in pairs(game.Workspace.Honeycombs:GetChildren()) do
		if v.Owner.Value~=nil then
			if v.Owner.Value==plr then
				return true
			end
		end
	end
	return false
end
spawn(function()
	if CheckPeopleHive()==false then
		for Number=6,1,-1 do
			local  v=game.Workspace.Honeycombs:FindFirstChild("Hive"..Number)
			local BodyVel = Instance.new("BodyVelocity",plr.Character.PrimaryPart)
			BodyVel.Name="BodyVel"
			BodyVel.MaxForce=Vector3.new(math.huge,math.huge,math.huge)
			BodyVel.Velocity=(v.Platform.Value.PrimaryPart.Position-plr.Character.PrimaryPart.Position+Vector3.new(0,4,0)).Unit*speed
			Moved=true
			while Moved==true do
				DisableColision()
				if (v.Platform.Value.PrimaryPart.Position-plr.Character.PrimaryPart.Position+Vector3.new(0,4,0)).Magnitude<4 then
					Moved=false
					print("EndToHive")
					break
				end
				task.wait()
			end
			BodyVel:Destroy()
			if v.Owner.Value==nil then
				game:GetService("ReplicatedStorage").Events.ClaimHive:FireServer(v.HiveID.Value)
				if plr.CoreStats.Pollen.Value~=0 then
					game:GetService("ReplicatedStorage").Events.PlayerHiveCommand:FireServer("ToggleHoneyMaking")
				end
				break
			else
				continue
			end
		end
	end
end)

local StumpField=game.Workspace.FlowerZones["Stump Field"]
local SnailModel=nil
local AllTokens = game.Workspace.Collectibles
local DecalsId={
	[1839454544]="GummybeeMore",
	[1104415222]="TabbyScratch",
	[2499514197]="ConvertMark",
	[1442764904]="BombPlus",
	[2499540966]="TabbyScratch",
	[253828517]="Melody",

	[65867881]="Hasty",
	[4519549299]="SpiceAbil",
	[1472256444]="BabyLove",
	[8083436978]="Balloon",
	[1442863423]="BlueBoost",
	[8083943936]="Surprize",

	[1874564120]="Pulse",
	[4528414666]="Table",
	[4528379338]="Syntez",
	[1472135114]="Honey",
	[2028574353]="Treat",
	[6087969886]="Snow",

	[1442725244]="Bomb",
	[1629547638]="TokenLink",
	[2000457501]="Inspire",
	[1629649299]="Look",
	[2319083910]="Spike",
	[1442700745]="Rage",
	
	[1472425802]="BrownBearMorph",
	[1472532912]="PolarBearMorph",
	[1472580249]="PandaBearMorph",
	[177997841]="GummybeeOne",
	[4889322534]="FuzzyBomb",
	[4519523935]="VectorTrig",
	
	[2028453802]="Blueberry",
	[1471882621]="RoyalJelly",
	[1952796032]="Pineapple",
	[1952682401]="SunflowerSeed",
	[4889470194]="GiftField",
	[1472491940]="BlackBearMorph",
	
	
	[1874692303]="BlueSyntez",
	[10000000000000]="dddd",
	[10000000000000]="dddd",
	[10000000000000]="dddd",
	[10000000000000]="dddd",
	[10000000000000]="dddd",
}



local FullDecalsId={

}

local SmallDecalsId={

}
spawn(function()
	for i,v in pairs(DecalsId) do
		SmallDecalsId["rbxassetid://"..i]=v
		FullDecalsId["http://www.roblox.com/asset/?id="..i]=v
	end
end)

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
Frame1.BackgroundColor3=Color3.fromRGB(0, 0, 0)
Frame1.BackgroundTransparency=0.8
Frame1.Size=UDim2.new(0.2,0,0.1,0)
Frame1.Position=UDim2.new(0.75,0,0.1,0)
Frame1.BorderSizePixel=0

local Frame2= Instance.new("Frame",frame)
Frame2.BackgroundColor3=Color3.fromRGB(0, 0, 0)
Frame2.BackgroundTransparency=0.8
Frame2.Size=UDim2.new(0.2,0,0.1,0)
Frame2.Position=UDim2.new(0.75,0,0.3,0)
Frame2.BorderSizePixel=0

local EnableButton1=Instance.new("TextButton",Frame1)
EnableButton1.Text=""
EnableButton1.Size=UDim2.new(0.3,0,1,0)
EnableButton1.Position=UDim2.new(0.8,0,0,0)
EnableButton1.Name="Button"
EnableButton1.BorderSizePixel=0
EnableButton1.BackgroundColor3=Color3.fromRGB(103, 103, 103)

local UICorner = Instance.new("UICorner",EnableButton1)
UICorner.CornerRadius=UDim.new(0,100)
local UICR = Instance.new("UIAspectRatioConstraint",EnableButton1)
UICR.AspectRatio=1

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

local EnableButton2=Instance.new("TextButton",Frame2)
EnableButton2.Text=""
EnableButton2.Size=UDim2.new(0.3,0,1,0)
EnableButton2.Position=UDim2.new(0.8,0,0,0)
EnableButton2.Name="Button"
EnableButton2.BorderSizePixel=0
EnableButton2.BackgroundColor3=Color3.fromRGB(103, 103, 103)

local UICorner = Instance.new("UICorner",EnableButton2)
UICorner.CornerRadius=UDim.new(0,100)
local UICR = Instance.new("UIAspectRatioConstraint",EnableButton2)
UICR.AspectRatio=1

local TextLabel2=Instance.new("TextLabel",Frame2)
TextLabel2.Name="Text"
TextLabel2.Size=UDim2.new(0.7,0,1,0)
TextLabel2.Position=UDim2.new(0,0,0,0)
TextLabel2.BorderSizePixel=0
TextLabel2.BackgroundTransparency=1
TextLabel2.TextScaled=true
TextLabel2.Text="Auto Dig"
TextLabel2.TextColor3=Color3.fromRGB(0, 170, 255)
TextLabel2.FontFace=Font.fromName("Rubik")

local AutoDigIndicator=Instance.new("BoolValue",EnableButton2)
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

EnableButton2.MouseButton1Click:Connect(function()
	if AutoDigIndicator.Value==false then
		AutoDigIndicator.Value=true
		EnableButton2.BackgroundColor3=Color3.fromRGB(0, 255, 0)
	else
		EnableButton2.BackgroundColor3=Color3.fromRGB(103, 103, 103)
		AutoDigIndicator.Value=false
	end 
end)

AutoDigIndicator.Changed:Connect(function()
	while AutoDigIndicator.Value==true do
		game.ReplicatedStorage.Events.ToolCollect:FireServer()
		task.wait(0.2)
	end
end)

PeopleFolder.ChildAdded:Connect(function(child)
	print("New child")
	print(child.BackDecal.Texture)
end)

AllTokens.ChildAdded:Connect(function(child)
	local FrontDecal = child:WaitForChild("FrontDecal")
	child.Name=SmallDecalsId[FrontDecal.Texture] or FullDecalsId[FrontDecal.Texture] or "C"
	if child.Name=="C" then
		print(FrontDecal.Texture,nil)
	end
end)

plr.CoreStats.Pollen.Changed:Connect(function()
	
end)

plr.CoreStats.Capacity.Changed:Connect(function()

end)

local function checkIfPlayerIsInPart(player,part)
	if player and player.Character and player.Character:FindFirstChild("Humanoid") then
		local hPartPosition = player.Character.HumanoidRootPart.Position
		local relPos = part.CFrame:PointToObjectSpace(hPartPosition)
		if math.abs(relPos.X) < part.Size.X * 0.5 and math.abs(relPos.Y) < part.Size.Y * 6 and math.abs(relPos.Z) < part.Size.Z * 0.5 then
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

plr.Character.Humanoid.Changed:Connect(function()
	if PeolesField~=nil then
		InField=checkIfPlayerIsInPart(plr,PeolesField)
	else
		print("People field is nill")
	end
end)

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
			elseif AllTokens:FindFirstChild("Melody")~=nil then
				if (plr.Character.PrimaryPart.Position-AllTokens:FindFirstChild("Melody").Position).Magnitude<100 then
					return AllTokens:FindFirstChild("Melody")
				end
			end
		end
	else
		local sub1={
			["Spike"]=nil,
			["TokenLink"]=nil,
			["Look"]=nil,
			["Rage"]=nil
			["Melody"]=nil,
		}
		local smallest={
			["Spike"]=100,
			["TokenLink"]=100,
			["Look"]=100,
			["Rage"]=100,
			["Melody"]=100
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
						if SnailIndicator.Value==false then
							break
						end
						if (StumpField.Position-plr.Character.PrimaryPart.Position+Vector3.new(0,4,0)).Magnitude<6 then
							PeolesField=StumpField
							InField=true
						end
						DisableColision()
						task.wait()
					end
					BodyVel:Destroy()
					Moved=false
				elseif InField==false and checkIfPlayerIsInPart(plr,PeolesField)==false then
					Moved=true
					InField=false
					plr.Character.Humanoid:MoveTo(plr.Character.PrimaryPart.Position,plr.Character.PrimaryPart)
					local BodyVel = Instance.new("BodyVelocity",plr.Character.PrimaryPart)
					BodyVel.Name="BodyVel"
					BodyVel.MaxForce=Vector3.new(math.huge,math.huge,math.huge)
					BodyVel.Velocity=(PeolesField.Position-plr.Character.PrimaryPart.Position+Vector3.new(0,4,0)).Unit*speed
					while (PeolesField.Position-plr.Character.PrimaryPart.Position+Vector3.new(0,4,0)).Magnitude<6 do
						task.wait()
						print("tick1")
					end
					Moved=false
					BodyVel:Destroy()
				elseif InField==true and checkIfPlayerIsInPart(plr,PeolesField)==true then
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
