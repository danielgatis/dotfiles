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

-- Keymaps

vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<CR>')
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<CR>')
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')

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
	{ 'akinsho/bufferline.nvim' },
	{ 'folke/tokyonight.nvim' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-path' },
	{ 'hrsh7th/nvim-cmp' },
	{ 'L3MON4D3/LuaSnip' },
	{ 'neovim/nvim-lspconfig' },
	{ 'numToStr/Comment.nvim' },
	{ 'nvim-lua/plenary.nvim' },
	{ 'nvim-lualine/lualine.nvim' },
	{ 'nvim-telescope/telescope-fzf-native.nvim',   build = 'make' },
	{ 'nvim-telescope/telescope.nvim',              branch = '0.1.x', },
	{ 'nvim-tree/nvim-tree.lua' },
	{ 'nvim-tree/nvim-web-devicons' },
	{ 'nvim-treesitter/nvim-treesitter-textobjects' },
	{ 'nvim-treesitter/nvim-treesitter' },
	{ 'rafamadriz/friendly-snippets' },
	{ 'RRethy/nvim-treesitter-endwise' },
	{ 'saadparwaiz1/cmp_luasnip' },
	{ 'tpope/vim-repeat' },
	{ 'tpope/vim-surround' },
	{ 'VonHeikemen/lsp-zero.nvim',                  branch = 'v2.x', },
	{ 'wellle/targets.vim' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ 'williamboman/mason.nvim' },
	{ 'zbirenbaum/copilot-cmp' },
	{ 'zbirenbaum/copilot.lua' },
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
			statusline = { 'NvimTree' },
		},
	},
})

-- bufferline
require('bufferline').setup({
	options = {
		offsets = {
			{ filetype = 'NvimTree' }
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
			init_selection = '<CR>',
			node_incremental = '<CR>',
			scope_incremental = '<Tab>',
			node_decremental = '<S-Tab>',
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
	lsp.default_keymaps({ buffer = bufnr })
end)
lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({
	mapping = {
		['<Tab>'] = cmp_action.luasnip_supertab(),
		['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
		['<CR>'] = cmp.mapping.confirm({ select = false }),
		['<C-Space>'] = cmp.mapping.complete(),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'path' },
		{ name = 'buffer' },
		{ name = 'luasnip' },
		{ name = 'copilot' },
	}
})
