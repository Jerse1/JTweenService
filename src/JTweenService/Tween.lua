local Lerps = require(script.Parent.Lerps);
local Easings = require(script.Parent.Easings);

local RS = game:GetService("RunService");

local Heartbeat = RS.Heartbeat;

local Tween = {};
Tween.__index = Tween;

--// Function that gets called after the Update function to update the values;
function Tween:updateProperties(Alpha : number, Duration : number)
	for Property : string, Values : table in pairs(self.Goals) do
		local tweenFunction = self._tweenFunction;
		
		Alpha = tweenFunction(Alpha);

		self.Instance[Property] = self._Lerps[Property](table.unpack(Values), Alpha)-- Lerps[typeof(v[1])](v[1], v[2], Alpha);
	end
end

--// Function that gets called every frame to update the tween;
function Tween:Update()
	local Duration = self.tweenInfo["Duration"];
	
	if not (os.clock() - self.startTime < Duration) then
		self.Connection:Disconnect();
		self:Destroy();
		return;
	end

	if self.PlaybackState == Enum.PlaybackState.Playing then
		self:updateProperties((os.clock() - self.startTime) / Duration, Duration);
	end
end

--// Destroying the tween by making the table have weak keys so it gets collected by garbage collector;
function Tween:Destroy()
	if self.Connection then self.Connection:Disconnect(); end
	self.__mode = "k";
	setmetatable(self,nil);
	self = nil;
end

function Tween:_Play(Cycle, isReverse)
	self.startTime = self.PlaybackState == Enum.PlaybackState.Paused and (self.startTime + (os.clock() - self.PauseTime)) or os.clock();

	local tweenInfo = self.tweenInfo;

	self._tweenFunction = Easings[tweenInfo["EasingStyle"] or "Linear"];

	self._tweenFunction = self._tweenFunction[tweenInfo["EasingDirection"] or "In" or "Out"];

	for Property, Values in pairs(self.Goals) do
		self.Lerps[Property] = Lerps[Property];
	end
	
	if tweenInfo.DelayTime and type(tweenInfo.DelayTime) == "number" and tweenInfo.DelayTime > 0 then
		self.PlaybackState = Enum.PlaybackState.Delayed;

		task.wait(tweenInfo.DelayTime);
	end
	
	for i,v in pairs(self.Goals) do
		self.Goals[i] = {self.Instance[i], self.Goals[i][2]};
	end

	self.Connection = Heartbeat:Connect(function()
		self:Update();
	end)

	self.PlaybackState = Enum.PlaybackState.Playing;
end

function Tween:Play()
	Tween:_Play();
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

return Tween;