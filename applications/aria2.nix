{ ... }: {
  programs.aria2 = {
    enable = true;
    settings = {
      dir = "/home/bane/Downloads/";
      continue = true;
      max-concurrent-downloads = 1;
      max-connection-per-server = 16;
    };
  };
}
