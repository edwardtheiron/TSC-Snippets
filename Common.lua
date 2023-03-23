function print(...)
    -- TSC uses global Print to print things to logmate, so here global customisable print
	--local stime = os.date ("!%X", Call("GetSimulationTime"))
    --local rvn = Call("GetRVNumber")
    -- time stamps and RVN are optional. rvn doesn't seem to work in Simulation script and will return nil
	local result = " " 
	for i = 1, arg.n do
		result = result .. " " .. tostring ( arg[i] )
	end
 	Print(result)
end

function alert(text1,text2,length)	
    -- method to simplify pop ups 
    -- you can just simply call alert("Hello World!") or alert("Hello", "World!")
	if length then
		SysCall("ScenarioManager:ShowAlertMessageExt", tostring(text1), tostring(text2), length, 0)
	elseif text2 then
		SysCall("ScenarioManager:ShowAlertMessageExt", tostring(text1), tostring(text2), 2, 0)
	else
		SysCall("ScenarioManager:ShowAlertMessageExt", tostring(""), tostring(text1), 2, 0)
	end
end
