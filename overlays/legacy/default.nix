{
  inputs,
  channels,
  ...
}:

final: _prev: {
  legacy = import channels.legacy {
    system = final.system;
    config.allowUnfree = true;
  };
}
