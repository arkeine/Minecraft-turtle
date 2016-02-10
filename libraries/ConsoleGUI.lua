-------------------------------------------------
--	Autor :			Arkeine
--	Date :			09.02.2016
--	Purpose :		Print some messages for the user
-------------------------------------------------

local LINE = "-----------------------------------"
local messageType = {"","Error", "Input", "Info", "Warning"}
local messageAnswer = {"No", "Yes", "Ok", "Cancel", "Ignore"}

-------------------------------------------------
--	Forward declaration
-------------------------------------------------

displayLogo = nil
displayLog = nil
displayBox = nil
displayError = nil
displayNewWindow = nil
displaySplashScreen = nil
pressAKey = nil
inputNumber = nil
inputNumberInRange = nil
askChoice = nil

-------------------------------------------------
--	Display
-------------------------------------------------

displayLogo = function()
	term.clear() 
	term.setCursorPos(1,1) 
	print("  ___       _                 __ _   ")
	print(" / _ \\     | |               / _| |  ")
	print("/ /_\\ \\_ __| | __  ___  ___ | |_| |_ ")
	print("|  _  | '__| |/ / / __|/ _ \\|  _| __|")
	print("| | | | |  |   <  \\__ \\ (_) | | | |_ ")
	print("\\_| |_/_|  |_|\\_\\ |___/\\___/|_|  \\__|")
end

displayLog = function (message, messageType=1)
	if messageType==1 then
		print(message)
	else
		print(messageType[messageType], " : ", message)
	end
end

displayBox = function(message, title, messageType=1)
	term.clear() 
	term.setCursorPos(1,1) 
	print(LINE)
	print()
	displayLog(title, messageType)
	print()
	print(message)
	print()
	print(LINE)
end 

displayError = function(message, title, messageType=2)
	displayBox(message, title, messageType)
	pressAKey()
end 

displayNewWindow = function(title)
	term.clear() 
	term.setCursorPos(1,1) 
	print(LINE)
	print(title)
	print(LINE)
end 

displaySplashScreen = function()
	displayLogo()
	os.sleep(1)
	pressAKey()
end 

-------------------------------------------------
--	Input
-------------------------------------------------


pressAKey = function()
	print("")
	print("Press a key...")
	print("")
	read()
end 

inputNumber = function()
	local input = read()
	input = tonumber(input)
	while type(input) == "nil" do
		displayLog("Wrong input, ty again : ", 1)
		input = read()
		input = tonumber(input)
	end
	return input
end

inputNumberInRange = function(minumum, maximum)
	print("Enter a number between [",minumum," - ",maximum,"]")
	while true do
		local input = inputNumber()
		if  input <= minumum or input >= maximum then
			displayLog("Not in range, ty again : ", 1)			
		else
			return input
		end
	end
end 

askChoice = function(message, choices)
	print(message)
	
	local n = 0;
	for k in choices do
		n=n+1
		print(n,") ",k)
	end
	local r = inputNumberInRange(1, n)
	return r
end 
