{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      monitor=,highrr,0x0,1

      # Execute your favorite apps at launch
      exec-once = ags -q && ags &
      exec-once = mpvpaper -o "no-audio loop" DP-2 ~/Pictures/Wallpapers/live/blackhole-purple.mp4 &
      exec-once = kdeconnect-cli --refresh && kdeconnect-indicator &

      # Some default env vars.
      env = XCURSOR_SIZE,24
      env = XCURSOR_THEME,phinger-cursors-dark
      env = HYPRCURSOR_SIZE,24
      env = HYPRCURSOR_THEME,phinger-cursors-dark
      env = NIXOS_OZONE_WL,1

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1
          sensitivity = 0.6
          force_no_accel = yes

          touchpad {
              natural_scroll = no
          }

      }

      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          gaps_in = 5
          gaps_out = 5
          border_size = 2
          col.active_border = rgba(19014101) rgba(5b448aff) 90deg

          layout = dwindle

          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = true
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 10
          active_opacity = 0.95
          inactive_opacity = 0.9

          blur {
              enabled = true
              size = 8
              passes = 4
              noise = 0
              brightness = 1
              special = true
              popups = true
              new_optimizations = on
              ignore_opacity = yes
              xray = true
          }

          drop_shadow = yes
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
          enabled = yes
          first_launch_animation = true

          bezier = easeInOutBounce,0.175,0.885,0.32,1.275

          animation = windows, 1, 7,easeInOutBounce
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = off
      }

      misc {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          force_default_wallpaper = 0 # Set to 0 to disable the anime mascot wallpapers
          animate_manual_resizes = true
          disable_hyprland_logo = true
      }

      windowrulev2 = opaque, title: (.*)(- mpv)$
      windowrulev2 = opaque, class: (com.stremio.stremio)$
      windowrulev2 = opaque, class: (.*)(steam)(.*)

      layerrule = blur,namespace: ^(rofi)$

      $mainMod = SUPER
      bind = $mainMod, RETURN, exec, kitty
      bind = $mainMod, Q, killactive,
      bind = $mainMod, W, exec, firefox --new-window
      bind = $mainMod, E, exec, nautilus -w
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle
      bind = $mainMod, L, exec, pidof hyprlock || hyprlock
      bind = SUPERSHIFT, F, fullscreen, 0
      bind = $mainMod, F, fullscreen, 1
      bind = CONTROLALT, Delete, exec, ags -t powermenu
      bind = ALT, Space, exec, rofi -show drun 
      bind = $mainMod, O, exec, rofi -show recursivebrowser
      bind = $mainMod, S, exec, wayshot -f ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
      bind = SUPERSHIFT, S, exec, wayshot -f ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png -s $(slurp)

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Example special workspace (scratchpad)
      bind = $mainMod, M, togglespecialworkspace, magic
      bind = $mainMod SHIFT, M, movetoworkspace, special:magic

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Volume control
      bind =  , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      binde = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      binde = , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
    '';
  };
}
