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

vim.keymap.set('n', '<c-p>', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<c-s-p>', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeFindFileToggle<cr>')
vim.keymap.set('n', '<leader>dd', function() require('duck').hatch() end, {})
vim.keymap.set('n', '<leader>dk', function() require('duck').cook() end, {})
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<cr>')
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<cr>')
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<cr>')
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<cr>')
vim.keymap.set('n', '<m-tab>', '<cmd>BufferLineCycleNext<cr>')
vim.keymap.set('n', '<m-s-tab>', '<cmd>BufferLineCyclePrev<cr>')
vim.keymap.set('n', '<m-q>', '<cmd>lua require("bufdelete").bufdelete(0, true)<cr>')

-- Plugins

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
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
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	{ 'nvim-telescope/telescope.nvim', branch = '0.1.x', },
	{ 'nvim-tree/nvim-tree.lua' },
	{ 'nvim-tree/nvim-web-devicons' },
	{ 'nvim-treesitter/nvim-treesitter-textobjects' },
	{ 'nvim-treesitter/nvim-treesitter' },
	{ 'rafamadriz/friendly-snippets' },
	{ 'RRethy/nvim-treesitter-endwise' },
	{ 'saadparwaiz1/cmp_luasnip' },
	{ 'tamton-aquib/duck.nvim' },
	{ 'tpope/vim-repeat' },
	{ 'tpope/vim-surround' },
	{ 'VonHeikemen/lsp-zero.nvim', branch = 'v2.x', },
	{ 'wellle/targets.vim' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ 'williamboman/mason.nvim' },
  { 'famiu/bufdelete.nvim' },
  { 'folke/trouble.nvim' },
  { 'github/copilot.vim' },
  { 'mg979/vim-visual-multi', branch = 'master' },
  { 'nvim-pack/nvim-spectre' },
  { 'sunaku/tmux-navigate', lazy = false },
}, {
	install = {
		colorscheme = {
			'tokyonight-night',
		},
	},
})

-- tokyonight
vim.cmd('colorscheme tokyonight-night')

-- trouble
require('trouble').setup({})

-- nvim-tree
require('nvim-tree').setup({})

-- comment
require('Comment').setup({})

-- telescope
require('telescope').setup({
	defaults = {
		preview = false,
	},
})
require('telescope').load_extension('fzf')

-- luasnip
require('luasnip.loaders.from_vscode').lazy_load()

-- endwise
require('nvim-treesitter.configs').setup {
	endwise = { enable = true },
}

-- lualine
require('lualine').setup({
	options = {
		theme = 'tokyonight'
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
	lsp.default_keymaps({ buffer = bufnr })
	vim.keymap.set('n', 'gQ', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', {buffer = true})
	vim.keymap.set('n', 'gq', '<cmd>lua vim.lsp.buf.code_action()<cr>', {buffer = true})
end)
lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({
	mapping = {
		['<tab>'] = cmp_action.luasnip_supertab(),
		['<s-tab>'] = cmp_action.luasnip_shift_supertab(),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'path' },
		{ name = 'buffer' },
		{ name = 'luasnip' },
	}
})
