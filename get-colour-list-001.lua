local dlgWin = Dialog{ title = "more clicks = more fun  " } 

list = {} 
counter = 1 

function fGet( dlgWin ) 
	
	table.insert(list, math.floor(app.fgColor.index) ) 
	
	local dlgDat = dlgWin.data
	dlgDat.output = table.concat(list, " ") 
	
	dlgWin.data = dlgDat 
	
end 

function fDel( dlgWin ) 
	
	local dlgDat = dlgWin.data 
	
	for i in pairs(list) do 
		list[i] = nil 
    end 
	
	dlgDat.output = ""
	
	dlgWin.data = dlgDat 
	
end 

-- set dialog window 
dlgWin
	:entry{ 
		id = "output", 
		--value = list 
	}
	
	:button{ 
		text = "get the colour", 
		onclick = function()
			fGet(dlgWin) 
		end 
	} 
	
	:newrow() 
	
	:button{ 
		text = "delete list", 
		onclick = function()
			fDel(dlgWin) 
		end 
	} 
	
-- show dialog window 
dlgWin:show{ wait = false } 
