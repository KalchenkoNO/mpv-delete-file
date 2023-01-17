local utils = require "mp.utils"

require 'mp.options'

options = {}
options.MoveToFolder = false

if package.config:sub(1,1) == "/" then
	options.DeletedFilesPath = utils.join_path(os.getenv("HOME"), "delete_file")
	ops = "unix"
else
	options.DeletedFilesPath = utils.join_path(os.getenv("USERPROFILE"), "delete_file")
	ops = "win"
end

read_options(options)

function delete_file()
	local file_path = mp.get_property_native("path")
	local work_dir = mp.get_property_native("working-directory")
	local s = file_path:find(work_dir, 0, true)
	local final_path
	if s and s == 0 then
		final_path = file_path
	else
		final_path = utils.join_path(work_dir, file_path)
	end
	mp.osd_message("deleting current file")
	mp.command("quit")
	os.remove(file_path)
end

mp.add_key_binding("ctrl+DEL", "delete_file", delete_file)
