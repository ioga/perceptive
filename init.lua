local naughty = naughty
local timer = timer
local os = require("os")
local io = require("io")
local debug = require("debug")
local http = require("socket.http")
local string = string
local print = print

module('perceptive')

local path_to_xsl = debug.getinfo(1, 'S').source:match[[^@(.*/).*$]] .. 'transform.xsl'
local xslt_cmd = 'xsltproc ' .. path_to_xsl .. ' - ' .. "| sed -e 's/^[ ^I]*//' -e 's/[ ^I]*$//' -e '/^$/d'"
local query = 'Saint%20Petersburg%20RU'
local weather_data = ""
local weather = nil

-- This was taken from http://www.lua.org/pil/20.3.html
function escape(s)
    s = string.gsub(s, "([&=+%c])", function (c)
        return string.format("%%%02X", string.byte(c))
    end)
    s = string.gsub(s, " ", "+")
    return s
end

function dump_weather()
    url = 'http://www.google.com/ig/api?weather=' ..  query .. '&hl=en-gb'
    data, msg = http.request(url)
    if not data then 
        print("perceptive:http.request error:" .. msg)
        return 
    end
    fp = io.popen(xslt_cmd .. ">/tmp/.awesome.weather", "w")
    fp:write(data)
    fp:close()
    io.input("/tmp/.awesome.weather")
    weather_data = io.read("*all")
    last_weather_update_time = os.time()
end

function remove_notification()
    if weather ~= nil then
        naughty.destroy(weather)
        weather = nil
    end
end

function show_notification()
    remove_notification()
    weather = naughty.notify({
        text = weather_data,
    })
end

function register(wid, q)
    query = escape(q)
    update_timer = timer({ timeout = 600 })
    update_timer:add_signal("timeout", function() 
        dump_weather()
    end)
    update_timer:start()
    dump_weather()

    wid:add_signal("mouse::enter", function()
        show_notification()
    end)
    wid:add_signal("mouse::leave", function()
        remove_notification()
    end)
end
