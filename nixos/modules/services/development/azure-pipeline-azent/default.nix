# Systemd service for azure-pipeline-agent

{
  config,
  lib,
  pkgs,
  azure-pipeline-agent
}:

let 
  cfg = config.services.azure-pipeline-agent;
in

{
  option = {
    services.azure-pipeline-agent = {
      enable = mkEnableOption {
        type = types.bool;
        default = false;
        description =''
          This option enables azure-pipeline-agent.
        '';
      };

      AgentRoot = mkOption {
        type = types.str;
        default = "/home/vsts/agent/";
        description =''
          AgentRoot Path
        '';
      };
      
      package = lib.mkPackageOption "azure-pipeline-agent" {};
    };
  };

  config = mkIf cfg.enable {
    users.users.vsts = {
      group = "vsts";
      home = "/home/vsts/";
      createHome = true;
    };
    
    users.groups.vsts = {};

    systemd.services.azure-pipeline-agent = {
      description = "Azure Pipeline Agent";
      after = [
        "network.target"
      ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart =
          ''
            mkdir -p /home/vsts/agent
            ${cfg.package}/runsvc.sh
          '';
        User = cfg.user;
        WorkingDirectory = ${cfg.AgentRoot};
        KillMode = "process";
        killSignal = "SIGTERM";
        TimeoutStopSec = "5min";
      }
    };
  };
}
