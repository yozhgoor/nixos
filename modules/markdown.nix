# configuration related to Markdown
{ inputs, config, pkgs, shared, ... }:

{
  programs.nixvim = {
    plugins.render-markdown = {
      enable = true;
      lazyLoad.settings.ft = "markdown";
      settings = {
        heading = {
          sign = false;
          width = "block";
          min_width = 100;
          position = "inline";
        };
        code = {
          sign = false;
          width = "block";
          min_width = 100;
        };
        dash.width = 100;
        sign.enable = false;
        latex = {
          enabled = true;
          render_modes = false;
          converter = "latex2text";
          highlight = "RenderMarkdownMath";
          position = "above";
          top_pad = 0;
          bottom_pad = 0;
          virtual = false;
        };
      };
    };
    autoCmd = [
      {
        event = "FileType";
        pattern = "markdown";
        callback = {
          __raw = ''
            function()
              vim.opt_local.conceallevel = 2

              for i = 1,6 do
                vim.api.nvim_set_hl(0, "RenderMarkdownH" .. i .. "Bg", { bg = "NONE" })
              end
            end
          '';
        };
      }
    ];
  };
  home-manager.users.${shared.username} = {
    home.packages = with pkgs; [
      python3Packages.pylatexenc
    ];
  };
}
