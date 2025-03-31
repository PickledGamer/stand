local billsPlanet = 5151400895
local earthPlanet = 3311165597

local abbreviations = {
	"K",
	"M",
	"B",
	"T",
	"Qd",
	"Qn",
	"Sx",
	"Sp",
	"Oc",
	"No",
	"De",
	"uDe",
	"dDe",
	"tDe",
	"QdD",
	"QnD",
	"SxD",
	"SpD",
	"oDe",
	"nDe",
	"Vg",
	"uVg",
	"dVg",
	"tVg",
	"QdV",
	"QnV",
	"SxV",
	"SpV",
	"ocV",
	"noV",
}
repeat wait() until game.Players.LocalPlayer
if game.PlaceId ~= billsPlanet and game.PlaceId ~= earthPlanet then
	return
end
local p = game.Players.LocalPlayer
local rep = game.ReplicatedStorage
local RUNSERV = game:GetService("RunService")
local HTTPSERV = game:GetService("HttpService")
local TPSERV = game:GetService("TeleportService")
local PLRSERV = game:GetService("Players")
local justStarted = true

local promptOverlay = game.CoreGui:WaitForChild("RobloxPromptGui"):WaitForChild("promptOverlay")
local over1Plr = false

PlaceId, JobId = game.PlaceId, game.JobId

RUNSERV:BindToRenderStep("CheckPlrCount", 2, function() if #PLRSERV:GetPlayers() <= 1 then over1Plr = false else over1Plr = true end end)

promptOverlay.ChildAdded:Connect(function(theChildAddedInQuestion)
	if theChildAddedInQuestion and theChildAddedInQuestion.Name == "ErrorPrompt" then
		RUNSERV:UnbindFromRenderStep("CheckPlrCount")
		repeat
			if not over1Plr then
				TPSERV:Teleport(PlaceId, p)
			else
				TPSERV:TeleportToPlaceInstance(PlaceId, JobId, p)
			end
			wait(2)
		until false
	end
end)

local earthTPVal = "Earth"
local billsTPVal = "Vills Planet"

local startingTimes = 0
local executing = false

local mainRunName = "MainAutoFarmThingy"
local saveFileName = "DBUAutoScript.DATA"
local link = "https://raw.githubusercontent.com/PickledGamer/stand/main/DBU%20AutoFarmV5.lua"

if workspace:FindFirstChild("AutoFarmActivated") then
	justStarted = false
	local afaa = Instance.new("BoolValue", workspace)
	afaa.Name = "AutoFarmAlreadyActive"
	afaa.Value = false
	RUNSERV:UnbindFromRenderStep(mainRunName)
	workspace.AutoFarmActivated:Destroy()
	for i,v in pairs(game.CoreGui:GetChildren()) do
		if v.Name == "AutoFarmGuiBruh" or v.Name == "AntiAFKGuiBruh" or v.Name == "BossHealthBar" then
			v:Destroy()
		end
	end
	for i,v in pairs(workspace:GetChildren()) do
		if v.Name == "RunningAutoValue" or v.Name == "HBossValue" or v.Name == "RebirthValue" or v.Name == "TeleportValue" then
			v:Destroy()
		end
	end
end

function vtype(o, t)
    if o == nil then return false end
    if type(o) == "userdata" then return typeof(o) == t end
    return type(o) == t
end

local writefile = type(writefile) == "function" and function(file, data, safe)
    if safe == true then return pcall(writefile, file, data) end
    writefile(file, data)
end

local readfile = type(readfile) == "function" and function(file, safe)
    if safe == true then return pcall(readfile, file) end
    return readfile(file)
end

local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)


function writefileExploit()
	if writefile then
		return true
	end
end

function readfileExploit()
	if readfile then
		return true
	end
end

function queueTP()
	if queueteleport then
		return true
	end
end

local hasTeleported = false
local tpTimer = 200

function save()
	local dataToSave = {}
	if workspace:FindFirstChild("RunningAutoValue") then
		dataToSave.RunningAutoValue = workspace.RunningAutoValue.Value
	end
	if workspace:FindFirstChild("HBossValue") then
		dataToSave.HBossValue = workspace.HBossValue.Value
	end
	if workspace:FindFirstChild("RebirthValue") then
		dataToSave.RebirthValue = workspace.RebirthValue.Value
	end
	if workspace:FindFirstChild("TeleportValue") then
		dataToSave.TeleportValue = workspace.TeleportValue.Value
	end
	dataToSave.hasTeleported = hasTeleported
	local encodedData = HTTPSERV:JSONEncode(dataToSave)
	if writefileExploit() then
		writefile(saveFileName, encodedData, true)
	end
end

function load()
	if readfileExploit() then
		local readSuccess, out = readfile(saveFileName, true)
		if readSuccess then
			if out ~= nil and tostring(out):gsub("%s","") ~= "" then
				local success, response = pcall(function()
					local json = HTTPSERV:JSONDecode(out)
					if vtype(json.RunningAutoValue, "boolean") then
						if workspace:FindFirstChild("RunningAutoValue") then
							workspace:FindFirstChild("RunningAutoValue").Value = json.RunningAutoValue
						end
					end
					if vtype(json.HBossValue, "boolean") then
						if workspace:FindFirstChild("HBossValue") then
							workspace:FindFirstChild("HBossValue").Value = json.HBossValue
						end
					end
					if vtype(json.RebirthValue, "boolean") then
						if workspace:FindFirstChild("RebirthValue") then
							workspace:FindFirstChild("RebirthValue").Value = json.RebirthValue
						end
					end
					if vtype(json.TeleportValue, "boolean") then
						if workspace:FindFirstChild("TeleportValue") then
							workspace:FindFirstChild("TeleportValue").Value = json.TeleportValue
						end
					end
					if vtype(json.hasTeleported, "boolean") then
						hasTeleported = json.hasTeleported
					end				
				end)
				if not success then
					warn(response)
				end
			end
		end
	end
end

p.OnTeleport:Connect(function()
	if queueTP() then
		local strinssg = "loadstring(game:HttpGet('"..link.."'))"
		queueteleport(strinssg)
	end
end)

local dat = rep:WaitForChild("Datas")
local num = 1
local kbnum = 1
local formattempts = 0
local UsableForm = "None"
local boss = "Klirin"
local npc = "Klirin"
local useSkill = false
local useMSkill = false
local skills = {
	["Energy Volley"] = {
		["req"] = 4000,
		["cooldown"] = 5.5,
		["subname"] = "voleys",
		["timer"] = 0
	}
}
local mskills = {
	["Meteor Crash"] = {
		["req"] = 28000,
		["cooldown"] = 5.5,
		["timer"] = 0
	},
	["High Power Rush"] = {
		["req"] = 65000,
		["cooldown"] = 5.5,
		["timer"] = 0
	},
	["Mach Kick"] = {
		["req"] = 90000,
		["cooldown"] = 5.5,
		["timer"] = 0
	},
	["Spirit Breaking Cannon"] = {
		["req"] = 200000,
		["cooldown"] = 5.5,
		["timer"] = 0
	},
	["Super Dragon Fist"] = {
		["req"] = 50000000,
		["cooldown"] = 5.5,
		["timer"] = 0
	},
	["Spirit Barrage"] = {
		["req"] = 60000000,
		["cooldown"] = 5.5,
		["timer"] = 0
	},
}
local enemyModel = nil
local afa = Instance.new("BoolValue", workspace)
afa.Name = "AutoFarmActivated"
afa.Value = false
local Running = Instance.new("BoolValue", workspace)
Running.Name = "RunningAutoValue"
Running.Value = false
local run = false
local justRebirthed = false
local HB = Instance.new("BoolValue", workspace)
HB.Name = "HBossValue"
HB.Value = false
local RB = Instance.new("BoolValue", workspace)
RB.Name = "RebirthValue"
RB.Value = false
local TPV = Instance.new("BoolValue", workspace)
TPV.Name = "TeleportValue"
TPV.Value = false
local HBoss = false
local Rebirth = false
local Fighting = false
local Transportation = false

load()
if game.PlaceId == earthPlanet and justStarted then
	wait(2)
	game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("Start"):InvokeServer()
	p.Character:WaitForChild("Humanoid").Health = 0
	hasTeleported = false
end
Running:GetPropertyChangedSignal("Value"):Connect(function()
	save()
end)

HB:GetPropertyChangedSignal("Value"):Connect(function()
	save()
end)

RB:GetPropertyChangedSignal("Value"):Connect(function()
	save()
end)

TPV:GetPropertyChangedSignal("Value"):Connect(function()
	save()
end)

local ba=Instance.new("ScreenGui")
local ca=Instance.new("TextLabel")
local da=Instance.new("Frame")
local _b=Instance.new("TextLabel")
local ab=Instance.new("TextLabel")
ba.Parent=game.CoreGui
ba.Name = "AntiAFKGuiBruh"
ba.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;
ca.Parent=ba;
ca.Active=true
ca.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)
ca.Draggable=true
ca.Position=UDim2.new(0.8,0,0.1,0)
ca.Size=UDim2.fromScale(0.2,0.085)
ca.Font=Enum.Font.SourceSansSemibold;
ca.Text="Anti Afk"
ca.TextColor3=Color3.new(0,1,1)
ca.TextSize=22;
ca.TextScaled = true
da.Parent=ca
da.BackgroundColor3=Color3.new(0.196078,0.196078,0.196078)
da.Position=UDim2.new(0,0,1,0)
da.Size=UDim2.fromScale(1,2)
_b.Parent=da
_b.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)
_b.Position=UDim2.new(0,0,0.8,0)
_b.Size=UDim2.fromScale(1,0.2)
_b.Font=Enum.Font.Arial;
if p then
	_b.Text="In Use By " .. p.Name
else
	_b.Text="In Use By " .. "YOU"
end
_b.TextColor3=Color3.new(0,1,1)
_b.TextSize=20;
_b.TextScaled = true
ab.Parent=da
ab.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)
ab.Position=UDim2.new(0,0,0.16,0)
ab.Size=UDim2.fromScale(1,0.4)
ab.Font=Enum.Font.ArialBold;
ab.Text="Roblox is being nice and not making you idle"
ab.TextColor3=Color3.new(0,1,1)
ab.TextSize=20;
ab.TextScaled = true
local bb=game:service'VirtualUser'

game:service'Players'.LocalPlayer.Idled:connect(function()
bb:CaptureController()
bb:ClickButton2(Vector2.new())
ab.Text="Roblox has indeed made you go idle... fuck em"
wait(5)
ab.Text="Roblox is fucking retarded... they tried to kick you, but i stopped them :)"
end)


--local ba=Instance.new("ScreenGui")
--local ca=Instance.new("TextLabel")
--local da=Instance.new("Frame")
--local _b=Instance.new("TextLabel")
--local ab=Instance.new("TextLabel")


-- Stats GUI
-- Instances:

local BossHealthBar = Instance.new("ScreenGui")
local MainBar = Instance.new("Frame")
local GreenBar = Instance.new("Frame")
local BossHealthText = Instance.new("TextLabel")
local BossNameText = Instance.new("TextLabel")

BossHealthBar.Parent = game.CoreGui
BossHealthBar.Name = "BossHealthBar"
BossHealthBar.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainBar.Parent = BossHealthBar
MainBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
MainBar.BackgroundTransparency = 1.000
MainBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainBar.BorderSizePixel = 0
MainBar.Position = UDim2.new(0.25, 0, -0.02, 0)
MainBar.Size = UDim2.new(0.5, 0, 0.02, 0)

GreenBar.Parent = MainBar
GreenBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
GreenBar.BackgroundTransparency = 1.000
GreenBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
GreenBar.BorderSizePixel = 0
GreenBar.Position = UDim2.new(0, 0, 0, 0)
GreenBar.Size = UDim2.new(1, 0, 1, 0)

BossHealthText.Parent = MainBar
BossHealthText.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
BossHealthText.BackgroundTransparency = 1.000
BossHealthText.BorderColor3 = Color3.fromRGB(0, 0, 0)
BossHealthText.BorderSizePixel = 0
BossHealthText.Position = UDim2.new(0, 0, 0, 0)
BossHealthText.Size = UDim2.new(1, 0, 1, 0)
BossHealthText.Font = Enum.Font.SourceSans
BossHealthText.Text = "Waiting On Boss"
BossHealthText.TextColor3 = Color3.fromRGB(255, 255, 255)
BossHealthText.TextScaled = true
BossHealthText.TextSize = 14.000
BossHealthText.TextStrokeTransparency = 0.000
BossHealthText.TextWrapped = true

BossNameText.Parent = MainBar
BossNameText.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
BossNameText.BackgroundTransparency = 1.000
BossNameText.BorderColor3 = Color3.fromRGB(0, 0, 0)
BossNameText.BorderSizePixel = 0
BossNameText.Position = UDim2.new(0, 0, 1, 0)
BossNameText.Size = UDim2.new(1, 0, 2, 0)
BossNameText.Font = Enum.Font.SourceSans
BossNameText.Text = ""
BossNameText.TextColor3 = Color3.fromRGB(255, 255, 255)
BossNameText.TextScaled = true
BossNameText.TextSize = 14.000
BossNameText.TextStrokeTransparency = 0.000
BossNameText.TextWrapped = true

-- kjahsdkjasjkdhaskjdhakjsdhakjsdohadkjh

local ScreenGui = Instance.new("ScreenGui")
local TextLabel = Instance.new("TextLabel")
local Frame = Instance.new("Frame")
local TextLabel_2 = Instance.new("TextLabel")
local TextLabel_3 = Instance.new("TextLabel")
local TextLabel_4 = Instance.new("TextLabel")
local TextLabel_5 = Instance.new("TextLabel")
local TextLabel_6 = Instance.new("TextLabel")
local Frame_2 = Instance.new("Frame")
local Frame_3 = Instance.new("Frame")
local Frame_4 = Instance.new("Frame")
local Frame_5 = Instance.new("Frame")
local Frame_6 = Instance.new("Frame")
local TextButton = Instance.new("TextButton")
local TextLabel_7 = Instance.new("TextLabel")
local TextButton_2 = Instance.new("TextButton")
local TextLabel_8 = Instance.new("TextLabel")
local TextButton_3 = Instance.new("TextButton")
local TextLabel_9 = Instance.new("TextLabel")
local TextButton_4 = Instance.new("TextButton")
local TextLabel_10 = Instance.new("TextLabel")

--Properties:

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "AutoFarmGuiBruh"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

TextLabel.Parent = ScreenGui
TextLabel.Active = true
TextLabel.Draggable = true
TextLabel.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
TextLabel.BackgroundTransparency = 0.500
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.85, 0, 0.5, 0)
TextLabel.Size = UDim2.new(0.150000006, 0, 0.100000001, 0)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Stats"
TextLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

Frame_2.Parent = TextLabel
Frame_2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Frame_2.BackgroundTransparency = 1.000
Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0, 0, -1.2, 0)
Frame_2.Size = UDim2.new(1, 0, 0.9, 0)

Frame_3.Parent = Frame_2
Frame_3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Frame_3.BackgroundTransparency = 0.400
Frame_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_3.BorderSizePixel = 0
Frame_3.Position = UDim2.new(0.5, 0, 0, 0)
Frame_3.Size = UDim2.new(0.5, 0, 0.3, 0)

Frame_4.Parent = Frame_2
Frame_4.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Frame_4.BackgroundTransparency = 0.400
Frame_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_4.BorderSizePixel = 0
Frame_4.Position = UDim2.new(0.5, 0, 0.3, 0)
Frame_4.Size = UDim2.new(0.5, 0, 0.3, 0)

Frame_5.Parent = Frame_2
Frame_5.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Frame_5.BackgroundTransparency = 0.400
Frame_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_5.BorderSizePixel = 0
Frame_5.Position = UDim2.new(0.5, 0, 0.6, 0)
Frame_5.Size = UDim2.new(0.5, 0, 0.3, 0)

Frame_6.Parent = Frame_2
Frame_6.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Frame_6.BackgroundTransparency = 0.400
Frame_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_6.BorderSizePixel = 0
Frame_6.Position = UDim2.new(0.5, 0, 0.9, 0)
Frame_6.Size = UDim2.new(0.5, 0, 0.3, 0)

TextButton.Parent = Frame_3
TextButton.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
TextButton.BackgroundTransparency = 0.400
TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Size = UDim2.new(0.5, 0, 1, 0)
TextButton.Font = Enum.Font.FredokaOne
TextButton.Text = "Off"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextScaled = true
TextButton.TextSize = 14.000
TextButton.TextStrokeTransparency = 0.000
TextButton.TextWrapped = true

TextLabel_7.Parent = Frame_2
TextLabel_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_7.BackgroundTransparency = 1.000
TextLabel_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_7.BorderSizePixel = 0
TextLabel_7.Size = UDim2.new(0.5, 0, 0.3, 0)
TextLabel_7.Font = Enum.Font.FredokaOne
TextLabel_7.Text = "Auto On/Off"
TextLabel_7.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_7.TextScaled = true
TextLabel_7.TextSize = 14.000
TextLabel_7.TextStrokeTransparency = 0.000
TextLabel_7.TextWrapped = true
TextLabel_7.Position = UDim2.new(0, 0, 0, 0)

TextButton_2.Parent = Frame_4
TextButton_2.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
TextButton_2.BackgroundTransparency = 0.400
TextButton_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton_2.BorderSizePixel = 0
TextButton_2.Size = UDim2.new(0.5, 0, 1, 0)
TextButton_2.Font = Enum.Font.FredokaOne
TextButton_2.Text = "Off"
TextButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_2.TextScaled = true
TextButton_2.TextSize = 14.000
TextButton_2.TextStrokeTransparency = 0.000
TextButton_2.TextWrapped = true

TextLabel_8.Parent = Frame_2
TextLabel_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_8.BackgroundTransparency = 1.000
TextLabel_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_8.BorderSizePixel = 0
TextLabel_8.Size = UDim2.new(0.5, 0, 0.3, 0)
TextLabel_8.Font = Enum.Font.FredokaOne
TextLabel_8.Text = "Rebirth On/Off"
TextLabel_8.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_8.TextScaled = true
TextLabel_8.TextSize = 14.000
TextLabel_8.TextStrokeTransparency = 0.000
TextLabel_8.TextWrapped = true
TextLabel_8.Position = UDim2.new(0, 0, 0.3, 0)

TextButton_3.Parent = Frame_5
TextButton_3.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
TextButton_3.BackgroundTransparency = 0.400
TextButton_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton_3.BorderSizePixel = 0
TextButton_3.Size = UDim2.new(0.5, 0, 1, 0)
TextButton_3.Font = Enum.Font.FredokaOne
TextButton_3.Text = "Off"
TextButton_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_3.TextScaled = true
TextButton_3.TextSize = 14.000
TextButton_3.TextStrokeTransparency = 0.000
TextButton_3.TextWrapped = true

TextLabel_9.Parent = Frame_2
TextLabel_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_9.BackgroundTransparency = 1.000
TextLabel_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_9.BorderSizePixel = 0
TextLabel_9.Size = UDim2.new(0.5, 0, 0.3, 0)
TextLabel_9.Font = Enum.Font.FredokaOne
TextLabel_9.Text = "HBoss On/Off"
TextLabel_9.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_9.TextScaled = true
TextLabel_9.TextSize = 14.000
TextLabel_9.TextStrokeTransparency = 0.000
TextLabel_9.TextWrapped = true
TextLabel_9.Position = UDim2.new(0, 0, 0.6, 0)

TextButton_4.Parent = Frame_6
TextButton_4.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
TextButton_4.BackgroundTransparency = 0.400
TextButton_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton_4.BorderSizePixel = 0
TextButton_4.Size = UDim2.new(0.5, 0, 1, 0)
TextButton_4.Font = Enum.Font.FredokaOne
TextButton_4.Text = "Off"
TextButton_4.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_4.TextScaled = true
TextButton_4.TextSize = 14.000
TextButton_4.TextStrokeTransparency = 0.000
TextButton_4.TextWrapped = true

TextLabel_10.Parent = Frame_2
TextLabel_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_10.BackgroundTransparency = 1.000
TextLabel_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_10.BorderSizePixel = 0
TextLabel_10.Size = UDim2.new(0.5, 0, 0.3, 0)
TextLabel_10.Font = Enum.Font.FredokaOne
TextLabel_10.Text = "TP On/Off"
TextLabel_10.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_10.TextScaled = true
TextLabel_10.TextSize = 14.000
TextLabel_10.TextStrokeTransparency = 0.000
TextLabel_10.TextWrapped = true
TextLabel_10.Position = UDim2.new(0, 0, 0.9, 0)


Frame.Parent = TextLabel
Frame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
Frame.BackgroundTransparency = 0.500
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0, 0, 1, 0)
Frame.Size = UDim2.new(1, 0, 4, 0)

TextLabel_2.Parent = Frame
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 0.500
TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.Size = UDim2.new(1, 0, 0.200000003, 0)
TextLabel_2.Font = Enum.Font.SourceSans
TextLabel_2.Text = "Strength: Undefined"
TextLabel_2.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 14.000
TextLabel_2.TextWrapped = true

TextLabel_3.Parent = Frame
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 0.500
TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_3.Position = UDim2.new(0, 0, 0.200000003, 0)
TextLabel_3.Size = UDim2.new(1, 0, 0.200000003, 0)
TextLabel_3.Font = Enum.Font.SourceSans
TextLabel_3.Text = "Speed: Undefined"
TextLabel_3.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_3.TextScaled = true
TextLabel_3.TextSize = 14.000
TextLabel_3.TextWrapped = true

TextLabel_4.Parent = Frame
TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.BackgroundTransparency = 0.500
TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_4.Position = UDim2.new(0, 0, 0.400000006, 0)
TextLabel_4.Size = UDim2.new(1, 0, 0.200000003, 0)
TextLabel_4.Font = Enum.Font.SourceSans
TextLabel_4.Text = "Defense: Undefined"
TextLabel_4.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_4.TextScaled = true
TextLabel_4.TextSize = 14.000
TextLabel_4.TextWrapped = true

TextLabel_5.Parent = Frame
TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_5.BackgroundTransparency = 0.500
TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_5.Position = UDim2.new(0, 0, 0.600000024, 0)
TextLabel_5.Size = UDim2.new(1, 0, 0.200000003, 0)
TextLabel_5.Font = Enum.Font.SourceSans
TextLabel_5.Text = "Energy: Undefined"
TextLabel_5.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_5.TextScaled = true
TextLabel_5.TextSize = 14.000
TextLabel_5.TextWrapped = true

TextLabel_6.Parent = Frame
TextLabel_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_6.BackgroundTransparency = 0.500
TextLabel_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_6.Position = UDim2.new(0, 0, 0.800000012, 0)
TextLabel_6.Size = UDim2.new(1, 0, 0.200000003, 0)
TextLabel_6.Font = Enum.Font.SourceSans
TextLabel_6.Text = "Rebirths: Undefined"
TextLabel_6.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_6.TextScaled = true
TextLabel_6.TextSize = 14.000
TextLabel_6.TextWrapped = true

TextButton.Activated:Connect(function()
	if not Running.Value then
		Running.Value = true
	else	
		Running.Value = false
	end
end)

TextButton_2.Activated:Connect(function()
	if not RB.Value then
		RB.Value = true
	else
		RB.Value = false
	end
end)

TextButton_3.Activated:Connect(function()
	if not HB.Value then
		HB.Value = true
	else
		HB.Value = false
	end
end)

TextButton_4.Activated:Connect(function()
	if not TPV.Value then
		TPV.Value = true
	else
		TPV.Value = false
	end
end)

function Short(val)
	if val <= 999 then
		return tostring(tonumber(val))
	end
	local thing1 = "1e"
	local ab = 1
	local thing2 = 3
	local newStr = ""
	while wait() do
		if val >= tonumber(thing1..thing2) and val <= tonumber(thing1..thing2+3) then
			newStr = tostring(val/tonumber(thing1..thing2))
			local getrid = 4
			if val >= tonumber(thing1..thing2+2) then
				getrid += 2
			elseif val >= tonumber(thing1..thing2+1) then
				getrid += 1
			end
			newStr = string.sub(newStr, 1, getrid)..abbreviations[ab]
			return newStr
		elseif val > tonumber(thing1..thing2+3) then
			thing2 += 3
			ab += 1
		end
	end
end

function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

function getZeni()
	local plrData = dat[p.UserId]
	return plrData.Zeni.Value
end
function CalcRebCost()
	local plrData = dat[p.UserId]
	if HBoss then
		return 500000 + (500000 * plrData.Rebirth.Value)
	else
		return 500000 + (1000000 * plrData.Rebirth.Value)
	end
	--[[
	if plrData.Rebirth.Value < 10 then
		return 1000000 + (1000000 * plrData.Rebirth.Value)
	else
		return 10000000 + ((plrData.Rebirth.Value-9)*2000000)
	end
	]]
end

function UpdateGUI()
	local plrData = dat[p.UserId]
	local charStats = workspace.Living:WaitForChild(p.Name):WaitForChild("Stats")
	if plrData.Strength.Value == charStats.Strength.Value then
		TextLabel_2.Text = "Strength: " .. comma_value(math.round(plrData.Strength.Value))
	else
		TextLabel_2.Text = "Strength: " .. comma_value(math.round(plrData.Strength.Value)) .. " +(" .. comma_value(math.round(charStats.Strength.Value - plrData.Strength.Value)) .. ")"
	end
	if plrData.Strength.Value == charStats.Strength.Value then
		TextLabel_3.Text = "Speed: " .. comma_value(math.round(plrData.Speed.Value))
	else
		TextLabel_3.Text = "Speed: " .. comma_value(math.round(plrData.Speed.Value)) .. " +(" .. comma_value(math.round(charStats.Speed.Value - plrData.Speed.Value)) .. ")"
	end
	if plrData.Strength.Value == charStats.Strength.Value then
		TextLabel_4.Text = "Defense: " .. comma_value(math.round(plrData.Defense.Value))
	else
		TextLabel_4.Text = "Defense: " .. comma_value(math.round(plrData.Defense.Value)) .. " +(" .. comma_value(math.round(charStats.Defense.Value - plrData.Defense.Value)) .. ")"
	end
	if plrData.Strength.Value == charStats.Strength.Value then
		TextLabel_5.Text = "Energy: " .. comma_value(math.round(plrData.Energy.Value))
	else
		TextLabel_5.Text = "Energy: " .. comma_value(math.round(plrData.Energy.Value)) .. " +(" .. comma_value(math.round(charStats.Energy.Value - plrData.Energy.Value)) .. ")"
	end
	TextLabel_6.Text = "Rebirths: " .. comma_value(math.round(plrData.Rebirth.Value)) .. "\n Rebirth Cost: " .. comma_value(math.round(CalcRebCost()))
	if Running.Value then
		MainBar.Visible = true
		if game.ReplicatedStorage.Datas[p.UserId].Quest.Value ~= boss then
			BossNameText.Text = ""
			MainBar.BackgroundTransparency = 1.000
			GreenBar.BackgroundTransparency = 1.000
			BossHealthText.Text = "Waiting On Boss"
			workspace.Gravity = 196.2
		else
			BossNameText.Text = npc
			MainBar.BackgroundTransparency = 0.000
			GreenBar.BackgroundTransparency = 0.000
			if workspace.Living:FindFirstChild(npc) and workspace.Living[npc]:FindFirstChild("Humanoid") then
				local percentage = workspace.Living[npc].Humanoid.Health/workspace.Living[npc].Humanoid.MaxHealth
				GreenBar.Size = UDim2.fromScale(percentage,1)
				BossHealthText.Text = math.round(percentage*100).."% Health: ".. Short(math.round(workspace.Living[npc].Humanoid.Health)) .. " / " .. Short(math.round(workspace.Living[npc].Humanoid.MaxHealth))
			end
			workspace.Gravity = 0
		end
		TextButton.Position = UDim2.fromScale(0.5,0)
		TextButton.Text = "On"
		Frame_3.BackgroundColor3 = Color3.new(0,1,0)
	else
		MainBar.Visible = false
		workspace.Gravity = 196.2
		TextButton.Position = UDim2.fromScale(0,0)
		TextButton.Text = "Off"
		Frame_3.BackgroundColor3 = Color3.new(1,0,0)
	end
	if RB.Value then
		TextButton_2.Position = UDim2.fromScale(0.5,0)
		TextButton_2.Text = "On"
		Frame_4.BackgroundColor3 = Color3.new(0,1,0)
	else
		TextButton_2.Position = UDim2.fromScale(0,0)
		TextButton_2.Text = "Off"
		Frame_4.BackgroundColor3 = Color3.new(1,0,0)
	end
	if HB.Value then
		TextButton_3.Position = UDim2.fromScale(0.5,0)
		TextButton_3.Text = "On"
		Frame_5.BackgroundColor3 = Color3.new(0,1,0)
	else
		TextButton_3.Position = UDim2.fromScale(0,0)
		TextButton_3.Text = "Off"
		Frame_5.BackgroundColor3 = Color3.new(1,0,0)
	end
	if TPV.Value then
		TextButton_4.Position = UDim2.fromScale(0.5,0)
		TextButton_4.Text = "On"
		Frame_6.BackgroundColor3 = Color3.new(0,1,0)
	else
		TextButton_4.Position = UDim2.fromScale(0,0)
		TextButton_4.Text = "Off"
		Frame_6.BackgroundColor3 = Color3.new(1,0,0)
	end
end

function Trans(form)
	local args = {
    		[1] = form
	}

	game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("equipskill"):InvokeServer(unpack(args))
	task.wait(0.5)
	workspace.Living:WaitForChild(p.Name):WaitForChild("HumanoidRootPart")
	game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("ta"):InvokeServer()
	formattempts += 1
	if formattempts > 25 then
		workspace.Living:WaitForChild(p.Name):WaitForChild("Humanoid").Health = 0
	end
end

function ChargeKi()
	local args = {
		[1] = "Blacknwhite27"
	}
		
	game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("cha"):InvokeServer(unpack(args))
	game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("of2"):FireServer()
end

function UseSkill(CFrame)
	if workspace.Living:FindFirstChild(p.Name) and not workspace.Living[p.Name]:FindFirstChild("HumanoidRootPart") then
		return
	end
	useSkill = true
	for i,v in pairs(skills) do
		local args = {
			[1] = i,
			[2] = {
				["FaceMouse"] = true,
				["MouseHit"] = CFrame
			},
			[3] = "Blacknwhite27"
		}
		if v.timer <= 0 and dat[p.UserId].Energy.Value > v.req and Fighting then
			v.timer = v.cooldown
			spawn(function() for i = 1, 999 do if v.timer <= 0 then return end wait(0.01) v.timer -= 0.01 end end)
			game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild(v.subname):InvokeServer(unpack(args))
		else
			useSkill = false
		end
	end
end

function UseMSkill()
	if workspace.Living:FindFirstChild(p.Name) and not workspace.Living[p.Name]:FindFirstChild("HumanoidRootPart") then
		return
	end
	useMSkill = true
	for i,v in pairs(mskills) do
		local args = {
			[1] = i,
			[2] = "Blacknwhite27"
		}
		if v.timer <= 0 and dat[p.UserId].Strength.Value > v.req and dat[p.UserId].Speed.Value > v.req and Fighting then
			v.timer = v.cooldown
			spawn(function() for i = 1, 999 do if v.timer <= 0 then return end wait(0.01) v.timer -= 0.01 end end)
			game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("mel"):InvokeServer(unpack(args))
		else
			useMSkill = false
		end
	end
end

function getEnemy(val)
	for i, v in pairs(workspace.Living:GetChildren()) do
		if v and v.Name == val then
			if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
				return v
			end
		end
	end
	return false
end

function StartAuto()
	while Running.Value do
		if workspace:FindFirstChild("AutoFarmAlreadyActive") then
			break
		end
		task.wait()
		if workspace.Living:WaitForChild(p.Name):WaitForChild("Humanoid").Health > 0 then
			if justRebirthed == true then
				for i = 1, 5 do
					task.wait(0.25)
					local args = {
						[1] = "Blacknwhite27",
						[2] = num,
						[3] = false
					}

					game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("p"):FireServer(unpack(args))
				end
				justRebirthed = false
			end
			if UsableForm ~= "None" and p.Status.Transformation.Value ~= UsableForm then
				if workspace.Living:WaitForChild(p.Name):WaitForChild("Humanoid").Health > 0 then
					repeat
						if workspace:FindFirstChild("AutoFarmAlreadyActive") or Running.Value == false then
							break
						end
						task.wait(0.5)
						spawn(function()
							Trans(UsableForm)
						end)
					until p.Status.Transformation.Value == UsableForm or workspace.Living:WaitForChild(p.Name):WaitForChild("Humanoid").Health <= 0 or workspace:FindFirstChild("AutoFarmAlreadyActive")
					formattempts = 0
				end
			end
			if boss == "Wukong" then
				npc = "Oozaru"
			elseif boss == "X Fighter Trainer" then
				npc = "X Fighter"
			elseif boss == "Top X Fighter" then
				npc = "X Fighter Master"
			else
				npc = boss
			end
			if game.ReplicatedStorage.Datas[p.UserId].Quest.Value == boss or game.ReplicatedStorage.Datas[p.UserId].Quest.Value == npc or npc == "Wukong Black" then
				local v
				if getEnemy(npc) then
					v = getEnemy(npc)
				end
				if v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
					if v:FindFirstChild("HumanoidRootPart") then
						enemyModel = v
						local continuing = true
						repeat
							if workspace:FindFirstChild("AutoFarmAlreadyActive") or Running.Value == false then
								enemyModel = nil
								break
							end
							task.wait()
							Fighting = true
							spawn(function()
								if v:FindFirstChild("HumanoidRootPart") then
									UseSkill(v.HumanoidRootPart.CFrame)
								end
								useSkill = false
							end)
							spawn(function()
								if not useSkill then 
									UseMSkill()
									useMSkill = false
								end
							end)
							spawn(function()
								if v:FindFirstChild("Humanoid") and (v.Humanoid.Health/v.Humanoid.MaxHealth)*100 <= 90 then
									if v.Humanoid.BreakJointsOnDeath == true then
										v.Humanoid.BreakJointsOnDeath = false
									end
									if v.Humanoid.RequiresNeck == false then
										v.Humanoid.RequiresNeck = true
									end
									if v:FindFirstChild("Head") and v.Head:FindFirstChild("Neck") then
										if v.Head.Neck.Enabled == true then
											v.Head.Neck.Enabled = false
										else
											v.Head.Neck:Destroy()
										end
									end
								end
							end)
							spawn(function()
								--if not useMSkill then
									game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27", 1)
								--end
							end)
							spawn(function()
								ChargeKi()
							end)
							if v:WaitForChild("Humanoid").Health <= 0 then
								continuing = false
							end
							if boss ~= "Wukong Black" then
								if game.ReplicatedStorage.Datas[p.UserId].Quest.Value == "" or game.ReplicatedStorage.Datas[p.UserId].Quest.Value == nil then
									continuing = false
								end
							end
							if workspace:FindFirstChild("AutoFarmAlreadyActive") then
								continuing = false
							end
						until continuing == false
						enemyModel = nil
						Fighting = false
					else
						if boss == "Wukong Black" then
							for i,v in pairs(workspace.Others.NPCSpawns:WaitForChild("Wukong Black"):GetChildren()) do
								if v:IsA("Part") then
									workspace.Living:WaitForChild(p.Name):WaitForChild("HumanoidRootPart").CFrame = v.CFrame
								end
							end
						else
							if workspace.Others.BossMaps:FindFirstChild(npc) then
								for i,v in pairs(workspace.Others.BossMaps[npc]:GetChildren()) do
									if v:IsA("Model") then
										workspace.Living:WaitForChild(p.Name):WaitForChild("HumanoidRootPart").CFrame = v:GetPivot()
									end
								end
							end
						end
					end
				end
			else
				--if p.Status.Transformation.Value ~= UsableForm and workspace.Living:WaitForChild(p.Name):WaitForChild("Humanoid").Health > 0 then
				--	repeat
				--		print(UsableForm)
				--		task.wait()
				--		Trans(UsableForm)
				--	until p.Status.Transformation.Value == UsableForm
				--	formattempts = 0
				--end
				if boss ~= "Wukong Black" then
					if workspace.Living:FindFirstChild(p.Name) and workspace.Living[p.Name]:FindFirstChild("HumanoidRootPart") then
						local Thing = workspace:WaitForChild("Others"):WaitForChild("NPCs"):WaitForChild(boss)
						local Thing2 = nil
						for i, v in pairs(Thing:GetDescendants()) do
							if v.Name == "TriggerChat" then
								Thing2 = v
							end
						end
						if workspace.Living:FindFirstChild(p.Name) and workspace.Living[p.Name]:FindFirstChild("HumanoidRootPart") then
							workspace.Living[p.Name].HumanoidRootPart.CFrame = Thing2.CFrame
						end
						local args = {
							[1] = Thing
						}
						task.wait(0.25)
						if workspace.Living:FindFirstChild(p.Name) and workspace.Living[p.Name]:FindFirstChild("HumanoidRootPart") then
							game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("Qaction"):InvokeServer(unpack(args))
						end
					end
				end
			end
		end
	end
	run = false
end

function CheckForUntouchable(inp)
	if workspace.Living:FindFirstChild(inp) then
		if workspace.Living[inp]:FindFirstChild("Status") then
			if workspace.Living[inp].Status:FindFirstChild("Untouchable") then
				return true
			else
				return false
			end
		end
	end
end

function mainRunningFunction()
	if p.PlayerGui:FindFirstChild("Start") then
		return
	end
	local things = {"k","m","b","t","qd","qn"}
	local vals = {"1000","1000000","1000000000","1000000000000","1000000000000000","1000000000000000000"}

	function ValCov(inp)
		for i,v in pairs(things) do
			if string.find(inp, v) then
				local stringtonumber = string.gsub(inp, v, "")
				local num = tonumber(stringtonumber) * tonumber(vals[i])
				return num
			end
		end
	end

	local function CheckStats(value, reb)
		local bool = false
		local rebbool = false
		local plrData = dat[p.UserId]
		local num
		if type(value) == "string" then
			num = ValCov(value)
		else
			num = value
		end
		if reb ~= nil then
			if plrData.Rebirth.Value >= reb then
				rebbool = true
			end
		end
		if plrData.Energy.Value >= num and plrData.Defense.Value >= num and plrData.Speed.Value >= num and plrData.Strength.Value >= num then
			bool = true
		end
		if reb == nil then
			return bool
		elseif bool == true and rebbool == true then
			return true
		else
			return false
		end
	end
	if workspace.Living:WaitForChild(p.Name).Stats.Ki.Value < workspace.Living:WaitForChild(p.Name).Stats.MaxKi.Value and Fighting ~= true then
		ChargeKi()
	end
	if Fighting == true then
		if enemyModel ~= nil then
			if enemyModel:FindFirstChild("HumanoidRootPart") and enemyModel:FindFirstChild("Humanoid") then
				if enemyModel.Humanoid.Health > 0 then
					workspace.Living:WaitForChild(p.Name):WaitForChild("HumanoidRootPart").CFrame = enemyModel.HumanoidRootPart.CFrame * CFrame.new(0,0,2)
				end
			end
		end
	end
	if Rebirth and CheckStats(CalcRebCost()) and not justRebirthed then
		game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("reb"):InvokeServer()
		justRebirthed = true
	end
	if p:FindFirstChild("Status") then
		for i,v in pairs(mskills) do
			if not p.Status:FindFirstChild(i) then
				v.timer = 0
			else
				if v.timer <= 0 then
					v.timer += 1
				end
			end
		end
	end
	if workspace:FindFirstChild("HBossValue") then
		HBoss = workspace.HBossValue.Value
	end
	if workspace:FindFirstChild("RebirthValue") then
		Rebirth = workspace.RebirthValue.Value
	end
	if workspace:FindFirstChild("TeleportValue") then
		Transportation = workspace.TeleportValue.Value
	end
	if game.PlaceId == earthPlanet then
		if CheckStats("50b") then
			boss = "Wukong"
		elseif CheckStats("200m") and not CheckForUntouchable("Wukong Black") then
			boss = "Wukong Black"
		elseif CheckStats("37.5m") then
			boss = "SSJG Kakata"
		elseif CheckStats("12.5m") then
			boss = "Broccoli"
		elseif CheckStats("2m") then
			boss = "SSJB Wukong"
		elseif CheckStats("1.25m") then
			boss = "SSJ2 Wukong"
		elseif CheckStats("875k") then
			boss = "Perfect Atom"
		elseif CheckStats("187.5k") then
			boss = "Super Vegetable"
		elseif CheckStats("112.5k") then
			boss = "Top X Fighter"
		elseif CheckStats("65k") then
			boss = "Mapa"
		elseif CheckStats("35k") then
			boss = "Radish"
		elseif CheckStats(0) then
			boss = "X Fighter Trainer"
		end
	elseif game.PlaceId == billsPlanet then
		if CheckStats("1.37b") then
			boss = "Vekuta (SSJBUI)"
		elseif CheckStats("1.25b") then
			boss = "Wukong Rose"
		elseif CheckStats("1.05b") then
			boss = "Vekuta (LBSSJ4)"
		elseif CheckStats("675m") then
			boss = "Wukong (LBSSJ4)"
		elseif CheckStats("450m") then
			boss = "Vegetable (LBSSJ4)"
		elseif CheckStats("250m") then
			boss = "Vis (20%)"
		elseif CheckStats("150m") then
			boss = "Vills (50%)"
		elseif CheckStats("75m") then
			boss = "Wukong (Omen)"
		elseif CheckStats("50m") then
			boss = "Vegetable (GoD in-training)"
		end
	end
	if Transportation and tpTimer <= 0 then
		if game.PlaceId == billsPlanet and not CheckStats("50m") or CheckStats("50b") then
			tpTimer = 200
			hasTeleported = true
			save()
			local args = {
				[1] = earthTPVal
			}
			if workspace.Living:FindFirstChild(p.Name) and workspace.Living[p.Name]:FindFirstChild("HumanoidRootPart") then
				game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("TP"):InvokeServer(unpack(args))
			end
		elseif game.PlaceId == earthPlanet and [[ getZeni() >= ValCov("15k") and]] CheckStats("50m") and not CheckStats("50b") then
			tpTimer = 200
			hasTeleported = true
			save()
			local args = {
				[1] = billsTPVal
			}
			if workspace.Living:FindFirstChild(p.Name) and workspace.Living[p.Name]:FindFirstChild("HumanoidRootPart") then
				game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("TP"):InvokeServer(unpack(args))
			end
		end
	elseif tpTimer > 0 then
		tpTimer -= 1
	end
	--if CheckStats("500m", 50) then
	--	UsableForm = "Ego Instinct"
	if CheckStats("200m",30) and string.find(dat[p.UserId].UnlockedSkills.Value, '"Divine Blue":true') then
		UsableForm = "Divine Blue"
	elseif CheckStats("138m", 28) then
		UsableForm = "Astral Instinct"
	elseif CheckStats("120m", 24) then
		UsableForm = "Beast"
	elseif CheckStats("120m", 20) then
		UsableForm = "SSJBUI"
	elseif CheckStats("100m", 18) then
		UsableForm = "LBSSJ4"
	elseif CheckStats("50m", 12) then
		UsableForm = "SSJB3"
	elseif CheckStats("30m", 10) then
		UsableForm = "God of Creation"
	elseif CheckStats("14m", 6) then
		UsableForm = "Mastered Ultra Instinct"
	elseif CheckStats("8m", 4) then
		UsableForm = "Godly SSJ2"
	elseif CheckStats("5m", 3) then
		UsableForm = "Ultra Instinct Omen"
	elseif CheckStats("3.5m", 2) then
		UsableForm = "Blue Evolution"
	elseif CheckStats("3m", 1) then
		UsableForm = "Kefla SSJ2"
	elseif CheckStats("2.2m") then
		UsableForm = "SSJB Kaioken"
	elseif CheckStats("1.2m") then
		UsableForm = "SSJ Blue"
	elseif CheckStats("700k") then
		UsableForm = "SSJ Rage"
	elseif CheckStats("450k") then
		UsableForm = "SSJG"
	elseif CheckStats("300k") then
		UsableForm = "SSJ4"
	elseif CheckStats("200k") then
		UsableForm = "Mystic"
	elseif CheckStats("140k") then
		UsableForm = "LSSJ"
	elseif CheckStats("95k") then
		UsableForm = "SSJ3"
	elseif CheckStats("65k") then
		UsableForm = "Spirit SSJ"
	elseif CheckStats("34k") then
		UsableForm = "SSJ2"
	elseif CheckStats("16k") then
		UsableForm = "SSJ Kaioken"
	elseif CheckStats("6k") then
		UsableForm = "SSJ"
	elseif CheckStats("2.5k") then
		UsableForm = "FSSJ"
	elseif CheckStats("1k") then
		UsableForm = "Kaioken"
	else
		UsableForm = "None"
	end
	if startingTimes >= 20 and executing ~= true then
		executing = true
		loadstring(game:HttpGet(link))()
	end
	if workspace:FindFirstChild("RunningAutoValue").Value == true and run == false then
		run = true
		print("Started")
		startingTimes += 1
		spawn(function() StartAuto() end)
	end
	if workspace:FindFirstChild("RunningAutoValue").Value == true then
		p.PlayerGui:WaitForChild("Main").MainFrame.Buttons.Visible = false
		p.PlayerGui:WaitForChild("Main").MainFrame.Chat.Visible = false
		for i,v in pairs(p.PlayerGui:WaitForChild("Main").MainFrame.Frames:GetChildren()) do
			if v.Name ~= "Quest" then
				v.Visible = false
			end
		end
		for i,v in pairs(p.PlayerGui:WaitForChild("Main").MainFrame.Indicator:GetChildren()) do
			if v.Name ~= "Zeni" and v:IsA("TextLabel") then
				v.Visible = false
			elseif v.Name == "Zeni" then
				v.Position = UDim2.fromScale(0.01, 0.8)
			end
		end
	else
		p.PlayerGui:WaitForChild("Main").MainFrame.Buttons.Visible = true
		p.PlayerGui:WaitForChild("Main").MainFrame.Chat.Visible = true
		for i,v in pairs(p.PlayerGui:WaitForChild("Main").MainFrame.Indicator:GetChildren()) do
			if v.Name == "Zeni" then
				v.Position = UDim2.fromScale(0.01, 0.645)
			end
		end
	end
	UpdateGUI()
end
wait(2)
if workspace:FindFirstChild("AutoFarmAlreadyActive") then
	workspace.AutoFarmAlreadyActive:Destroy()
end
RUNSERV:BindToRenderStep(mainRunName,1,mainRunningFunction)
