{ disks ? [ "/dev/vda" ]
, ...
}:
{
  disko.devices = {
    disk = {
      first = {
        type = "disk";
        device = builtins.elemAt disks 0;
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              name = "ESP";
              start = "1MiB";
              end = "512MiB";
              bootable = true;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            }
            {
              start = "512MiB";
              end = "100%";
              name = "primary";
              bootable = true;
              content = {
                type = "zfs";
                pool = "zroot";
              };
            }
          ];
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        options = {
          ashift = "12";
          autotrim = "on";
        };
        rootFsOptions = {
          mountpoint = "none";
          acltype = "posixacl";
          xattr = "sa";
          atime = "off";
        };
        datasets = {
          "zfs" = {
            type = "zfs_fs";
            options = {
              mountpoint = "none";
              encryption = "on";
              keyformat = "passphrase";
              keylocation = "prompt";
            };
          };
          "zfs/safe" = {
            type = "zfs_fs";
            options.mountpoint = "none";
            options."com.sun:auto-snapshot" = "true";
          };
          "zfs/safe/root" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/";
          };
          "zfs/local" = {
            type = "zfs_fs";
            options.mountpoint = "none";
          };
          "zfs/local/reserved" = {
            type = "zfs_fs";
            options.mountpoint = "none";
            options.refreservation = "2G";
          };
          "zfs/local/nix" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/nix";
          };
          "zfs/safe/home" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/home";
          };
          "zfs/local/tmp" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/tmp";
          };
          "zfs/local/docker" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/var/lib/docker";
          };
        };
      };
    };
  };
}

