{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true; # installs Hyprland + Xwayland
    xwayland.enable = true;

    /*
    ───────────────────────────────────────────────────────────────
    Everything below is rendered 1-for-1 from your hyprland.conf.
    If you later edit the original file, just update the lists.
    ───────────────────────────────────────────────────────────────
    */
    settings = {
      #──────────────────── variables ────────────────────#
      "$mainMod" = "SUPER";

      #─────────────────── autostart apps ────────────────#
      "exec-once" = [
        "hyprpaper"
        "hypridle"
        "gnome-keyring-daemon --start --components=secrets"
        "kanshi"
        "nm-applet --indicator"
        "swaync"
        "ulauncher --hide-window"
        "waybar"
        "wl-paste --watch cliphist store"
        "wlsunset -l 52.23 -L 21.01"
      ];

      #──────────────────── monitor block ────────────────#
      monitor = ["DP-2,2560x1440@60,3440x00,1"];
      workspace = [
        "1, monitor:DP-1"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:DP-1"
        "6, monitor:DP-1"
        "7, monitor:DP-1"
        "8, monitor:DP-1"
        "9, monitor:DP-1"
      ];
      #──────────────────── env vars ─────────────────────#
      env = [
        # Wayland/desktop hints
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"

        # Cursor + cursor size
        "XCURSOR_SIZE,24"

        # Qt + screenshots dir
        "QT_QPA_PLATFORM,wayland"
        "XDG_SCREENSHOTS_DIR,~/screens"
      ];

      #──────────────────── input ────────────────────────#
      input = {
        kb_layout = "us";
        kb_options = "grp:alt_shift_toggle";
        repeat_delay = 250;
        repeat_rate = 50;
        follow_mouse = 1;

        touchpad = {
          natural_scroll = true;
        };

        sensitivity = 0;
        accel_profile = "flat";
        natural_scroll = false;
      };

      #──────────────────── general ──────────────────────#
      general = {
        allow_tearing = false;
        gaps_in = 3;
        gaps_out = 3;
        border_size = 1;
        "col.active_border" = "rgb(b7bdf8)";
        layout = "master";
      };

      #──────────────────── decoration ───────────────────#
      decoration = {
        rounding = 8;
        active_opacity = "1.0";
        inactive_opacity = "0.9";
        blur = {
          enabled = true;
          size = 8;
          passes = 3;
        };
      };

      #──────────────────── animations ───────────────────#
      animations = {
        enabled = false;
        bezier = ["myBezier, 0.25,0.1,0.25,1.0"];
      };

      #──────────────────── dwindle / master (if present) #
      dwindle = {
        preserve_split = "yes";
        pseudotile = "yes";
        special_scale_factor = 0.8;
      };
      master = {new_on_top = true;};

      #──────────────────── gestures / misc───────────────#
      gestures.workspace_swipe = "on";
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      #──────────────────── window rules ─────────────────#
      windowrule = [
        # centre & float examples  (33 total lines kept)
        "center 1, class:^(.blueman-manager-wrapped)$"
        "center 1, class:^(gnome-calculator|org\\.gnome\\.Calculator)$"
        "center 1, class:^(nm-connection-editor)$"
        "center 1, class:^(org.pulseaudio.pavucontrol)$"
        "center 1, initialTitle:^(Study Deck)$"
        "center 1, initialTitle:^(_crx_.*)$"
        "float, class:^(.blueman-manager-wrapped)$"
        "float, class:^(gnome-calculator|org\\.gnome\\.Calculator)$"
        "float, class:^(nm-connection-editor)$"
        "float, class:^(org.pulseaudio.pavucontrol)$"
        "float, class:^(ulauncher)$"
        "float, initialTitle:^(_crx_.*)$"
        "float, title:^(MainPicker)$"
        "noborder, class:^(ulauncher)$"
        "noborder, title:^(.*is sharing (your screen|a window)\\.)$"
        "noborder, title:^(MainPicker)$"
        "opaque, class:^(ulauncher)$"
        "opaque, initialTitle:^(Study Deck)$"
        "opaque, title:^(MainPicker)$"
        "stayfocused, class:^(org\\.telegram\\.desktop)$"
        "stayfocused, class:^(ulauncher)$"
        "stayfocused, class:^(gnome-calculator|org\\.gnome\\.Calculator)$"
        "stayfocused, class:^(org.pulseaudio.pavucontrol)$"
        "stayfocused, class:^(swappy)$"
        "workspace 1, class:^(brave-browser)$"
        "workspace 2, class:^(com.mitchellh.ghostty)$"
        "workspace 3, class:^(org\\.telegram\\.desktop)$"
        "workspace 4, class:^(com\\.obsproject\\.Studio)$"
        "workspace 4, class:^(steam)$"
        "workspace 5 silent, class:^(zoom)$"
        "workspace 5, class:^(steam_app_\\d+)$"
        "workspace special silent, title:^(.*is sharing (your screen|a window)\\.)$"
        "workspace special, class:^(gnome-pomodoro)$"
        "pin, title:^(as_toolbar)$"
      ];
      windowrulev2 = [
        "workspace special:1password ,title:(.*)(1Pasword)$"
        "workspace special:notion,class:^(notion-app)$"
        "workspace special:music,class:^(Cider)$"
      ];

      #──────────────────── mouse binds ──────────────────#
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      #──────────────────── key-bindings (64) ─────────────#
      bind = [
        # app launches & layout
        "$mainMod , Return, exec, ghostty"
        "$mainMod , F2, exec, vivaldi"
        "$mainMod SHIFT, F, exec, nautilus"
        "$mainMod SHIFT, T, exec, Telegram"
        "$mainMod, D, exec, rofi -show drun -theme $HOME/.config/rofi/launchers/type-1/style-9.rasi"
        "CTRL ALT, P, exec, gnome-pomodoro --start-stop"

        "$mainMod, Return, layoutmsg, swapwithmaster"
        "$mainMod, R, layoutmsg, orientationcycle"
        "$mainMod, C, killactive,"
        "CTRL ALT, Q, exit"
        "$mainMod, F, togglefloating"
        "$mainMod, M, fullscreen"
        "$mainMod SHIFT, M, movetoworkspacesilent, special"
        "$mainMod SHIFT, P, togglespecialworkspace"
        "$mainMod SHIFT, C, exec, hyprpicker -a"

        # focus movement
        "$mainMod, l, movefocus, l"
        "$mainMod, h, movefocus, r"
        "$mainMod, j, movefocus, d"
        "$mainMod, k, movefocus, u"

        "$mainMod SHIFT, l, swapwindow, r"
        "$mainMod SHIFT, h, swapwindow, l"
        "$mainMod SHIFT, j, swapwindow, d"
        "$mainMod SHIFT, k, swapwindow, u"

        # workspace switching (1-10)
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # screenshot / recording
        "$mainMod, S, exec, grimblast save area"
        "$mainMod SHIFT, S, exec, $HOME/.local/bin/hyprshot --freeze --silent --raw --mode region | swappy -f -"
        "$mainMod CTRL, S, exec, $HOME/.local/bin/hyprshot --freeze --silent --raw --mode output | swappy -f -"
        "$mainMod SHIFT, R, exec, $HOME/.local/bin/screen-recorder"
        "ALT SHIFT, 2, exec, $HOME/.local/bin/ocr"

        # locking & system
        "CTRL ALT, L, exec, hyprlock"

        # brightness / audio
        ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        ", XF86AudioRaiseVolume, exec, pamixer --increase 10"
        ", XF86AudioLowerVolume, exec, pamixer --decrease 10"
        ", XF86AudioMute, exec, pamixer --toggle-mute"
        ", XF86AudioMicMute, exec, pamixer --default-source --toggle-mute"
        "SHIFT, XF86AudioRaiseVolume, exec, pamixer --increase 10 --default-source"
        "SHIFT, XF86AudioLowerVolume, exec, pamixer --decrease 10 --default-source"
        "SHIFT, XF86MonBrightnessUp, exec, brightnessctl -d tpacpi::kbd_backlight set +33%"
        "SHIFT, XF86MonBrightnessDown, exec, brightnessctl -d tpacpi::kbd_backlight set 33%-"

        # notifications
        "$mainMod, V, exec, swaync-client -t -sw"
      ];
    };
  };
}
