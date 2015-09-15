--[[
------------------------------------------------------------------------------
Simple Tiled Implementation is licensed under the MIT Open Source License.
(http://www.opensource.org/licenses/mit-license.html)
------------------------------------------------------------------------------

Copyright (c) 2015 Landon Manning - LManning17@gmail.com - LandonManning.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
]]--

local STI = {
	_LICENSE     = "STI is distributed under the terms of the MIT license. See LICENSE.md.",
	_URL         = "https://github.com/karai17/Simple-Tiled-Implementation",
	_VERSION     = "0.13.1.0",
	_DESCRIPTION = "Simple Tiled Implementation is a Tiled Map Editor library designed for the *awesome* LÖVE framework."
}

local path = ... .. "." -- lol
local Map  = require(path .. "map")
local framework

if love then
	framework = require(path .. "framework.love")
else
	framework = require(path .. "framework.lua")
end

function STI.new(map)
	-- Check for valid map type
	local ext = map:sub(-3, -1)
	assert(ext == "lua", string.format(
		"Invalid file type: %s. File must be of type: lua.",
		ext
	))

	-- Get path to map
	local path = map:reverse():find("[/\\]") or ""
	if path ~= "" then
		path = map:sub(1, 1 + (#map - path))
	end

	-- Load map
	map = framework.load(map)
	setfenv(map, {})
	map = setmetatable(map(), {__index = Map})

	map:init(path, framework)

	return map
end

return STI
