-- *** QUICK MIX 0.2 *** --- 
-- b236, based on aquova's hue generator 
-- https://github.com/aquova/aseprite-scripts 
-- 
-- blends foreground and background colours 
-- if one of colours is fully transparent, 
-- the script will mix alpha channels only 


local c1 = app.fgColor 
local c2 = app.bgColor 
local newRed
local newGreen
local newBlue
local newAlpha

if (c1.alpha == 0) then 
	local mix = {
		red = c2.red,
		green = c2.green,
		blue = c2.blue,
		alpha = (c1.alpha - c2.alpha)
	}
	newRed = c2.red 
	newGreen = c2.green 
	newBlue = c2.blue 
	newAlpha = c1.alpha - math.floor(mix.alpha * 0.5) 
	
elseif (c2.alpha == 0) then 
	local mix = {
		red = c1.red,
		green = c1.green,
		blue = c1.blue,
		alpha = (c1.alpha - c2.alpha)
	}
	newRed = c1.red 
	newGreen = c1.green 
	newBlue = c1.blue 
	newAlpha = c1.alpha - math.floor(mix.alpha * 0.5) 
	
else 
	local mix = {
		red = (c1.red - c2.red),
		green = (c1.green - c2.green),
		blue = (c1.blue - c2.blue),
		alpha = (c1.alpha - c2.alpha)
	}
	
	newRed = c1.red - math.floor(mix.red * 0.5) 
	newGreen = c1.green - math.floor(mix.green * 0.5) 
	newBlue = c1.blue - math.floor(mix.blue * 0.5) 
	newAlpha = c1.alpha - math.floor(mix.alpha * 0.5) 
	
end 

local c3 = Color{
	r = newRed, 
	g = newGreen, 
	b = newBlue, 
	a = newAlpha 
}

app.fgColor = c3 

