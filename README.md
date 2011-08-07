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

And bind perceptive notification to some widget, for example, for your default clock widget:

    perceptive.register(widget, query)
    perceptive.register(mytextclock, 'Saint Petersburg Russia)

