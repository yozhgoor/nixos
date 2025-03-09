{ config, lib, pkgs, ...}:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
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
}
