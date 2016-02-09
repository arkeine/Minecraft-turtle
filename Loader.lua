-------------------------------------------------
--	Autor :			Arkeine
--	Date :			09.02.2016
--	Purpose :		Load my programe easily
-------------------------------------------------

local Loader = {}

Loader.PASTBIN_URL = "http://pastebin.com/raw.php?i="
Loader.GITHUB_URL = "https://raw.githubusercontent.com/arkeine/Minecraft-turtle/master/"
Loader.LAUNCHER_PATH_SOURCE = "Launcher.lua"
Loader.LAUNCHER_PATH_TARGET = "Launcher"

-------------------------------------------------
--	Load from external sources
-------------------------------------------------

function Loader.getPastbin( code, path )
	local r = saveUrlContentToDisk( 
		Loader.PASTBIN_URL..textutils.urlEncode( code ),
		path
	)
	return r
end

function Loader.getGithub( githubFile, path )
	local r = Loader.saveUrlContentToDisk(
		Loader.GITHUB_URL..textutils.urlEncode( githubFile ),
		path
	)
	return r
end

function Loader.loadUrlContent( url )
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

function Loader.saveUrlContentToDisk( url, path )
	local content = Loader.loadUrlContent( url )
	if content ~= nil then
		local r = Loader.saveToFile( content, path )
		return r
	end
	return false
end

function Loader.saveToFile( content, file )
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

function Loader.main()
	term.clear() 
	term.setCursorPos(1,1) 
	print("Loading launcher...")
	print("Please wait")

	local result = Loader.getGithub(Loader.LAUNCHER_PATH_SOURCE, Loader.LAUNCHER_PATH_TARGET)

	if result then
		print("Loading successfull")
		shell.run(Loader.LAUNCHER_PATH_TARGET)
	else
		print("Loading fail")
	end
end

return Loader