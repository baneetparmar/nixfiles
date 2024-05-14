{ home, config, ... }:
let
  linkConf = config.lib.file.mkOutOfStoreSymlink;
  confPath = "/home/bane/.dotfiles/config/";
in {
  home.file = {
    ".config/lvim/config.lua" = {
      source = linkConf confPath + "lvim/config.lua";
    };
    # ".config/ags/" = { source = linkConf confPath + "ags"; };
    # ".config/tofi/" = { source = linkConf confPath + "tofi"; };
    # ".config/wezterm/" = { source = linkConf confPath + "wezterm"; };
    # ".config/hypr" = { source = linkConf confPath+"hypr";
    #   recursive = true;
    # };
  };
}
