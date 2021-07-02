local Lerps = require(script.Parent.Lerps);
local Easings = require(script.Parent.Easings);

local RS = game:GetService("RunService");
local Heartbeat = RS.Heartbeat;

local Tween = {};
Tween.__index = Tween;

--// Function that gets called after the Update function to update the values;
function Tween:updateProperties(Alpha : number, Duration : number)
	for i,v in pairs(self.Goals) do
		Alpha = Easings[self.tweenInfo[2]](Alpha);

		self.Instance[i] = Lerps[typeof(v[1])](v[1], v[2], Alpha);
	end
end

--// Function that gets called every frame to update the tween;
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

--// Destroying the tween by making the table have weak keys so it gets collected by garbage collector;
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

	for i,v in pairs(self.Goals) do
		self.Goals[i] = {self.Instance[i], self.Goals[i][2]};
	end
end

return Tween;