{...}:
{
  programs.aria2 = {
    enable = true;
    settings = {
      max-concurrent-downloads = 1;
    };
  };
}
