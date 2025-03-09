{ config, lib, pkgs, ... }:

{
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
  };
}
