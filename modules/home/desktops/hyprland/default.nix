{
  lib,
  config,
  inputs,
  namespace,
  options,
  globals,
  pkgs,

  ...
}:
with lib;
with lib.${namespace};
let
  mainMod = "SUPER";
  screenshotDir = "/home/${globals.username}/Pictures/Screenshots";
  screenshotFileName = "$(date +%s).png";
in
{

  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      systemd.enable = false;
      systemd.variables = [ "--all" ];
    };
    ${namespace} = {
      services = {
        hyprlock = enabled;
        hypridle = enabled;
        hyprsunset = enabled;
      };
      misc.hyprcursor-phinger = enabled;
    };

    home.packages = with pkgs; [
      nvtopPackages.full
      sassc
      slurp
      wayshot
      mpvpaper
      hyprcursor
      hyprpicker
      wf-recorder
      wl-clipboard
      inotify-tools
      gtk-session-lock
      python312Packages.gpustat
    ];

    wayland.windowManager.hyprland.settings = {

      monitor = ",highrr,0x0,1,bitdepth, 10, cm, hdr, sdrbrightness, 1.25, sdrsaturation, 1";

      env = [
        "XCURSOR_SIZE,24"
        "XCURSOR_THEME,phinger-cursors-dark"
        "HYPRCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,phinger-cursors-dark"
        "NIXOS_OZONE_WL, 1" # for ozone-based and electron apps to run on wayland
        "XDG_SESSION_TYPE,wayland"
        "WLR_NO_HARDWARE_CURSORS,1"
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "QT_QPA_PLATFORM,wayland"
      ];

      exec-once = [
        "uwsm app -- clipse -listen"
        "uwsm app -- ${pkgs.rquickshare}/bin/rquickshare"
        "uwsm app -- run-widget ~/.config/Ax-Shell/main.py"
        "uwsm app -- mpvpaper -o 'no-audio loop' DP-2 ${inputs.wallpapers.windows.kylo-rens-lightsaber}"
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
        border_size = 0;
        "col.active_border" = "rgba(19014101) rgba(5b448aff) 90deg";
        layout = "dwindle";
        allow_tearing = true;
      };

      decoration = {
        rounding = 10;
        active_opacity = 0.90;
        inactive_opacity = 0.75;

        shadow = {
          enabled = true;
          range = 2;
          render_power = 1;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 24;
          passes = 2;
          noise = 0;
          brightness = 0.5;
          contrast = 1.5;
          vibrancy = 1.5;
          vibrancy_darkness = 2.0;
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
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "fluent_decel, 0.1, 1, 0, 1"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];

        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 2.5, md3_decel"
          "workspaces, 1, 3.5, easeOutExpo, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
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
        vrr = 1;
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

      layerrule = [
        "noanim,fabric"
      ];

      experimental = {
        xx_color_management_v4 = true;
      };

      bind = [
        "${mainMod}, RETURN, exec, uwsm app -- kitty"
        "${mainMod}, Q, killactive,"
        "${mainMod}, W, exec, uwsm app -- firefox --new-window"
        "${mainMod}, E, exec, uwsm app -- nautilus -w"
        "CONTROLALT, V, togglefloating,"
        "${mainMod}, P, pseudo,"
        "${mainMod}, J, togglesplit,"
        "${mainMod}, L, exec, pidof hyprlock || hyprlock"
        "${mainMod}_SHIFT, F, fullscreen, 0"
        "${mainMod}, F, fullscreen, 1"
        "ALT, Space, exec, pkill rofi || rofi -show drun -run-command \"uwsm app -- {cmd}\""
        "${mainMod}, S, exec, wayshot -f ${screenshotDir}/${screenshotFileName}"
        "${mainMod}_SHIFT, S, exec, wayshot -f ${screenshotDir}/${screenshotFileName} -s $(slurp)"
        "${mainMod},V, exec, uwsm app -- kitty --class clipboardManager -e fish -c 'clipse'"

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
        "CONTROLALT, Delete, exec, hyprctl dispatch exit"
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
  };
}
