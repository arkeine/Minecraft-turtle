-------------------------------------------------
--	Autor :			Arkeine
--	Date :			09.02.2016
--	Purpose :		Load my programe easily
-------------------------------------------------

Loader = {}

Loader.PASTBIN_URL = "http://pastebin.com/raw.php?i="
Loader.GITHUB_URL = "https://raw.githubusercontent.com/arkeine/Minecraft-turtle/master/"
Loader.LAUNCHER_PATH_SOURCE = "launcher.lua"
Loader.LAUNCHER_PATH_TARGET = "launcher"

-------------------------------------------------
--	Load from external sources
-------------------------------------------------

Loader.getPastbin = function( code, path )
	local content = loadUrlContent(
		Loader.PASTBIN_URL..code
	)
	return content != nil and saveToFile( content, path )
end

Loader.getGithub = function( githubFile, path )
	local content = loadUrlContent(
		Loader.GITHUB_URL..githubFile
	)
	return content != nil and saveToFile( content, path )
end

Loader.loadUrlContent = function( url )
    local response = http.get(
        textutils.urlEncode( url )
    )
        
    if response then
        local content = response.readAll()
        response.close()
        return content
    else
        printError( "Failed loading URL." )
		return nil
    end
end

-------------------------------------------------
--	Disk utils
-------------------------------------------------

local function saveToFile(content, file)
    local sPath = shell.resolve( file )
	fs.delete( sPath )
	
    if content then        
        local file = fs.open( sPath, "w" )
        file.write( content )
        file.close()
        return true
    end 
	return false
end 

-------------------------------------------------
--	Init
-------------------------------------------------

term.clear() 
term.setCursorPos(1,1) 
print("Loading launcher...")
print("Please wait")
local result = Loader.getGithub(Loader.LAUNCHER_PATH_SOURCE, LAUNCHER_PATH_TARGET)

if result then
	print("Loading successfull")
	shell.run(LAUNCHER_PATH_TARGET)
else
	print("Loading fail")

