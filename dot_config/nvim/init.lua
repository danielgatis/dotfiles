-- Settings

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.signcolumn = 'yes'
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

-- Keymaps

vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')

-- Plugins

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Theming
  {'folke/tokyonight.nvim'},
  {'nvim-tree/nvim-web-devicons'},
  {'nvim-lualine/lualine.nvim'},
  {'akinsho/bufferline.nvim'},

  -- File Navigation
  {'nvim-tree/nvim-tree.lua'},
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
      {'nvim-lua/plenary.nvim'},
    }
  },

  -- Code manipulation
  {'nvim-treesitter/nvim-treesitter'},
  {'nvim-treesitter/nvim-treesitter-textobjects'},
  {'numToStr/Comment.nvim'},
  {'tpope/vim-surround'},
  {'wellle/targets.vim'},
  {'tpope/vim-repeat'},

  -- Utilities
  {'RRethy/nvim-treesitter-endwise'},
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'hrsh7th/cmp-nvim-lsp'},
      {'saadparwaiz1/cmp_luasnip'},
      {
        'zbirenbaum/copilot-cmp',
        dependencies = {
          {'zbirenbaum/copilot.lua'},
        },
      },

      -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
    },
  },
})

-- nvim-tree
require('nvim-tree').setup({})

-- comment
require('Comment').setup({})

-- telescope
require('telescope').load_extension('fzf')

-- luasnip
require('luasnip.loaders.from_vscode').lazy_load()

-- copilot
require('copilot').setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})

require('copilot_cmp').setup()

-- endwise
require('nvim-treesitter.configs').setup {
  endwise = { enable = true },
}

-- tokyonight
require('tokyonight').setup({
  style = 'night',
  transparent = true,
  dim_inactive = true,
  styles = {
    sidebars = 'transparent',
    floats = 'transparent',
  },
})

vim.cmd.colorscheme('tokyonight')

-- lualine
local theme = require('lualine.themes.tokyonight')
theme.normal.c.bg = 'none'

require('lualine').setup({
  options = {
    theme = theme,
    disabled_filetypes = {
      statusline = {'NvimTree'},
    },
  },
})

-- bufferline
require('bufferline').setup({
  options = {
    offsets = {
      {filetype = 'NvimTree'}
    },
  },
})

-- nvim-treesitter
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<cr>',
			node_incremental = '<cr>',
			scope_incremental = '<tab>',
			node_decremental = '<s-tab>',
		},
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      }
    },
  },
  ensure_installed = {
    'javascript',
    'typescript',
    'tsx',
    'lua',
    'vim',
    'vimdoc',
    'css',
    'json',
    'ruby',
    'python',
  },
})

-- lsp-zero
require('mason').setup({})
require('mason-lspconfig').setup({
  automatic_installation = true,
  ensure_installed = {
    'tsserver',
    'eslint',
    'html',
    'cssls',
    'solargraph',
  },
})

local lsp = require('lsp-zero').preset({})
lsp.preset('recommended')
lsp.nvim_workspace()

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<tab>'] = cmp_action.luasnip_supertab(),
  ['<s-tab>'] = cmp_action.luasnip_shift_supertab(),
  ['<cr>'] = cmp.mapping.confirm(),
  ['<c-space>'] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.setup()

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
    {name = 'copilot', keyword_length = 0},
  }
})

