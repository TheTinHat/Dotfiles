{ disks ? [ "/dev/nvme0n1" ]
, zpoolName ? "zpool"
, zpoolHome ? true
, zpoolTmp ? false
, zpoolDocker ? false
, ...
}:
{ lib, ... }:
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
      "${zpoolName}" = {
        type = "zpool";
        rootFsOptions = {
          mountpoint = "none";
          acltype = "posixacl";
          xattr = "sa";
          atime = "off";
          ashift = "12";
          encryption = "on";
          keyformat = "passphrase";
        };
        datasets = {
          "safe" = {
            type = "zfs_fs";
            options.mountpoint = "none";
            options.compression = "lz4";
            options."com.sun:auto-snapshot" = "true";
          };
          "safe/root" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/";
          };
          "local" = {
            type = "zfs_fs";
            options.mountpoint = "none";
            options.compression = "lz4";
          };
          "local/reserved" = {
            type = "zfs_fs";
            options.mountpoint = "none";
            options.refreservation = "2G";
          };
          "local/nix" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/nix";
          };
        } // lib.optionalAttrs zpoolHome {
          "safe/home" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/home";
          };
        } // lib.optionalAttrs zpoolTmp {
          "local/tmp" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/tmp";
          };
        } // lib.optionalAttrs zpoolDocker {
          "local/docker" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/var/lib/docker";
          };
        };
      };
    };
  };
}

