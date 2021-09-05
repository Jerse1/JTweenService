local Tween = require(script.Parent.Tween);

local JTweenService = {};
JTweenService.__index = JTweenService;

function JTweenService.new(Instance : Instance, tweenInfo : table, Goals : table)
	assert(Instance, "[JTweenService] : [Instance] argument is missing");
	assert(tweenInfo, "[JTweenService] : [tweenInfo] argument is missing");
	assert(Goals, "[JTweenService] : [Goals] argument is missing");

	for i : string in pairs(Goals) do
		assert(Instance[i], ("[JTweenService] : %s doesn't have a property called \"%s\"."):format(Instance:GetFullName(), i));
		Goals[i] = {Instance[i], Goals[i]};
	end

	return setmetatable({
		PlaybackState = Enum.PlaybackState.Begin,
		Instance = Instance,
		tweenInfo = tweenInfo,
		Goals = Goals
	}, Tween);
end

return JTweenService;