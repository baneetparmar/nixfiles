{ pkgs, ... }:
let
  mainMod = "SUPER";
  wallpaper = "/home/bane/Pictures/Wallpapers/live/blackhole-purple.mp4";
  screenshotDir = "/home/bane/Pictures/Screenshots";
  screenshotFileName = "$(date +%s).png";
in
{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {

    monitor = ",highrr,0x0,1";

    env = [
      "XCURSOR_SIZE,24"
      "XCURSOR_THEME,phinger-cursors-dark"
      "HYPRCURSOR_SIZE,24"
      "HYPRCURSOR_THEME,phinger-cursors-dark"
      "NIXOS_OZONE_WL,1"
    ];

    exec-once = [
      "ags -q && ags"
      "clipse -listen"
      "mpvpaper -o 'no-audio loop' DP-2 ${wallpaper}"
      "kdeconnect-indicator"
    ];

    input = {
      kb_layout = "us";
      follow_mouse = 1;
      sensitivity = 0.6;
      force_no_accel = true;

      touchpad = {
        natural_scroll = false;
      };
    };

    general = {
      gaps_in = 5;
      gaps_out = 5;
      border_size = 2;
      "col.active_border" = "rgba(19014101) rgba(5b448aff) 90deg";
      layout = "dwindle";
      allow_tearing = true;
    };

    decoration = {
      rounding = 10;
      active_opacity = 0.95;
      inactive_opacity = 0.9;

      drop_shadow = true;
      shadow_range = 4;
      shadow_render_power = 3;
      "col.shadow" = "rgba(1a1a1aee)";
      blur = {
        enabled = true;
        size = 8;
        passes = 4;
        noise = 0;
        brightness = 1;
        special = true;
        popups = true;
        new_optimizations = true;
        ignore_opacity = true;
        xray = true;
      };
    };
    animations = {
      enabled = true;
      first_launch_animation = true;

      bezier = "easeInOutBounce,0.175,0.885,0.32,1.275";

      animation = [
        "windows, 1, 7,easeInOutBounce"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };

    dwindle = {
      pseudotile = false;
      preserve_split = true;
    };

    gestures = {
      workspace_swipe = false;
    };

    misc = {
      force_default_wallpaper = 0;
      animate_manual_resizes = true;
      disable_hyprland_logo = true;
    };

    windowrulev2 = [
      "opaque, title: (.*)(- mpv)$"
      "opaque, class: (com.stremio.stremio)$"
      "opaque, class: (.*)(steam)(.*)"
      "maximize, class: ^(com.interversehq.qView)$"
      "float, class: ^(clipboardManager)$"
      "size 800 600, class: ^(clipboardManager)$"
      "center, class: ^(clipboardManager)$"
      "stayfocused, class: ^(clipboardManager)$"
    ];

    layerrule = [ "blur,rofi" ];

    bind = [
      "${mainMod}, RETURN, exec, kitty"
      "${mainMod}, Q, killactive,"
      "${mainMod}, W, exec, firefox --new-window"
      "${mainMod}, E, exec, nautilus -w"
      "CONTROLALT, V, togglefloating,"
      "${mainMod}, P, pseudo,"
      "${mainMod}, J, togglesplit,"
      "${mainMod}, L, exec, pidof hyprlock || hyprlock"
      "${mainMod}_SHIFT, F, fullscreen, 0"
      "${mainMod}, F, fullscreen, 1"
      "CONTROLALT, Delete, exec, ags -t powermenu"
      "ALT, Space, exec, pkill rofi || rofi -show drun"
      "${mainMod}, S, exec, wayshot -f ${screenshotDir}/${screenshotFileName}"
      "${mainMod}_SHIFT, S, exec, wayshot -f ${screenshotDir}/${screenshotFileName} -s $(slurp)"
      "${mainMod},V, exec, kitty --class clipboardManager -e fish -c 'clipse'"

      "${mainMod}, left, movefocus, l"
      "${mainMod}, right, movefocus, r"
      "${mainMod}, up, movefocus, u"
      "${mainMod}, down, movefocus, d"

      "${mainMod}, 1, workspace, 1"
      "${mainMod}, 2, workspace, 2"
      "${mainMod}, 3, workspace, 3"
      "${mainMod}, 4, workspace, 4"
      "${mainMod}, 5, workspace, 5"
      "${mainMod}, 6, workspace, 6"
      "${mainMod}, 7, workspace, 7"
      "${mainMod}, 8, workspace, 8"
      "${mainMod}, 9, workspace, 9"
      "${mainMod}, 0, workspace, 10"

      "${mainMod} SHIFT, 1, movetoworkspace, 1"
      "${mainMod} SHIFT, 2, movetoworkspace, 2"
      "${mainMod} SHIFT, 3, movetoworkspace, 3"
      "${mainMod} SHIFT, 4, movetoworkspace, 4"
      "${mainMod} SHIFT, 5, movetoworkspace, 5"
      "${mainMod} SHIFT, 6, movetoworkspace, 6"
      "${mainMod} SHIFT, 7, movetoworkspace, 7"
      "${mainMod} SHIFT, 8, movetoworkspace, 8"
      "${mainMod} SHIFT, 9, movetoworkspace, 9"
      "${mainMod} SHIFT, 0, movetoworkspace, 10"

      "${mainMod}, slash, togglespecialworkspace, magic"
      "${mainMod}_SHIFT, slash, movetoworkspace, special:magic"

      "${mainMod}, mouse_down, workspace, e+1"
      "${mainMod}, mouse_up, workspace, e-1"
    ];

    bindl = [ ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" ];

    bindel = [
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
    ];

    bindm = [
      "${mainMod}, mouse:272, movewindow"
      "${mainMod}, mouse:273, resizewindow"
    ];
  };
}
