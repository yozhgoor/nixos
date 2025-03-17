{ inputs, config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes.gruvbox.enable = true;

    viAlias = true;
    vimAlias = true;

    withPython3 = false;
    withRuby = false;

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    globals.mapleader = ",";

    opts = {
      lazyredraw = true;
      updatetime = 100;

      encoding = "utf-8";
      autoread = true;
      swapfile = false;
      hidden = true;

      spell = true;
      spelllang = "en_us";

      showmatch = true;
      ignorecase = true;
      smartcase = true;
      hlsearch = true;
      incsearch = true;
      
      termguicolors = true;
      signcolumn = "yes:1";
      number = true;
      cursorline = true;
      colorcolumn = "100";
      textwidth = 100;

      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      smartindent = true;
      expandtab = true;
      breakindent = true;
    };

    keymaps = [
      {
        key = "<leader><Left>";
        action = ":bprev<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        key = "<leader><Right>";
        action = ":bnext<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        key = "<leader><Down>";
        action = ":bdel<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }

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

    autoCmd = [
      {
        event = "BufWritePre";
        pattern = "*";
        command = "%s/\s\+$//e";
      }
    
      {
        event = "FileType";
        pattern = [ "nix" "javascript" "yaml" ];
        callback = {
          __raw = "
            function()
              vim.opt_local.tabstop = 2
              vim.opt_local.softtabstop = 2
              vim.opt_local.shiftwidth = 2
            end
          "; 
        };
      }

      {
        event = "FileType";
        pattern = "xml";
        callback = {
          __raw = "
            function()
              vim.opt_local.wrap = true
              vim.opt_local.linebreak = true
              vim.opt_local.tabstop = 2
              vim.opt_local.softtabstop = 2
              vim.opt_local.shiftwidth = 2
            end
          ";
        };
      }

      {
        event = "FileType";
        pattern = "markdown";
        callback = {
          __raw = "
            function()
              vim.opt_local.conceallevel = 2
            end
          ";
        };
      }

      {
        event = "FileType";
        pattern = "rust";
        callback = {
          __raw = "
            function()
              vim.lsp.buf.format({ timeout_ms = 200 })
            end
          ";
        };
      }
    ];

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

      bufferline = {
        enable = true;
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

      toggleterm = {
        enable = true;
      };

      lz-n.enable = true;

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

      lsp = {
        enable = true;
        lazyLoad.settings.ft = "rust";
        inlayHints = true;
        servers.rust_analyzer = {
          enable = true;

          installCargo = false;
          installRustc = false;

          settings = {
            cargo.features = "all";
            checkOnSave = true;
            check.command = "clippy";
            imports.granularity.group = "module";
            procMacro.enable = true;
            inlayHints = {
              parameterHints.enable = true;
              typeHints.enable = true;
            };
          };
        };
      };
    };
  };
}
