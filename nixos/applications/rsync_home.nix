{ pkgs, ...}: {
  # RSync backup job
  systemd.services."rsync-backup" = {
    path = [ pkgs.rsync pkgs.openssh ];
    script = ''
      rsync -avR --mkpath /home/ admin@192.168.1.200:/mnt/rust/archives/backups/nix-homes/$(hostname)/
      '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };

  systemd.timers."rsync-backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      Unit = "rsync-backup.service";
      OnCalendar = "daily";
      Persistent = true;
    };
  }; 
}
