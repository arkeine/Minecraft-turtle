-------------------------------------------------
--	Autor :			Arkeine
--	Date :			09.02.2016
--	Purpose :		Print some messages for the user
-------------------------------------------------

local LINE = "-----------------------------------"
local MESSAGE_TYPE = {"","Error", "Input", "Info", "Warning"}
local MESSAGE_ANSWER = {"No", "Yes", "Ok", "Cancel", "Ignore"}

-------------------------------------------------
--	Display
-------------------------------------------------

function displayLogo()
	term.clear() 
	term.setCursorPos(1,1) 
	print("  ___       _                 __ _   ")
	print(" / _ \\     | |               / _| |  ")
	print("/ /_\\ \\_ __| | __  ___  ___ | |_| |_ ")
	print("|  _  | '__| |/ / / __|/ _ \\|  _| __|")
	print("| | | | |  |   <  \\__ \\ (_) | | | |_ ")
	print("\\_| |_/_|  |_|\\_\\ |___/\\___/|_|  \\__|")
end

function displayLog (message, messageType=1)
	if messageType==1 then
		print(message)
	else
		print(MESSAGE_TYPE[messageType], " : ", message)
	end
end

function displayBox(message, title, messageType=1)
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

function displayError(message, title, messageType=2)
	displayBox(message, title, messageType)
	pressAKey()
end 

function displayNewWindow(title)
	term.clear() 
	term.setCursorPos(1,1) 
	print(LINE)
	print(title)
	print(LINE)
end 

function displaySplashScreen()
	displayLogo()
	os.sleep(1)
	pressAKey()
end 

-------------------------------------------------
--	Input
-------------------------------------------------

function pressAKey()
	print("")
	print("Press a key...")
	print("")
	read()
end 

function inputNumber()
	local input = read()
	input = tonumber(input)
	while type(input) == "nil" do
		displayLog("Wrong input, ty again : ", 1)
		input = read()
		input = tonumber(input)
	end
	return input
end

function inputNumberInRange(minumum, maximum)
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

function askChoice(message, choices)
	print(message)
	
	local n = 0;
	for k in choices do
		n=n+1
		print(n,") ",k)
	end
	local r = inputNumberInRange(1, n)
	return r
end 