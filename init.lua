local naughty = naughty
local os = os
local io = io

module('perceptive')

local last_weather_update_time = 0
local weather = nil

function dump_weather()
    os.execute("wget 'http://www.google.com/ig/api?weather=Saint%20Petersburg%20RU&hl=en-gb' -O - -o /dev/null | xsltproc /home/ioga/awesome/style.xsl - | sed -e 's/^[ ^I]*//' -e 's/[ ^I]*$//' -e '/^$/d' > /tmp/.awesome.weather.new && mv /tmp/.awesome.weather.new /tmp/.awesome.weather &")
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
