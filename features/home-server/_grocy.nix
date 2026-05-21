{
  flake.modules.nixos.home-server = {

    networking.firewall.allowedTCPPorts = [
      80 # For Grocy
    ];

    ## Grocy: Go to https://localhost:80 (80 default port)
    services.grocy.enable = true;
    services.grocy.hostName = "localhost";
    services.grocy.nginx.enableSSL = false;
    services.grocy.settings = {
      currency = "DKK";
      calendar.showWeekNumber = true;

      calendar.firstDayOfWeek = 1;
    };

  };

}
