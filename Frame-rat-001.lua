-- *** FRAME RAT v0.01 *** --
-- b236 
-- 
-- READ HELP! seriously. 



local all = app.activeSprite.frames 
local act = app.activeFrame 
local af_dur 
local af_fps 
local framerates = {} 



local dlgWin = Dialog{ title = "FRAME RAT  " } 

-- set dialog window 
dlgWin
	:button{ 
		text = "HELP!", 
		onclick = function()
			fHelp() 
		end 
	} 
	
	:newrow() 
	
	:button{ 
		text = "analyze", 
		onclick = function()
			fAnalyze() 
		end 
	} 
	
	:newrow() 
	
	:number{ 
		id = "numba", 
		text = "framerate", 
		decimals = integer 
	}
	
	:newrow() 
	
	:button{ 
		text = "EQUALIZE", 
		onclick = function()
			fDestroy(dlgWin) 
		end 
	} 

-- show dialog window 
dlgWin:show{ wait = false } 



-- go through each frame in timeline, print its duration 
-- and output frame rate for each frame 
function fAnalyze() 
	--app.transaction( function() 
		print("F" .. "  " .. "ms" .. "   " .. "fps")
		print( "-----------" ) 

		for i, frame in ipairs(all) do 
			app.activeFrame = i 
			af_dur = app.activeFrame.duration * 1000
			af_fps = 1000 / af_dur 
			print(i .. "  " .. af_dur .. "   " .. af_fps) 
			table.insert(framerates, af_dur) 
		end

		table.sort(framerates) 

		local result = framerates[1] 

		print( "-----------" ) 
		print( "lowest frame duration: " .. result .. "ms / " .. 1000/result .. "fps") 
		print( "suggested frame rate: " .. math.ceil(1000/result) .. "fps" ) 
		 
		for i = 1, #framerates do 
			framerates[i] = nil 
		end 
		
		app.activeFrame = act 
	--end)
end 

--local tost = {} --DELETE 
local test 


function fDestroy(dlgWin) 
	app.transaction( function() 
		-- convert fps to ms 
		local wtf = tonumber( math.floor(1000 / dlgWin.data.numba + 0.5) )
		-- convert ms to frame duration 
		local ftw = wtf/1000 
		
		-- go through each frame in timeline, 
		-- compare its duration to target duration 
		for i, frame in ipairs(all) do 
			app.activeFrame = i 
			test = app.activeFrame.frameNumber 
			
			-- if duration is higher, split frame 
			if app.activeFrame.duration > ftw then 
				  
				fSplit(ftw)
				
			-- if duration is lower, scream and stop 
			elseif app.activeFrame.duration < ftw then 

				fAlert() 
				break  
				
			--elseif app.activeFrame.duration == ftw then 
				-- do nothing 
				
			end 
		end 
		
	end) 
end 



function fSplit(ftw) 
	local split = app.activeFrame.duration / ftw 
	
	if split >= 2 then 
		for i = 1, split-1, 1 do 
			app.activeFrame.duration = ftw 
			app.command.NewFrame() 
		end 
	elseif split < 2 then 
		app.activeFrame.duration = ftw 
	end 
	
	--DELETE print("split: " .. split .. " | ftw: " .. ftw .. " | fr: " .. app.activeFrame.frameNumber .. " " .. app.activeFrame.duration) 
end 



function fAlert() 
local result = app.alert{ 
					title="Warning",
					text="Wrong frame rate!", 
					buttons={"STOP"}
					}
					if result == 1 then 
						print( "Script stopped at frame number: " .. test ) 
						print( "Frame duration is lower than expected: " .. app.activeFrame.duration*1000 .. "ms" ) 
						print( "Try higher fps value - see help for more info." )
					end
end 



function fHelp() 
	print("*** FRAME RAT v0.01 *** ")
	print("*** b236 ")
	print("   ") 
	print("   ") 
	print("This script will equalize frame durations in timeline ")
	print("according to selected frame rate. ")
	print("That will allow you to simply export file sequence for ")
	print("simple use in video editors and game engines. ")
	print("   ") 
	print("   ") 
	print("HOW TO USE: ")
	print("1. SAVE AND BACK UP YOUR SPRITE FIRST!!! ")
	print("   This is very destructive script by design ")
	print("   and while you should be able to use history to undo it, ")
	print("   don't risk anything. ")
	print("2. SWITCH ON CONTINUOUS LAYERS ICON. ")
	print("   That way you'll keep original number of different frames ")
	print("   via linked cels ")
	print("3. Click on 'analyze' button. ")
	print("   This will go through all frames in timeline, print their ")
	print("   duration and in the end it will output lowest frame ")
	print("   duration in timeline and suggested fps. ")
	print("   Feel free to skip this step if you know what you're doing. ")
	print("4. Enter fps value to text field marked as 'framerate'. ")
	print("   You don't have to use fps suggested by analyze function, ")
	print("   but keep in mind, that you are allowed to use only ")
	print("   HIGHER values than suggested fps. ")
	print("5. Hit 'EQUALIZE' button. And you're done. ")
	print("6. If you're not completely sure about the result, ")
	print("   CLOSE THE SCRIPT WINDOW, undo the transaction (ctrl+z) ")
	print("   and run script again. ")
	print("   While the script will allow to repeat the equalize action ")
	print("   you will most likely get worse results. ")
	print("   ")
	print("NOTES: ")
	print("How to get best result: ")
	print("   Easiest way is to plan ahead and use duration as close as ")
	print("   possible to target frame rate. ")
	print("   ")
	print("   Example: ")
	print("   Let's say you want to make animation with traditional ")
	print("   film look. Your target frame rate then will be 24 fps. ")
	print("   Traditionally, to save time, animations were done ")
	print("   at half of that frame rate (12 fps) and each animation ")
	print("   frame was doubled. ")
	print("   Hence if you set your frame durations to those framerates, ")
	print("   you should be fine (see the table below) - use 42 or 41ms. ")
	print("   What you will see in aseprite will be very close (albeit ")
	print("   not perfectly same) to the result you'll get after you ")
	print("   import your exported sequence to video editor. ")
	print("   ")
	print("   Speaking of video editors, they have the option to stretch ")
	print("   the footage. Don't count on that. That won't save you. ")
	print("   Quite the opposite. Why? ")
	print("   You see, there are basically three kinds of algorithms ")
	print("   used in video editors for re-timing footage: ")
	print("   1) multiplication with no in-betweening - the footage data ")
	print("      are kept in pristine condition, however frame rate is ")
	print("      ruined ")
	print("   2) frame blending - results in smooth feeling of the motion ")
	print("      and proper frame rate, however it introduces ghosting ")
	print("      effect, because pairs of different frames are blend ")
	print("      together. Sometimes acceptable, but usually not desirable ")
	print("      even for live footage. ")
	print("   3) frame reconstruction - complex algorithm or even AI which ")
	print("      tries to create new in-between frames based on previous ")
	print("      and next frame in sequence instead of simply blending them. ")
	print("      Produces much better results, but sometimes introduces ")
	print("      glitches and artefacts. ")
	print("      Great for live footage, but generally fails miserably ")
	print("      when applied on animation. ")
	print("   Point 2 and 3 are especially problematic when the footage ")
	print("   in question is pixel art... ")
	print("   So as you see, your best option is to avoid stretching of ")
	print("   footage in video editor completely. ")
	print("   ")
	print("Precision: ")
	print("   There is none. ")
	print("   Understand that aseprite timeline is based ")
	print("   on principle used in gif files: each frame has a delay in ")
	print("   milliseconds. There are no fractions. ")
	print("   That means that you won't get 30 or 60 fps in aseprite. ")
	print("   On the other hand you can get very close. ")
	print("   Human being can't tell the difference between 33 ms ")
	print("   and 33.33333333333333333333 ms. Or 33 ms and 35 ms. ")
	print("   Hence for animation purposes aseprite timeline is perfectly ")
	print("   fine. ")
	print("   However, if your frame durations are incompatible with ")
	print("   standard frame rates and all over the place, expect ")
	print("   problems. ")
	print("   How big are these problems going to be is up to you. ")
	print("   You WILL get slight shift in timing unless your frame ")
	print("   durations are in line with target frame rate. ")
	print("   ")
	print("Suggested frame rate: ")
	print("   Entering lower fps value than suggested would mean that ")
	print("   timeline contains frames of shorter duration than the ")
	print("   frame duration you're trying to set. ")
	print("   Which is not very good idea. ")
	print("   The script will stop and you'll have to undo ")
	print("   the operation. ")
	print("   ")
	print("How to calculate framerate and duration: ")
	print("   Simply divide 1 second (1000 ms) by one or the other: ")
	print("   1000(ms) / framerate(fps) = duration (ms) ")
	print("   1000(ms) / duration (ms) = framerate(fps) ")
	print("   ")
	print("Most used frame rates and their frame durations: ")
	print("   12 fps = 83.333... ms --- animation ")
	print("   24 fps = 41.666... ms --- film ")
	print("   25 fps = 40 ms        --- pal, 50Hz countries ")
	print("   30 fps = 33.333... ms --- (29.97 fps) ntfc, 60Hz countries ")
	print("   50 fps = 20 ms        --- pal, interlaced, 50Hz countries ")
	print("   60 fps = 16.666... ms --- ntfc, interlaced, 60Hz countries ")
	print("   ")
end 