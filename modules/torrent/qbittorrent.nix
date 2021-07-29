{ config, lib, pkgs, ... }:

# We don't strictly need this module, as there are no options we care about.
# Idem for a lot of other modules, honestly.
# Maybe we should do what Devos does, and introduce profiles. We'll get to that.

with lib;
with lib.my;
let cfg = config.modules.torrent.qbittorrent;
in {
  options.modules.torrent.qbittorrent = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ qbittorrent ];
  };
}
