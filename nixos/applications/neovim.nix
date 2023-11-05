
{ pkgs, ...}:
{
  imports = [../pkgs_override.nix];

  environment.variables = {
      EDITOR = "nvim";
    };

  environment.shellAliases = {
      vi = "nvim";
      vim = "nvim";
    };

  environment.systemPackages = with pkgs; [
    fd
    git
    lazygit
    neovim-unwrapped
    nerdfonts
    ripgrep
    unstable.cargo
    unstable.rustc
  ];
}
