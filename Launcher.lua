-------------------------------------------------
--	Autor :			Arkeine
--	Date :			09.02.2016
--	Purpose :		Lauch my programe easily with loading dependencies
-------------------------------------------------

Launcher = {}
Launcher.program = {}
Launcher.library = {}
Launcher.MAX_PROGRAM_PAGE = 6
Launcher.LIBRARIES_DIR = "/arkeine-lib/"
Launcher.PROGRAMS_DIR = "/arkeine-prg/"

-------------------------------------------------
--	Load librairies
-------------------------------------------------

Launcher.listProgram = function()
	local n=0

	for k,v in pairs(Launcher.program) do
		n=n+1
		print(k)
		if n >= Launcher.MAX_PROGRAM_PAGE then
			print("Press a key for more...")
			n = 0
		end
	end
end



-------------------------------------------------
--	Init
-------------------------------------------------

local Loader = require("Loader")
local result = Loader.getGithub("libraries/ConsoleGUI.lua", Launcher.LIBRARIES_DIR.."ConsoleGUI")

if not result then
	print("Loading fail")
	os.exit()
end

local ConsoleGUI = require('ConsoleGUI')
ConsoleGUI.displaySplashScreen()


