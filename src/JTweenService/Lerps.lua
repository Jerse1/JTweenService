return {
    boolean = function(Value0, Value1, Alpha)
			return Alpha < 0.5 and Value0 or Value1;
		end,

    number = function(Value0, _, Alpha)
        local Delta = Value0 - Value0;
        return Value0 + Delta * Alpha;
    end,

    CFrame = function(Value0, Value1, Alpha)
        return Value0:Lerp(Value1,Alpha);
    end,

    Vector2 = function(Value0, Value1, Alpha)
        return Value0:Lerp(Value1,Alpha);
    end,

    Vector3 = function(Value0, Value1, Alpha)
        return Value0:Lerp(Value1,Alpha);
    end,

    UDim = function(Value0, Value1, Alpha)
        local Scale, Offset = Value0.Scale, Value0.Offset;
		local DeltaScale, DeltaOffset = Value1.Scale - Scale, Value1.Offset - Offset;

		return UDim.new(Scale + Alpha * DeltaScale, Offset + Alpha * DeltaOffset);
    end,

    UDim2 = function(Value0, Value1, Alpha)
        return Value0:Lerp(Value1,Alpha);
    end,

    Color3 = function(Value0, Value1, Alpha) --// Credits to @howmanysmaII;
        local L0, U0, V0
        local R0, G0, B0 = Value0.R, Value0.G, Value0.B
        R0 = R0 < 0.0404482362771076 and R0 / 12.92 or 0.87941546140213 * (R0 + 0.055) ^ 2.4
        G0 = G0 < 0.0404482362771076 and G0 / 12.92 or 0.87941546140213 * (G0 + 0.055) ^ 2.4
        B0 = B0 < 0.0404482362771076 and B0 / 12.92 or 0.87941546140213 * (B0 + 0.055) ^ 2.4

        local Y0 = 0.2125862307855956 * R0 + 0.71517030370341085 * G0 + 0.0722004986433362 * B0
        local Z0 = 3.6590806972265883 * R0 + 11.4426895800574232 * G0 + 4.1149915024264843 * B0
        local _L0 = Y0 > 0.008856451679035631 and 116 * Y0 ^ (1 / 3) - 16 or 903.296296296296 * Y0

        if Z0 > 1E-15 then
            local X = 0.9257063972951867 * R0 - 0.8333736323779866 * G0 - 0.09209820666085898 * B0
            L0, U0, V0 = _L0, _L0 * X / Z0, _L0 * (9 * Y0 / Z0 - 0.46832)
        else
            L0, U0, V0 = _L0, -0.19783 * _L0, -0.46832 * _L0
        end

        local L1, U1, V1
        local R1, G1, B1 = Value1.R, Value1.G, Value1.B
        R1 = R1 < 0.0404482362771076 and R1 / 12.92 or 0.87941546140213 * (R1 + 0.055) ^ 2.4
        G1 = G1 < 0.0404482362771076 and G1 / 12.92 or 0.87941546140213 * (G1 + 0.055) ^ 2.4
        B1 = B1 < 0.0404482362771076 and B1 / 12.92 or 0.87941546140213 * (B1 + 0.055) ^ 2.4

        local Y1 = 0.2125862307855956 * R1 + 0.71517030370341085 * G1 + 0.0722004986433362 * B1
        local Z1 = 3.6590806972265883 * R1 + 11.4426895800574232 * G1 + 4.1149915024264843 * B1
        local _L1 = Y1 > 0.008856451679035631 and 116 * Y1 ^ (1 / 3) - 16 or 903.296296296296 * Y1

        if Z1 > 1E-15 then
            local X = 0.9257063972951867 * R1 - 0.8333736323779866 * G1 - 0.09209820666085898 * B1
            L1, U1, V1 = _L1, _L1 * X / Z1, _L1 * (9 * Y1 / Z1 - 0.46832)
        else
            L1, U1, V1 = _L1, -0.19783 * _L1, -0.46832 * _L1
        end

        local L = (1 - Alpha) * L0 + Alpha * L1
		if L < 0.0197955 then
			return Color3.new();
		end

		local U = ((1 - Alpha) * U0 + Alpha * U1) / L + 0.19783
		local V = ((1 - Alpha) * V0 + Alpha * V1) / L + 0.46832

		local Y = (L + 16) / 116
		Y = Y > 0.206896551724137931 and Y * Y * Y or 0.12841854934601665 * Y - 0.01771290335807126
		local X = Y * U / V
		local Z = Y * ((3 - 0.75 * U) / V - 5)

		local R = 7.2914074 * X - 1.5372080 * Y - 0.4986286 * Z
		local G = -2.1800940 * X + 1.8757561 * Y + 0.0415175 * Z
		local B = 0.1253477 * X - 0.2040211 * Y + 1.0569959 * Z

		if R < 0 and R < G and R < B then
			R, G, B = 0, G - R, B - R
		elseif G < 0 and G < B then
			R, G, B = R - G, 0, B - G
		elseif B < 0 then
			R, G, B = R - B, G - B, 0
		end

		R = R < 3.1306684425E-3 and 12.92 * R or 1.055 * R ^ (1 / 2.4) - 0.055 -- 3.1306684425E-3
		G = G < 3.1306684425E-3 and 12.92 * G or 1.055 * G ^ (1 / 2.4) - 0.055
		B = B < 3.1306684425E-3 and 12.92 * B or 1.055 * B ^ (1 / 2.4) - 0.055

		R = R > 1 and 1 or R < 0 and 0 or R
		G = G > 1 and 1 or G < 0 and 0 or G
		B = B > 1 and 1 or B < 0 and 0 or B

		return Color3.new(R, G, B)
    end,
};