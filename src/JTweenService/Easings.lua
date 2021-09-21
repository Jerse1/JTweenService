local PI = math.pi

local cos = math.cos
local sin = math.sin
local pow = math.pow
local sqrt = math.sqrt


local Easings;

--// Thanks to afrxo#7024 for helping me insert these easings styles

Easings = {
	["Sine"] = {
		["In"] = function(x)
			return 1 - cos((x * PI) / 2);
		end,
		["Out"] = function(x)
			return sin((x * PI) / 2);
		end,
		["InOut"] = function(x)
			return -(cos(PI * x) - 1) / 2;
		end
	},

	["Cubic"] = {
		["In"] = function(x)
			return x * x * x;
		end,
		["Out"] = function(x)
			return 1 - pow(1 - x, 3);
		end,
		["InOut"] = function(x)
			return x < 0.5 and 4 * x * x * x or 1 - pow(-2 * x + 2, 3) / 2;
		end
	},
	
	["Quint"] = {
		["In"] = function(x)
			return x * x * x * x * x;
		end,
		["Out"] = function(x)
			return 1 - pow(1 - x, 5);
		end,
		["InOut"] = function(x)
			return x < 0.5 and 16 * x * x * x * x * x or 1 - pow(-2 * x + 2, 5) / 2;
		end
	},
	["Circ"] = {
		["In"] = function(x)
			return 1 - sqrt(1 - pow(x, 2));
		end,
		["Out"] = function(x)
			return sqrt(1 - pow(x - 1, 2));
		end,
		["InOut"] = function(x)
			return x < 0.5
				and (1 - sqrt(1 - pow(2 * x, 2))) / 2
				or (sqrt(1 - pow(-2 * x + 2, 2)) + 1) / 2;
		end
	},
	["Elastic"] = {
		["In"] = function(x)
			local c4 = (2 * PI) / 3;

			return x == 0
				and 0
				or x == 1
				and 1
				or -pow(2, 10 * x - 10) * sin((x * 10 - 10.75) * c4);
		end,
		["Out"] = function(x)
			local c4 = (2 * PI) / 3;

			return x == 0
				and 0
				or x == 1
				and 1
				or pow(2, -10 * x) * sin((x * 10 - 0.75) * c4) + 1;
		end,
		["InOut"] = function(x)
			local c5 = (2 * PI) / 4.5;

			return x == 0
				and 0
				or x == 1
				and 1
				or x < 0.5
				and -(pow(2, 20 * x - 10) * sin((20 * x - 11.125) * c5)) / 2
				or (pow(2, -20 * x + 10) * sin((20 * x - 11.125) * c5)) / 2 + 1;
		end
	},
	["Quad"] = {
		["In"] = function(x)
			return x * x;
		end,
		["Out"] = function(x)
			return 1 - (1 - x) * (1 - x);
		end,
		["InOut"] = function(x)
			return x < 0.5 and 2 * x * x or 1 - pow(-2 * x + 2, 2) / 2;
		end
	},
	["Quart"] = {
		["In"] = function(x)
			return x * x * x * x;
		end,
		["Out"] = function(x)
			return 1 - pow(1 - x, 4);
		end,
		["InOut"] = function(x)
			return x < 0.5 and 8 * x * x * x * x or 1 - pow(-2 * x + 2, 4) / 2;
		end
	},
	["Expo"] = {
		["In"] = function(x)
			return x == 0 and 0 or pow(2, 10 * x - 10);
		end,
		["Out"] = function(x)
			return x == 1 and 1 or 1 - pow(2, -10 * x);
		end,
		["InOut"] = function(x)
			return x == 0
				and 0
				or x == 1
				and 1
				or x < 0.5 
				and pow(2, 20 * x - 10) / 2
				or (2 - pow(2, -20 * x + 10)) / 2;
		end
	},
	["Back"] = {
		["In"] = function(x)
			local c1 = 1.70158;
			local c3 = c1 + 1;
			return c3 * x * x * x - c1 * x * x;
		end,
		["Out"] = function(x)
			local c1 = 1.70158;
			local c3 = c1 + 1;
			return 1 + c3 * pow(x - 1, 3) + c1 * pow(x - 1, 2);
		end,
		["InOut"] = function(x)
			local c1 = 1.70158;
			local c2 = c1 * 1.525;

			return x < 0.5
				and (pow(2 * x, 2) * ((c2 + 1) * 2 * x - c2)) / 2
				or (pow(2 * x - 2, 2) * ((c2 + 1) * (x * 2 - 2) + c2) + 2) / 2;
		end
	},
	["Bounce"] = {
		["In"] = function(x)
			return 1 - Easings["Bounce"]["Out"](1 - x);
		end,
		["Out"] = function(x)
			local n1 = 7.5625;
			local d1 = 2.75;

			if (x < 1 / d1) then
				return n1 * x * x;
			elseif (x < 2 / d1) then
				return n1 * (x - 1.5 / d1) * x + 0.75;
			elseif (x < 2.5 / d1) then
				return n1 * (x - 2.25 / d1) * x + 0.9375;
			else
				return n1 * (x - 2.625 / d1) * x + 0.984375;
			end
		end,
		["InOut"] = function(x)
			return x < 0.5
				and (1 - Easings["Bounce"]["Out"](1 - 2 * x)) / 2
				and (1 + Easings["Bounce"]["Out"](2 * x - 1)) / 2;
		end
	}
}

return Easings;