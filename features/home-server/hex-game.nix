{
  flake.modules.nixos.home-server = {

    networking.firewall.allowedTCPPorts = [
      8080 # For hexa-game site
      9000 # For websocket
    ];
  };
}
