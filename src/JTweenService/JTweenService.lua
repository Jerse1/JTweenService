local RS = game:GetService("RunService");
local Heartbeat = RS.Heartbeat;

local Easings = require(script.Parent.Easings);

local JTweenService = {};
JTweenService.__index = JTweenService;

local Tween = {};
Tween.__index = Tween;
--[[
	TODO: Make a switch statement instead of using if's;
	TODO: Add in more Easings & Allow usage of Easing in the tweenInfo array;
	Fyi, I know this is hard to read;
]]
function Tween:updateProperties(Time : number, Duration : number)
	for i,v in pairs(self.Goals) do
		if typeof(v[1]) == "Color3" then 
			local Final = Color3.new(
				Easings["Linear"](Time,v[1].R,v[2].R,Duration),
				Easings["Linear"](Time,v[1].G,v[2].G,Duration),
				Easings["Linear"](Time,v[1].B,v[2].B,Duration));
			self.Instance[i] = Final;
		elseif typeof(v[1]) == "Vector3" then
			local Final = Vector3.new(
				Easings["Linear"](Time,v[1].X,v[2].X,Duration),
				Easings["Linear"](Time,v[1].Y,v[2].Y,Duration),
				Easings["Linear"](Time,v[1].Z,v[2].Z,Duration));
			self.Instance[i] = Final;
		elseif typeof(v[1]) == "CFrame" then
			local Final  = CFrame.new(
				Easings["Linear"](Time,v[1].X,v[2].X,Duration),
				Easings["Linear"](Time,v[1].Y,v[2].Y,Duration),
				Easings["Linear"](Time,v[1].Z,v[2].Z,Duration),
				Easings["Linear"](Time,v[1].Z,v[2].Z,Duration));
		elseif typeof(v[1]) == "number" then
			self.Instance[i] = Easings["Linear"](Time,v[1],v[2],Duration);
		end
	end
end

function Tween:Update()
	local Duration = self.tweenInfo[1];
	if not (os.clock() - self.startTime < Duration) then
		self.Connection:Disconnect();
		self:Destroy();
		return;
	end

	if self.PlaybackState == Enum.PlaybackState.Playing then
		self:updateProperties((os.clock() - self.startTime)/Duration,Duration);
	end
end

function Tween:Destroy()
	if self.Connection then self.Connection:Disconnect(); end
	self.__mode = "k";
	setmetatable(self,nil);
	self = nil;
end

function Tween:Play()
	self.startTime = self.PlaybackState == Enum.PlaybackState.Paused and (self.startTime + (os.clock() - self.PauseTime)) or os.clock();

	self.PlaybackState = Enum.PlaybackState.Playing;

	self.Connection = Heartbeat:Connect(function()
		self:Update();
	end)
end

function Tween:Pause()
	self.PauseTime = os.clock();

	self.PlaybackState = Enum.PlaybackState.Paused;
	self.Connection:Disconnect();
end

function Tween:Cancel()
	self.PlaybackState = Enum.PlaybackState.Cancelled;
	self.Connection:Disconnect();
end

function JTweenService:Create(Instance : Instance, tweenInfo : table, Goals : table)
	assert(Instance,"[JTweenService] : [1] argument is missing");
	assert(tweenInfo,"[JTweenService] : [2] argument is missing");
	assert(Goals,"[JTweenService] : [3] argument is missing");

	for i,v in pairs(Goals) do
		assert(Instance[i],("[JTweenService] : %s doesn't have a property called \"%s\"."):format(Instance:GetFullName(),i));
		Goals[i] = {Instance[i],Goals[i]};
	end

	return setmetatable({
		PlaybackState = Enum.PlaybackState.Begin,
		Instance = Instance,
		tweenInfo = tweenInfo,
		Goals = Goals 

	},Tween);
end

return JTweenService;