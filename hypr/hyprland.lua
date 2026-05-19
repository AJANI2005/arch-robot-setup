require("config.binds")
require("config.monitors")
require("config.animations")
require("config.rules")


-- Startup
hl.on("hyprland.start",function()
    hl.exec_cmd("xwayland-satellite") --X11 Compatibility
    hl.exec_cmd("/usr/libexec/polkit-mate-authentication-agent-1") -- Polkit
    hl.exec_cmd("awww-daemon") --Wallpaper Daemon
    hl.exec_cmd("waybar") --Bar
    hl.exec_cmd("hypridle") --Idle
    hl.exec_cmd("gammastep") --Bluelight Filter
    hl.exec_cmd("nwg-dock-hyprland") --Bluelight Filter
end)

--Environment
hl.env("DISPLAY",":0")
hl.env("HYPRCURSOR_THEME", "Breeze Light")
hl.env("HYPRCURSOR_SIZE", "24")

-- Main Configuration
hl.config({
    general={
       border_size=1,
       resize_on_border=true,
       --Enable Scrolling
       layout="scrolling"
    },
    decoration={
        rounding=0
    },
    input={
        kb_layout="us",
        natural_scroll=true,
        touchpad={
            natural_scroll=true
        }
    },
    misc={
        disable_hyprland_logo=true,
        disable_splash_rendering=true
    },
    scrolling={}

})

hl.gesture({
   fingers = 3,
   direction = "horizontal",
   action = "scroll_move",
   scale=1.5
})
hl.gesture({
   fingers = 4,
   action="workspace",
   direction = "vertical",
   scale=1.5
})


