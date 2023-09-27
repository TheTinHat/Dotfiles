{ pkgs, ...}: {
  # RSync backup job
  systemd.services."rsync-backup" = {
    path = [ pkgs.rsync pkgs.openssh ];
    script = ''
      BACKUP_PATH="/mnt/rust/archives/backups/nix-homes/$HOSTNAME/"
      rsync -avR --mkpath /home/ admin@192.168.1.200:$BACKUP_PATH
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
      OnCalendar = "hourly";
      Persistent = true;
    };
  }; 
}
