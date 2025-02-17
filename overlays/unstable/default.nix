{
  inputs,
  channels,
  ...
}:

final: _prev: {
  unstable = import channels.unstable {
    system = final.system;
    config.allowUnfree = true;
  };
}
