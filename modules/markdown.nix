# configuration related to Markdown
{ inputs, config, pkgs, shared, ... }:

{
  programs.nixvim = {
    plugins.render-markdown = {
      enable = true;
      lazyLoad.settings.ft = "markdown";
      settings = {
        render_modes = true;
        heading = {
          sign = false;
          width = "block";
          min_width = 100;
          position = "inline";
        };
        code = {
          width = "block";
          min_width = 100;
        };
        dash.width = 100;
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
            end
          '';
        };
      }
    ];
  };
}
