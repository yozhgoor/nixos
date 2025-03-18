{ config, pkgs, ... }:

{
  programs.wofi = {
    enable = true;
    style = ''
      window, #outer-box, #input, #scroll, #inner-box, #entry, #text {
        background-color: #101010;
        color: #00ff00;
      }

      #entry.selected {
        background-color: #181818;
        border: none;
      }
    '';
  };
}
