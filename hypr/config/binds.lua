-- Hyprland Keybinds
local MOD="SUPER"
local terminal="alacritty"
local browser="app.zen_browser.zen"
local files="nautilus"
local notes="~/Applications/Obsidian-1.12.7.AppImage"
local appMenu="wofi --show drun --normal-window"

-- Apps
hl.bind(MOD.."+Return",hl.dsp.exec_cmd(terminal))
hl.bind(MOD.."+Space",hl.dsp.exec_cmd(appMenu))
hl.bind(MOD.."+B",hl.dsp.exec_cmd(browser))
hl.bind(MOD.."+E",hl.dsp.exec_cmd(files))
hl.bind(MOD.."+N",hl.dsp.exec_cmd(notes))
hl.bind("ALT+W",hl.dsp.exec_cmd("alacritty -e ~/Scripts/wallpaper.sh"))


-- Window Movement
hl.bind(MOD .. "+F",hl.dsp.window.fullscreen({mode="maximized",action="toggle"}))
hl.bind(MOD .. "+SHIFT+F",hl.dsp.window.fullscreen({mode="fullscreen",action="toggle"}))
hl.bind(MOD .. "+Q",hl.dsp.window.close())

-- Move focus with mainMod + direction keys
hl.bind(MOD .. "+left",  hl.dsp.focus({ direction = "left" }))
hl.bind(MOD .. "+right", hl.dsp.focus({ direction = "right" }))
hl.bind(MOD .. "+up",    hl.dsp.focus({ direction = "up" }))
hl.bind(MOD .. "+down",  hl.dsp.focus({ direction = "down" }))

-- Vim Binds :)
hl.bind(MOD .. "+h",  hl.dsp.focus({ direction = "left" }))
hl.bind(MOD .. "+l", hl.dsp.focus({ direction = "right" }))
hl.bind(MOD .. "+k",    hl.dsp.focus({ direction = "up" }))
hl.bind(MOD .. "+j",  hl.dsp.focus({ direction = "down" }))

hl.bind(MOD .. "+SHIFT+h",  hl.dsp.window.move({ direction = "left" }))
hl.bind(MOD .. "+SHIFT+l", hl.dsp.window.move({ direction = "right" }))
hl.bind(MOD .. "+SHIFT+k",    hl.dsp.window.move({ direction = "up" }))
hl.bind(MOD .. "+SHIFT+j",  hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(MOD .."+"..key,             hl.dsp.focus({ workspace = i}))
    hl.bind(MOD .. "+ SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind(MOD .. "+W", hl.dsp.window.float({ action = "toggle" }))
-- Scroll through existing workspaces with mainMod + scroll
hl.bind(MOD .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(MOD .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(MOD .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(MOD .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })



-- System
hl.bind(MOD .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 0.05+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 0.05-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


