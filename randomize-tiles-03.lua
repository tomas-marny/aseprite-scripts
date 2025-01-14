-- RANDOMIZE TILES 0.01 
-- b236 
-- 
-- make a tile set and draw where you want the tiles to be 
-- run script 
-- set range of tile indices to randomize 
-- click on randomize 
-- 


local cel 
local rng_min = 1
local rng_max = 1

local img_h 
local img_w 


local dlg = Dialog{ title = "RANDOMIZE TILES 0.01  " }

dlg:number{
	id = "in_min",
	--label = "min",
	--text = "min",
	decimals = 0,
	onchange =  function() 
					rng_min = dlg.data.in_min
				end 
}

dlg:number{
	id = "in_max",
	--label = "max",
	--text = "max",
	decimals = 0,
	onchange =  function() 
					rng_max = dlg.data.in_max 
				end 
}

dlg:button{ 	
	id = "confirm_madness", 
	--label = string, 
	text = " RANDOMIZE ",
	selected = true,
	focus = true,
	onclick = function() randomize_tiles() end 
}

dlg:button{ 	
	id = " close ", 
	--label = string, 
	text = "close",
	selected = false,
	focus = false,
	onclick = function() dlg:close() end 
}

dlg:show{ wait=false }


function randomize_tiles() 
	cel = app.cel 
	img_h = cel.image.height
	img_w = cel.image.width 
	
	if cel.image.colorMode == ColorMode.TILEMAP then
		local tilemap = cel.image 

		for yy = 0, img_h-1, 1 do 
			for xx = 0, img_w-1, 1 do 
				local pxl = cel.image:getPixel(xx,yy) 
				local val = math.random(rng_min, rng_max)
				if pxl > 0 then 
					cel.image:putPixel(xx,yy, val) 
				end 
			end 
		end 
		app.refresh() -- uuu, naughty! 
	else 
		print("select tilemap!") 
		--dlg:close()
	end 
	
end 