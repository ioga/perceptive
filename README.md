Perceptive, a weather notification module for awesome
================================

Perceptive is a module for awesome wm for brief and compact
weather notification via naughty lib.

Requirements
------------
- awesome 3.4+
- LuaSocket library (luasocket package at Gentoo, Debian & Ubuntu, lua-socket at RHEL/CentOs/Fedora)
- libxslt
- /tmp directory

Usage
-----
Clone perceptive repository into your $XDG_CONFIG_HOME/awesome (awesome config dir).
Then, add on top of rc.lua :

    require("perceptive")

And bind perceptive notification to some widget with parameters (widget object, query string), for example, for your default clock widget:

    perceptive.register(mytextclock, 'Saint Petersburg Russia')

So, current weather and three days forecast for Saint Petersburg would be shown when you'll place your mouse over clock widget.

Screenshot
-----
![Screenshot][1]

[1]: http://github.com/ioga/perceptive/raw/master/screenshot.png