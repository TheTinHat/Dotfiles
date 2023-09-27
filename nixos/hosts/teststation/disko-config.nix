{ ... } : {
  disko.devices = {
    disk = {
        vda = {
            type = "disk";
            device = "/dev/vda";
            content = {
                type = "gpt";
                partitions = {
                    ESP = {
                        size = "128M";
                        type = "EF00";
                        content = {
                            type = "filesystem";
                            format = "vfat";
                            mountpoint = "/boot";
                          };
                      };
                    zfs = {
                        size = "100%";
                        content = {
                            type = "zfs";
                            pool = "zroot";
                          };
                      };
                  };
              };
          };
      };
      zpool = {
          zroot = {
              type = "zpool";
              rootFsOptions = {
                  compression = "zstd";
                  "com.sun:auto-snapshot" = "false";
                };
              datasets = {
                  encrypted = {
                      type = "zfs_fs";
                      options = {
                          mountpoint = "none";
                          encryption = "aes-256-gcm";
                          keyformat = "passphrase";
                          keylocation = "file:///tmp/secret.key";
                        };
                        postCreateHook = ''
                          zfs set keylocation="prompt" "zroot/$name";
                        '';
                    };
                  "root" = {
                      mountpoint = "/";
                      type = "zfs_fs";
                      options.mountpoint = "legacy";
                      postCreateHook = "zfs snapshot zroot@blank";
                    };
                  "root/nix" = {
                      mountpoint = "/nix";
                      type = "zfs_fs";
                      options.mountpoint = "legacy";
                    };
                  "root/home" = {
                      mountpoint = "/home";
                      type = "zfs_fs";
                      options.mountpoint = "legacy";
                      postCreateHook = "zfs snapshot zroot@blank";
                      options."com.sun:auto-snapshot" = "true";
                    };
                };
            };
        };
    };
  }
