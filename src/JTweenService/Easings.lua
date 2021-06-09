return {
	Linear = function(t)
		return t;
	end,

	easeInSine = function(t)
			return 1 - math.cos((t * math.pi) / 2);
	end,

	easeOutSine = function(t)
		return math.sin((t * math.pi) / 2);
	end,

	easeInOutSine = function(t)
		return -(math.cos(math.pi * t) - 1) / 2;
	end,

	
};