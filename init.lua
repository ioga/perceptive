local naughty = naughty
local os = require("os")
local io = require("io")
local debug = require("debug")

module('perceptive')

local last_weather_update_time = 0
local weather = nil
local path_to_xsl = debug.getinfo(1, 'S').source:match[[^@(.*/).*$]] .. 'transform.xsl'
local query = 'Saint%20Petersburg%20RU'
local weather_cmd = "wget 'http://www.google.com/ig/api?weather=" .. query .. "&hl=en-gb' -O - -o /dev/null | xsltproc " .. path_to_xsl .." - | sed -e 's/^[ ^I]*//' -e 's/[ ^I]*$//' -e '/^$/d' > /tmp/.awesome.weather.new && mv /tmp/.awesome.weather.new /tmp/.awesome.weather &"

function dump_weather()
    os.execute(weather_cmd)
    last_weather_update_time = os.time()
end

function get_weather()
    io.input('/tmp/.awesome.weather')
    local ret = io.read("*all")
    return ret
end

function remove_weather()
    if weather ~= nil then
        naughty.destroy(weather)
        weather = nil
    end
end

function show_weather()
    remove_weather()
    local wtext = get_weather()
    weather = naughty.notify({
        text = wtext,
        timeout = 3,
        hover_timeout = 0.2
    })
end

function register(wid, url)
    dump_weather()
    wid:add_signal("mouse::enter", function()
        show_weather()
        if (os.time() - last_weather_update_time) > 600 then
            dump_weather()
        end
    end)
end
