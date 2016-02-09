-------------------------------------------------
--	Autor :			Arkeine
--	Date :			09.02.2016
--	Purpose :		Load my programe easily
-------------------------------------------------

PASTBIN_URL = "http://pastebin.com/raw.php?i="
GITHUB_URL = "https://raw.githubusercontent.com/arkeine/Minecraft-turtle/master/"
LAUNCHER_PATH_SOURCE = "Launcher.lua"
LAUNCHER_PATH_TARGET = "Launcher"

-------------------------------------------------
--	Load from external sources
-------------------------------------------------

function getPastbin( code, path )
	local r = saveUrlContentToDisk( 
		PASTBIN_URL..textutils.urlEncode( code ),
		path
	)
	return r
end

function getGithub( githubFile, path )
	local r = saveUrlContentToDisk(
		GITHUB_URL..textutils.urlEncode( githubFile ),
		path
	)
	return r
end

local function loadUrlContent( url )
    local response = http.get( url )
        
    if response then
        local content = response.readAll()
        response.close()
        return content
    else
        printError( "Failed loading URL :" )
        printError( url )
		return nil
    end
end

-------------------------------------------------
--	Disk utils
-------------------------------------------------

local function saveUrlContentToDisk( url, path )
	local content = loadUrlContent( url )
	if content ~= nil then
		local r = saveToFile( content, path )
		return r
	end
	return false
end

local function saveToFile( content, file )
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
--	Main
-------------------------------------------------

term.clear() 
term.setCursorPos(1,1) 
print("Loading launcher...")
print("Please wait")

local result = getGithub(LAUNCHER_PATH_SOURCE, LAUNCHER_PATH_TARGET)

if result then
	print("Loading successfull")
	shell.run(LAUNCHER_PATH_TARGET)
else
	print("Loading fail")
end
