-- lua/user/plugins.lua

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Telescope for fuzzy finding
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Nvim Tree for file explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {}
    end
  }

  -- Lualine for statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup {
        options = { theme = 'gruvbox' }
      }
    end
  }

  -- Colorscheme: Gruvbox
  use 'ellisonleao/gruvbox.nvim'

  -- Treesitter for better syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Comment plugin
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- Git signs
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  -- LSP Configurations
  use 'neovim/nvim-lspconfig'             -- LSP configurations
  use 'williamboman/mason.nvim'           -- LSP/DAP installer
  use 'williamboman/mason-lspconfig.nvim' -- Bridges mason and lspconfig
  use 'j-hui/fidget.nvim'                 -- LSP status updates
  use 'folke/neodev.nvim'                 -- Neovim Lua API completion

  -- Autocompletion plugins
  use 'hrsh7th/nvim-cmp'         -- Completion engine
  use 'hrsh7th/cmp-nvim-lsp'     -- LSP completions
  use 'hrsh7th/cmp-buffer'       -- Buffer completions
  use 'hrsh7th/cmp-path'         -- Path completions
  use 'hrsh7th/cmp-cmdline'      -- Command-line completions
  use 'saadparwaiz1/cmp_luasnip' -- Snippet completions

  -- Snippet engine
  use 'L3MON4D3/LuaSnip'             -- Snippet engine
  use 'rafamadriz/friendly-snippets' -- Snippet collection

  -- Rust tools
  use 'simrat39/rust-tools.nvim'

  -- Flutter tools
  use {
    'akinsho/flutter-tools.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }

  -- Twilight plugin for dimming inactive code
  use {
    'folke/twilight.nvim',
    config = function()
      require('twilight').setup {}
    end
  }

  -- Add vim-dadbod
  use {
    'tpope/vim-dadbod'
  }

  -- Add vim-dadbod-ui
  use {
    'kristijanhusak/vim-dadbod-ui',
    requires = 'tpope/vim-dadbod',
    config = function()
      vim.g.db_ui_save_location = '~/.config/nvim/db_ui' -- Optional: Set UI save location
    end
  }

  -- Automatically set up configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)
