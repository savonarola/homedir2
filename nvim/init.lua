vim.g.mapleader = ","

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use { 'neovim/nvim-lspconfig' }

  use {
    'williamboman/nvim-lsp-installer',
    config = function()
      local lsp_installer = require("nvim-lsp-installer")

      lsp_installer.on_server_ready(function(server)
        local opts = {}
        if server.name == "erlangls" then
            local lspconfig = require('lspconfig')
            opts.root_dir = lspconfig.util.root_pattern('erlang_ls.config')
        end
        server:setup(opts)
      end)
    end
  }

  use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
  use { 'ms-jpq/coq.thirdparty', branch = '3p' }
  use {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    config = function()
      require("coq")

      local fn = vim.fn
      local deps_path = fn.stdpath('data')..'/site/pack/packer/start/coq_nvim/.vars/runtime/requirements.lock'
      if fn.empty(fn.glob(deps_path)) > 0 then
        vim.cmd [[COQdeps]]
      end
      
      vim.cmd [[COQnow -s]]
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'} },
    config = function()
      require("telescope").setup()
      vim.cmd [[
        nnoremap <leader>fp <cmd>Telescope find_files<cr>
        nnoremap <leader>g <cmd>Telescope live_grep<cr>
        nnoremap <leader>fb <cmd>Telescope buffers<cr>
        nnoremap <leader>fh <cmd>Telescope help_tags<cr>
      ]]
    end
  }

  use 'junegunn/fzf'
  use {
    'junegunn/fzf.vim',
    config = function()
      vim.cmd [[
        nnoremap <leader>p <cmd>FZF<cr>
        nnoremap <leader>b <cmd>Buffers<cr>
        let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
      ]]
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require("nvim-tree").setup()
      vim.cmd [[
        nnoremap <leader>t <cmd>NvimTreeToggle<cr>
      ]]
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("gitsigns").setup()
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function()
      local powerline_dark = require('lualine.themes.powerline_dark')
      require('lualine').setup{
        options = { theme  = powerline_dark }
      }
    end
  }

  use { 
    'b3nj5m1n/kommentary',
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>kommentary_line_increase", {})
      vim.api.nvim_set_keymap("n", "<leader>cu", "<Plug>kommentary_line_decrease", {})
      vim.api.nvim_set_keymap("x", "<leader>cc", "<Plug>kommentary_visual_increase", {})
      vim.api.nvim_set_keymap("x", "<leader>cu", "<Plug>kommentary_visual_decrease", {})
    end
  }

  use {
    'sbdchd/neoformat',
    config = function()
      vim.g.neoformat_erlang_erlfmt = { exe = "erlfmt" }
      vim.g.neoformat_enabled_erlang = { "erlfmt" }
    end
  }
    
  use {
    "Pocco81/AutoSave.nvim",
    config = function()
      require("autosave").setup()
    end
  }

  use 'elixir-lang/vim-elixir'
  use 'chr4/nginx.vim'

  use {
    'Mofiqul/vscode.nvim',
    config = function()
      vim.g.vscode_style = "dark"
      vim.cmd [[colorscheme vscode]]
    end
  }
  
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("indent_blankline").setup {
          buftype_exclude = {"terminal", "nofile"}
      }
    end
  }

end)

vim.cmd [[
  set undodir=~/.vim-undo
  set undofile

	set novisualbell
	set t_vb=
	set nobackup
	set noswapfile

	set number

  " set clipboard+=unnamedplus

  nmap <c-c> "+y
  vmap <c-c> "+y
  inoremap <c-v> <c-r>+
  cnoremap <c-v> <c-r>+
  inoremap <c-r> <c-v>

  map Q <Nop>

  vmap > >gv
  vmap < <gv

  set grepprg=rg\ --vimgrep\ --no-heading\ --hidden\ --smart-case
  set grepformat=%f:%l:%c:%m
]]

