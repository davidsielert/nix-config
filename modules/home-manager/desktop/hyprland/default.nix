{
  config,
  lib,
  nhModules,
  pkgs,
  ...
}: {
  imports = [
    ./config.nix
    "${nhModules}/misc/gtk"
    "${nhModules}/misc/wallpaper"
    "${nhModules}/misc/xdg"
    "${nhModules}/programs/swappy"
    "${nhModules}/services/cliphist"
    "${nhModules}/services/kanshi"
    "${nhModules}/services/swaync"
    "${nhModules}/services/waybar"
  ];
  home.packages = with pkgs; [
    alacritty
    vivaldi
    nautilus
    gnome-calculator
    dconf-editor
    gnome-pomodoro
    pamixer
    grim
    slurp
    swappy
    brightnessctl
    hyprpaper
    hypridle
    hyprpicker
    swaynotificationcenter
    wl-clipboard
    cliphist
    rofi-wayland
    hyprlock
    # your custom scripts assumed to be in ~/.local/bin
  ];

  # Consistent cursor theme across all applications.
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.yaru-theme;
    name = "Yaru";
    size = 24;
  };

  # Source hyprland config from the home-manager store
  xdg.configFile = {
    #  "hypr/hyprland.conf" = {
    #    source = ./hyprland.conf;
    #  };

    "hypr/hyprpaper.conf".text = ''
      splash = false
      preload = ${config.wallpaper}
      wallpaper = DP-2, ${config.wallpaper}
    '';

    "hypr/hypridle.conf".text = ''
            general {
              lock_cmd = pidof hyprlock || hyprlock
              before_sleep_cmd = loginctl lock-session
              after_sleep_cmd = hyprctl dispatch dpms on
            }
            listener {
          # The timeout value in seconds. 300 seconds = 5 minutes.
          timeout = 300

          # The command to run when the timeout is reached.
          on-timeout = hyprlock
      }
    '';

    "hypr/hyprlock.conf".text = ''
      background {
          monitor =
          path = ${config.wallpaper}
          blur_passes = 3
          contrast = 0.8916
          brightness = 0.8172
          vibrancy = 0.1696
          vibrancy_darkness = 0.0
      }

      general {
          grace = 0
          fail_timeout = 1000
      }

      # DP-2 Conifg
      input-field {
          monitor = DP-2
          size = 250, 60
          outline_thickness = 2
          dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true
          outer_color = rgba(0, 0, 0, 0)
          inner_color = rgba(0, 0, 0, 0.5)
          font_color = rgb(200, 200, 200)
          fade_on_empty = false
          capslock_color = -1
          placeholder_text = <i><span foreground="##e6e9ef">Password</span></i>
          fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
          hide_input = false
          position = 0, -120
          halign = center
          valign = center
      }

      # Date
      label {
        monitor = DP-2
        text = cmd[update:1000] echo "<span>$(date '+%A, %d %B')</span>"
        color = rgba(255, 255, 255, 0.8)
        font_size = 15
        font_family = JetBrains Mono Nerd Font Mono ExtraBold
        position = 0, -400
        halign = center
        valign = top
      }

      # Time
      label {
          monitor = DP-2
          text = cmd[update:1000] echo "<span>$(date '+%H:%M')</span>"
          color = rgba(255, 255, 255, 0.8)
          font_size = 120
          font_family = JetBrains Mono Nerd Font Mono ExtraBold
          position = 0, -400
          halign = center
          valign = top
      }

      # Keyboard layout
      label {
        monitor = DP-2
        text = $LAYOUT
        color = rgba(255, 255, 255, 0.9)
        font_size = 10
        font_family = JetBrains Mono Nerd Font Mono
        position = 0, -175
        halign = center
        valign = center
      }

    '';
  };

  dconf.settings = {
    "org/blueman/general" = {
      "plugin-list" = lib.mkForce ["!StatusNotifierItem"];
    };

    "org/blueman/plugins/powermanager" = {
      "auto-power-on" = true;
    };

    "org/gnome/calculator" = {
      "accuracy" = 9;
      "angle-units" = "degrees";
      "base" = 10;
      "button-mode" = "basic";
      "number-format" = "automatic";
      "show-thousands" = false;
      "show-zeroes" = false;
      "source-currency" = "";
      "source-units" = "degree";
      "target-currency" = "";
      "target-units" = "radian";
      "window-maximized" = false;
    };

    "org/gnome/desktop/interface" = {
      "color-scheme" = "prefer-dark";
      "cursor-theme" = "Yaru";
      "font-name" = "Roboto 11";
      "icon-theme" = "Tela-circle-dark";
    };

    "org/gnome/desktop/wm/preferences" = {
      "button-layout" = lib.mkForce "";
    };

    "org/gnome/nautilus/preferences" = {
      "default-folder-viewer" = "list-view";
      "migrated-gtk-settings" = true;
      "search-filter-time-type" = "last_modified";
      "search-view" = "list-view";
    };

    "org/gnome/nm-applet" = {
      "disable-connected-notifications" = true;
      "disable-vpn-notifications" = true;
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      "show-hidden" = true;
    };

    "org/gtk/settings/file-chooser" = {
      "date-format" = "regular";
      "location-mode" = "path-bar";
      "show-hidden" = true;
      "show-size-column" = true;
      "show-type-column" = true;
      "sort-column" = "name";
      "sort-directories-first" = false;
      "sort-order" = "ascending";
      "type-format" = "category";
      "view-type" = "list";
    };
  };
}
