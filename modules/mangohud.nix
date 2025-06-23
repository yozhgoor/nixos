{ inputs, config, pkgs, shared, ... }:

{
  home-manager.users.${shared.username} = {
    home.packages = with pkgs; [
      mangohud
    ];

    home.file.".config/MangoHud/MangoHud.conf".text = ''
      legacy_layout=0
      horizontal
      hud_compact
      font_size=16

      fps
      cpu_stats
      gpu_stats
      ram
      vram
      time

      frametime=0
      time_format=%H:%M
    '';

    home.file.".config/MangoHud/presets.conf".text = ''
      [preset 1]
      fps_only
      font_size=16
    '';
  };
}
