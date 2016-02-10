-------------------------------------------------
--	Autor :			Arkeine
--	Date :			09.02.2016
--	Purpose :		Load my programe easily
-------------------------------------------------

local PASTBIN_URL = "http://pastebin.com/raw.php?i="
local GITHUB_URL = "https://raw.githubusercontent.com/arkeine/Minecraft-turtle/debug/"
local LAUNCHER_PATH_SOURCE = "Launcher.lua"
local LAUNCHER_PATH_TARGET = "Launcher"

-------------------------------------------------
--	Forward declaration
-------------------------------------------------

getPastbin = nil
getGithub = nil

local loadUrlContent = nil
local saveUrlContentToDisk = nil
local saveToFile = nil
local loadUrlContent = nil

-------------------------------------------------
--	Load from external sources
-------------------------------------------------

getPastbin = function( code, path )
	local r = saveUrlContentToDisk( 
		PASTBIN_URL..textutils.urlEncode( code ),
		path
	)
	return r
end

getGithub = function( githubFile, path )
	local r = saveUrlContentToDisk(
		GITHUB_URL..textutils.urlEncode( githubFile ),
		path
	)
	return r
end

loadUrlContent = function( url )
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

saveUrlContentToDisk = function( url, path )
	local content = loadUrlContent( url )
	if content ~= nil then
		local r = saveToFile( content, path )
		return r
	end
	return false
end

saveToFile = function( content, file )
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

local result = getGithub(LAUNCHER_PATH_SOURCE, LAUNCHER_PATH_TARGET)

if result then
	print("Loading successfull")
	shell.run(LAUNCHER_PATH_TARGET)
else
	print("Loading fail")
end