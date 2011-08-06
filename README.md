Perceptive, a weather notification module for awesome
================================

Perceptive is a module for awesome wm for brief and compact
weather notification via naughty lib.

Requirements
------------
- awesome
- naughty
- libxslt
- wget
- /tmp dir

Usage
-----
Copy perceptive dir into $XDG_CONFIG_HOME/awesome (awesome config dir).
Then, add on top of rc.lua :

    require("perceptive")

And bind perceptive notification to your default clock widget

    perceptive.register(mytextclock)

