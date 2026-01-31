--- @sync entry
-- marker.yazi: PDF to Markdown conversion using Marker

local function entry(_, job)
	local h = cx.active.current.hovered
	if not h then
		ya.notify({ title = "Marker", content = "No file selected", level = "warn", timeout = 3 })
		return
	end

	local url = tostring(h.url)
	local path = url:gsub("^file:///", ""):gsub("^file://", "")
	local normalized = path:gsub("\\", "/")

	local ext = normalized:match("%.(%w+)$")
	if not ext then
		ya.notify({ title = "Marker", content = "No file extension", level = "warn", timeout = 3 })
		return
	end

	ext = ext:lower()
	local filename = normalized:match("([^/]+)$") or "output"
	local basename = filename:match("(.+)%..+$") or filename
	local dir = normalized:match("(.+)/[^/]+$") or "."

	if ext ~= "pdf" then
		ya.notify({ title = "Marker", content = "Unsupported file type: " .. ext, level = "warn", timeout = 3 })
		return
	end

	ya.notify({ title = "Marker", content = "Converting to Markdown: " .. filename, level = "info", timeout = 2 })

	local cmd = string.format('marker_single "%s" --output_dir "%s"', path, dir)
	local exit_code = os.execute(cmd)

	local output_md = dir .. "/" .. basename .. "/" .. basename .. ".md"
	local output_name = basename .. ".md"

	if (exit_code == 0 or exit_code == true) then
		local f = io.open(output_md, "r")
		if f then
			f:close()
			ya.notify({ title = "Marker", content = "Created: " .. output_name, level = "info", timeout = 3 })
		else
			ya.notify({ title = "Marker", content = "Conversion finished but output not found", level = "error", timeout = 5 })
		end
	else
		ya.notify({ title = "Marker", content = "Conversion failed", level = "error", timeout = 5 })
	end
end

return { entry = entry }
