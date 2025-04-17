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
}
