-------------------------------------------------
--	Autor :			Arkeine
--	Date :			09.02.2016
--	Purpose :		Print some messages for the user
-------------------------------------------------

local ConsoleGUI = {}

ConsoleGUI.LINE = "-----------------------------------"
ConsoleGUI.messageType = {"","Error", "Input", "Info", "Warning"}
ConsoleGUI.messageAnswer = {"No", "Yes", "Ok", "Cancel", "Ignore"}

-------------------------------------------------
--	Display
-------------------------------------------------

function ConsoleGUI.displayLogo()
	term.clear() 
	term.setCursorPos(1,1) 
	print("  ___       _                 __ _   ")
	print(" / _ \\     | |               / _| |  ")
	print("/ /_\\ \\_ __| | __  ___  ___ | |_| |_ ")
	print("|  _  | '__| |/ / / __|/ _ \\|  _| __|")
	print("| | | | |  |   <  \\__ \\ (_) | | | |_ ")
	print("\\_| |_/_|  |_|\\_\\ |___/\\___/|_|  \\__|")
end

function ConsoleGUI.displayLog (message, messageType=1)
	if messageType==1 then
		print(message)
	else
		print(ConsoleGUI.messageType[messageType], " : ", message)
	end
end

function ConsoleGUI.displayBox(message, title, messageType=1)
	term.clear() 
	term.setCursorPos(1,1) 
	print(ConsoleGUI.LINE)
	print()
	ConsoleGUI.displayLog(title, messageType)
	print()
	print(message)
	print()
	print(ConsoleGUI.LINE)
end 

function ConsoleGUI.displayError(message, title, messageType=2)
	ConsoleGUI.displayBox(message, title, messageType)
	ConsoleGUI.pressAKey()
end 

function ConsoleGUI.displayNewWindow(title)
	term.clear() 
	term.setCursorPos(1,1) 
	print(ConsoleGUI.LINE)
	print(title)
	print(ConsoleGUI.LINE)
end 

function ConsoleGUI.displaySplashScreen()
	ConsoleGUI.displayLogo()
	os.sleep(1)
	ConsoleGUI.pressAKey()
end 

-------------------------------------------------
--	Input
-------------------------------------------------


function ConsoleGUI.pressAKey()
	print("")
	print("Press a key...")
	print("")
	read()
end 

function ConsoleGUI.inputNumber()
	local input = read()
	input = tonumber(input)
	while type(input) == "nil" do
		ConsoleGUI.displayLog("Wrong input, ty again : ", 1)
		input = read()
		input = tonumber(input)
	end
	return input
end

function ConsoleGUI.inputNumberInRange(minumum, maximum)
	print("Enter a number between [",minumum," - ",maximum,"]")
	while true do
		local input = ConsoleGUI.inputNumber()
		if  input <= minumum or input >= maximum then
			ConsoleGUI.displayLog("Not in range, ty again : ", 1)			
		else
			return input
		end
	end
end 

function ConsoleGUI.askChoice(message, choices)
	print(message)
	
	local n = 0;
	for k in choices do
		n=n+1
		print(n,") ",k)
	end
	local r = inputNumberInRange(1, n)
	return r
end 

return ConsoleGUI