local Easings = require(script.Parent.Easings);

local Types = {
    ['Color3'] = function(Value,Final,Alpha)
        return
    end,
};

return function(Value,Final,Alpha)
    if not (Types[typeof(Value)]) then return; end
    Types[typeof(Value)](Value,Final,Alpha);
end
