{ config, lib, pkgs, ... }:

{
  home.username = "yozhgoor";
  home.homeDirectory = "/home/yozhgoor";

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "ls --color=auto";
      grep = "grep --color=auto";
    };
    bashrcExtra = ''
      [[ $- != *i* ]] && return

      eval "$(starship init bash)"
    '';
    profileExtra = ''
      if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
        exec sway
      fi
    '';
  };

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      startup = [
        {command = "swaybg -m fill -i ${./bg.png}";}
      ];
      terminal = "alacritty";
      menu = "wofi --show drun";
      fonts = {
        names = ["Jetbrains Mono"];
	    size = 10.0;
      };
      window = {
        border = 0;
        titlebar = false;
      };
      bars = [{
        command = "${pkgs.waybar}/bin/waybar";
      }];
      output = {
        "eDP1" = {
          mode = "1920x1080@60Hz";
        };
      };
      defaultWorkspace = "workspace number 1";
      keybindings =
      let
        modifier = config.wayland.windowManager.sway.config.modifier;
        terminal = config.wayland.windowManager.sway.config.terminal;
      in lib.mkOptionDefault {
        "${modifier}+b" = "exec ${pkgs.firefox-wayland}/bin/firefox";
        "${modifier}+h" = "splith";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
        "XF86AudioRaiseVolume" = "exec 'wpctl set-volume @DEFAULT_SINK@ 5%+'";
        "XF86AudioLowerVolume" = "exec 'wpctl set-volume @DEFAULT_SINK@ 5%-'";
        "XF86AudioMute" = "exec 'wpctl set-mute @DEFAULT_SINK@ toggle'";
        "XF86AudioMicMute" = "exec 'wpctl set-mut @DEFAULT_SOURCE@ toggle";
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    swaybg
    brightnessctl
    wl-clipboard

    firefox-wayland

    spotify

    rustup
    gcc
    cmake

    cargo-temp
    cargo-release
    cargo-rdme
  ];

  home.file.".gitignore_global".text = ''
    # Rust
    debug/
    target/
    **/*.rs.bk
  '';

  programs.waybar = {
    enable = true;
    settings = [
      {
        height = 24;
        spacing = 5;
        modules-left = [ "sway/workspaces" ];
        modules-right = [
          "bluetooth"
          "backlight"
          "wireplumber"
          "temperature"
          "cpu"
          "memory"
          "disk"
          "network"
          "clock"
          "battery"
          "tray"
        ];
        "bluetooth" = {
          format = " {status}";
          format-disabled = "";
          format-off = "";
          format-connected = " {device_alias} connected";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
        };
        "backlight" = {
          format = "{percent}% ";
          on-scroll-up = "";
          on-scroll-down = "";
          tooltip = false;
        };
        "wireplumber" = {
          format = "{volume}% {icon}";
          format-muted = "";
          format-icons = [ "" "" "" ];
          on-scroll-up = "";
          on-scroll-down = "";
          tooltip = false;
        };
        "temperature" = {
          format = "{temperature}°C ";
          tooltip = false;
        };
        "cpu" = {
          interval = 10;
          format = "{}% ";
          max-length = 10;
          tooltip = false;
        };
        "memory" = {
          interval = 10;
          format = "{}% ";
          max-length = 10;
          tooltip = false;
        };
        "disk" = {
          interval = 30;
          format = "{percentage_used}% ";
          path = "/";
          unit = "GB";
          tooltip = false;
        };
        "network" = {
          format-wifi = "{essid} ";
          format-ethernet = "Wired ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ";
          tooltip = false;
        };
        "clock" = {
          format = "{:%H:%M %d/%m/%y}";
          tooltip = false;
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-full = "{icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-icons = [ "" "" "" "" "" ];
        };
        tray = {
          icon-size = 21;
          spacing = 5;
        };
      }
    ];
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: JetBrainsMono Nerd Font, font-awesome;
        font-size: 10px;
        min-height: 0;
        background-color: #101010;
        color: #00ff00;
      }

      #workspaces.button {
        padding: 0 5px;
        background: transparent;
        color: #a89984;
      }

      #workspace.button.focused {
        background: transparent;
        color: #00ff00;
      }

      #battery.charging {
        color: #282828;
        background-color: #00ff00;
      }

      #bluetooth, #backlight, #wireplumber, #temperature, #cpu, #memory, #disk, #network, #clock, #tray {
        margin-left: 5px;
        margin-right: 5px;
        padding: 0;
      }

      #battery {
        margin-left: 5px;
        margin-right: 10px;
        padding: 0;
      }
    '';
  };

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

  programs.git = {
    enable = true;
    userName = "yozhgoor";
    userEmail = "yozhgoor@outlook.com";
    extraConfig = {
      core = {
        editor = "nvim";
        excludesFiles = ".gitignore_global";
      };
      push = { autoSetupRemote = true; };
      pull = { rebase = false; };
      init = { defaultBranch = "main"; };
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 10;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
      };
      colors = {
        primary = {
          background = "0x101010";
          foreground = "0xd5C4A1";
        };
        normal = {
          black = "0x282828";
          red = "0xcc241d";
          green = "0x98971a";
          yellow = "0xd79921";
          blue = "0x458588";
          magenta = "0xb16286";
          cyan = "0x689d6a";
          white = "0xa89984";
        };
        bright = {
          black = "0x928374";
          red = "0xfb4934";
          green = "0x98971a";
          yellow = "0xfabd2f";
          blue = "0x83a598";
          magenta = "0xd3869b";
          cyan = "0x8ec07c";
          white = "0xebdbb2";
        };
        cursor = {
          text = "0x282828";
          cursor = "0x00ff00";
        };
        selection = {
          text = "0xebdbb2";
          background = "0x3c3836";
        };
      };
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        format = "[👽](bold #00FF00) ";
        success_symbol = "[👽](bold green) ";
        error_symbol = "[👽](bold red) ";
      };
      directory.style = "bold #00FF00";
      git_branch.style = "bold #00FF00";
      shell.style = "bold #00FF00";
      rust.style = "bold #00FF00";
      time.style = "bold #00FF00";
      package.disabled = true;
    };
  };

  programs.neovim = {
    enable = true;
    extraLuaConfig = ''
      vim.g.mapleader = ','

      vim.opt.lazyredraw = true
      vim.opt.updatetime = 100

      vim.opt.encoding = 'utf-8'
      vim.opt.autoread = true
      vim.opt.swapfile = false
      vim.opt.hidden = true

      vim.cmd('filetype on')
      vim.cmd('filetype plugin on')
      vim.cmd('filetype indent on')

      vim.opt.spell = true
      vim.opt.spelllang = 'en_us'

      vim.opt.showmatch = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.hlsearch = true
      vim.opt.incsearch = true
      vim.opt.shortmess:append("c")

      vim.opt.termguicolors = true
      vim.opt.signcolumn = 'yes:1'
      vim.opt.number = true
      vim.opt.cursorline = true
      vim.opt.colorcolumn = '100'
      vim.opt.textwidth = 100

      vim.opt.clipboard = 'unnamedplus'

      vim.keymap.set("", "<leader><Left>", ":bprev<CR>", { noremap = true, silent = true })
      vim.keymap.set("", "<leader><Right>", ":bnext<CR>", { noremap = true, silent = true })
      vim.keymap.set("", "<leader><Backspace>", ":bdel<CR>", { noremap = true, silent = true })

      vim.api.nvim_create_autocmd('BufWritePre', {
	      pattern = "*",
	      command = [[%s/\s\+$//e]]
      })

      vim.opt.tabstop = 4
      vim.opt.softtabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.smartindent = true
      vim.opt.expandtab = true
      vim.opt.breakindent = true

      vim.api.nvim_create_autocmd('FileType', {
	      pattern = 'javascript',
	      callback = function()
	        vim.opt_local.colorcolumn = '80'
	        vim.opt_local.textwidth = 80
	        vim.opt_local.tabstop = 2
	        vim.opt_local.softtabstop = 2
	        vim.opt_local.shiftwidth = 2
	      end
      })

      vim.api.nvim_create_autocmd('FileType', {
	      pattern = 'xml',
	      callback = function()
	        vim.opt_local.wrap = true
	        vim.opt_local.linebreak = true
	        vim.opt_local.colorcolumn = '80'
	        vim.opt_local.textwidth = 80
	        vim.opt_local.tabstop = 2
	        vim.opt_local.softtabstop = 2
	        vim.opt_local.shiftwidth = 2
	      end
      })

      vim.api.nvim_create_autocmd('FileType', {
	      pattern = 'yaml',
	      callback = function()
	        vim.opt_local.colorcolumn = '80'
	        vim.opt_local.textwidth = 80
	        vim.opt_local.tabstop = 2
	        vim.opt_local.softtabstop = 2
          vim.opt_local.shiftwidth = 2
	      end
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'nix',
        callback = function()
          vim.opt_local.colorcolumn = '80'
          vim.opt_local.textwidth = 80
          vim.opt_local.tabstop= 2
          vim.opt_local.softtabstop = 2
          vim.opt_local.shiftwidth = 2
        end
      })

      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
        },
      }
    '';

    plugins = with pkgs.vimPlugins; [
      {
        plugin = gruvbox-material;
        config = ''
          lua << EOF
          vim.opt.background = "dark"
          vim.g.gruvbox_material_background = "hard"
          vim.g.gruvbox_material_palette = "original"
          vim.cmd("colorscheme gruvbox-material")

          vim.cmd [[
            highlight Normal guibg=#101010
            highlight CursorLineNr guibg=#282828 ctermbg=darkgreen guifg=#00ff00 gui=NONE
            highlight StatusLine guifg=#00ff00 guibg=#282828 gui=bold
            highlight StatusLineNC guifg=#928374 guibg=#282828 gui=NONE
            highlight Visual guibg=#282828 guifg=#00ff00
          ]]
          EOF
        '';
      }

      {
        plugin = nvim-tree-lua;
        config = ''
          lua << EOF
          require('nvim-tree').setup({
            disable_netrw = true,
            diagnostics = {
              enable = true,
              icons = {
                hint = "!",
                info = "I",
                warning = "!",
                error = "X",
              },
            },
            modified = {
              enable = true,
            },
            actions = {
              open_file = {
                quit_on_open = true,
              }
            },
            filters = {
              git_ignored = false,
            },
          })
          vim.g.loaded_netrw = 1
          vim.g.loaded_netrwPlugin = 1
          vim.keymap.set("n", ",m", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
          EOF
        '';
      }

      {
        plugin = bufferline-nvim;
        config = ''
          lua << EOF
          require("bufferline").setup({
            options = {
              separator_style = "thin",
            },
            highlights = {
              buffer_selected = {
                fg = "#00ff00",
                bold = false,
                italic = false,
              },
              buffer_visible = {
                fg = "#a89984",
                bold = false,
                italic = false,
              },
              separator = {
                fg = "#282828",
                bg = "#282828",
              },
              separator_selected = {
                fg = "#00ff00",
                bg = "#282828",
              },
            },
          })
          EOF
        '';
      }

      (nvim-treesitter.withPlugins (p: [
        p.c
      	p.lua
	      p.vim
	      p.vimdoc
	      p.query
	      p.bash
	      p.comment
	      p.diff
	      p.regex
	      p.gitignore
	      p.gitcommit
	      p.html
	      p.markdown
	      p.python
	      p.rust
	      p.javascript
	      p.ron
	      p.toml
	      p.yaml
	      p.xml
	      p.json
	      p.nix
        p.latex
        p.mermaid
      ]))

      {
        plugin = nvim-autopairs;
        config = ''
          lua << EOF
          require("nvim-autopairs").setup({
            check_ts = true,
          })
          EOF
        '';
      }

      {
        plugin = gitsigns-nvim;
        config = ''
          lua << EOF
          require("gitsigns").setup({
            signs = {
              add = { text = "+" },
              change = { text = "~" },
              delete = { text = "-" },
            },
          })

          vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'GitGutterAdd' })
          vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'GitGutterChange' })
          vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'GitGutterDelete' })
          EOF
        '';
      }

      {
        plugin = render-markdown-nvim;
        config = ''
          lua << EOF
          require("render-markdown").setup({
            render_modes = true,
            heading = {
              sign = false,
              width = "block",
              min_width = 100,
              position = "inline",
              backgrounds = {},
            },
            code = {
              width = "block",
              min_width = 100,
            },
            latex = {
              enabled = false,
            },
            dash = { width = 100 },
          })

          vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function()
              vim.opt_local.conceallevel = 2
              vim.cmd [[
                highlight RenderMarkdownCode guibg=#181818
                highlight RenderMarkdownCodeInline guibg=#181818
              ]]
            end,
          })
          EOF
        '';
      }

      {
        plugin = nvim-lspconfig;
        config = ''
          lua << EOF
          require("lspconfig").rust_analyzer.setup({
            settings = {
              ["rust-analyzer"] = {
                imports = {
                  granularity = { group = "module" },
                },
                checkOnSave = { command = "clippy" },
                procMacro = { enable = true },
                inlayHints = {
                  parameterHints = { enable = true },
                  typeHints = { enable = true },
                },
              },
            },
          })

          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.rs",
            callback = function()
              vim.lsp.buf.format({ timeout_ms = 200 })
            end,
          })
          EOF
        '';
      }

      nvim-web-devicons
    ];
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
