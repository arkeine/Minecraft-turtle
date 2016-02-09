-------------------------------------------------
--	Autor :			Arkeine
--	Date :			09.02.2016
--	Purpose :		Lauch my programe easily with loading dependencies
-------------------------------------------------

local program = {}
local library = {}
local MAX_PROGRAM_PAGE = 6
local LIBRARIES_DIR = "/arkeine-lib/"
local PROGRAMS_DIR = "/arkeine-prg/"

-------------------------------------------------
--	Load librairies
-------------------------------------------------

listProgram = function()
	local n=0

	for k,v in pairs(program) do
		n=n+1
		print(k)
		if n >= MAX_PROGRAM_PAGE then
			print("Press a key for more...")
			n = 0
		end
	end
end



-------------------------------------------------
--	Init
-------------------------------------------------

os.loadAPI("Loader")
local result = Loader.getGithub("libraries/ConsoleGUI.lua", LIBRARIES_DIR.."ConsoleGUI")

if not result then
	print("Loading fail")
	os.exit()
end

os.loadAPI(LIBRARIES_DIR.."ConsoleGUI")
ConsoleGUI.displaySplashScreen()


