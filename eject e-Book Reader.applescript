-- V1.0

tell application "System Events"
	set allDisks to every disk
	repeat with device in allDisks
		try
			-- only ejectable devices can be ejected
			if not ejectable of device then error 0 number 0
			-- Try to read an autorun.inf
			set autorunFile to file ((path of device) & "autorun.inf")
			-- It will throw an error if not found
			set autorun to read autorunFile
			-- Read the file line by line
			repeat with zeile in every paragraph of autorun
				if zeile begins with "icon=" then
					-- get the path to the icon file
					set icon to text 6 thru -1 of zeile
				else if zeile begins with "label=" then
					-- get the name of the device
					set label to text 7 thru -1 of zeile
				end if
			end repeat
			-- Get the full path to the icon file. Error if missing
			set iconFile to file ((POSIX path of device) & "/" & icon)
			-- Ask whether or not to eject. Error if label is missing
			display dialog "Eject " & label & Â
				"?" buttons {"No", "Eject"} default button 2 Â
				with title "Eject e-Book Reader" with icon iconFile
			-- Next device if "No"
			if "No" = the button returned of the result then error 0 number 0
			-- Clear all MacOS specific stuff
			set posixDevice to POSIX path of device as string
			-- eject
			repeat
				try
					my cleanEject(posixDevice)
					exit repeat
				on error errStr number errNum
					if errNum = 1 then
						-- No permission for Full Disk Access
						tell me 
							activate
							display alert "Pemission required" Â
							message "Full Disk Access is required in order to eject an e-Book reader" Â
							as critical buttons {"OK", "Cancel"} default button 1 cancel button 2
						end tell
						-- Show the system preferences
						tell application "System Preferences"
							activate
							set securityPane to (first pane whose id is "com.apple.preference.security")
							reveal (first anchor of securityPane whose name is "Privacy_AllFiles")
						end tell
						-- quit
						return
					else
						-- Device busy?
						tell me 
							activate
							display alert "Failed to eject " & label Â
							message errStr as informational buttons {"Retry", "OK"} default button 1
						end tell
						if the button returned of the result ­ "Retry" then exit repeat
					end if
				end try
			end repeat
			
		on error errTxt number errNum
			log {errTxt, errNum}
		end try
	end repeat
end tell

on cleanEject(posixDevice)
	do shell script "
		/usr/bin/find " & (quoted form of posixDevice) & " \\( -name .Spotlight-V100 -o -name .fseventsd -o -name ._\\* \\) -delete &&
		/usr/sbin/diskutil eject " & (quoted form of posixDevice)
end cleanEject
