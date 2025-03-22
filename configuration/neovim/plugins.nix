{ inputs, config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
          delete.text = "-";
        };
      };

      web-devicons.enable = true;
      toggleterm.enable = true;
      lz-n.enable = true;
      bufferline.enable = true;

      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
        eventHandlers.file_opened = ''
          function(file_path)
            require("neo-tree").close_all()
          end
        '';
        filesystem.filteredItems.hideDotfiles = false;
      };

      treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          highlight.enable = true;
        };

        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          c
          comment
          diff
          gitignore
          gitcommit
          html
          javascript
          json
          latex
          lua
          markdown
          mermaid
          nix
          python
          query
          regex
          ron
          rust
          toml
          vim
          vimdoc
          xml
          yaml
        ];
      };

      nvim-autopairs = {
        enable = true;
        settings.check_ts = true;
      };

      render-markdown = {
        enable = true;
        lazyLoad.settings.ft = "markdown";
        settings = {
          render_modes = true;
          heading = {
            sign = false;
            width = "block";
            min_width = 100;
            position = "inline";
            backgrounds = {};
          };
          code = {
            width = "block";
            min_width = 100;
          };
          dash.width = 100;
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
            end
          '';
        };
      }
    ];

    keymaps = [
      # Toggle neo-tree
      {
	      mode = "n";
	      key = "<leader>m";
	      action = ":Neotree toggle<CR>";
	      options = {
	        silent = true;
	        noremap = true;
	      };
      }

      # Toggle terminal
      {
        mode = "n";
        key = "<leader><Up>";
        action = ":ToggleTerm toggle<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }
    ];
  };
}
