-- SESSION 0.01 
-- b236 
-- 
-- save the list of all opened sprites and load them later all at once.
--  
-- to erase the session file, just hit save when no sprites are opened. 
-- ATTENTION: the file "session" has to be present in scripts folder! 


local path = os.getenv('APPDATA') .. "/Aseprite/scripts/" 
local sessionFile = "session" 

local s = {}

function getSprites() 
	for i,sprite in ipairs(app.sprites) do
	  table.insert(s,sprite.filename) 
	end 
end 

function saveSession() 
	local file = io.open(path .. sessionFile, "w+") 
	
	for i in pairs(s) do 
		file:write(s[i] .. "\n") 
	end 
	
	file:close() 
end 

function loadSession()	
	local file = io.open(path .. sessionFile, "r");
	--local data = file:read("*a")
	local data = file:lines("*l") 
	
	for str in data do
		table.insert(s, str)
	end

	--for i in pairs(s) do 
	for i = #s, 1, -1 do
        app.open(s[i]) 
    end  
	
	file:close() 
end 

function clearList() 
	for i in pairs(s) do 
        s[i] = nil 
    end  
end 

local dlgWin = Dialog("*** Session 0.01 ***  ") 
	:button{ id="a", text="Save", onclick=function() 
		clearList() 
		getSprites() 
		saveSession() 
		clearList() 
	end} 
	:button{ id="b", text="Load", onclick=function() 
		clearList() 
		loadSession() 
		clearList() 
	end} 
	dlgWin:button{ id="e", text="Close", onclick=function() 
	-- why there MUST be dlgWin specified? 
		dlgWin:close() 
	end} 
	
dlgWin:show{wait=false}
