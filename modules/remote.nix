{ inputs, config, pkgs, shared, ...}:

{
  home-manager.users.${shared.username} = {
    home.packages = with pkgs; [
      cloudflared
      freerdp
      socat
    ];
  };
}
