-- Settings
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.termguicolors = true

-- Global Variables
vim.g.mapleader = " "

-- Keymaps
vim.keymap.set("n", "<c-p>", "<cmd>lua require('fzf-lua').files()<cr>", { silent = true })
vim.keymap.set("n", "<c-s-p>", "<cmd>lua require('fzf-lua').live_grep()<cr>", { silent = true })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>f", "<cmd>NvimTreeFindFile<cr>")
vim.keymap.set("n", "<leader>dd", function() require("duck").hatch() end)
vim.keymap.set("n", "<leader>dk", function() require("duck").cook() end)
vim.keymap.set("n", "<m-tab>", "<cmd>BufferLineCycleNext<cr>")
vim.keymap.set("n", "<m-s-tab>", "<cmd>BufferLineCyclePrev<cr>")
vim.keymap.set("n", "<leader>gb", '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', { silent = true })
vim.keymap.set("v", "<leader>gb", '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', { silent = true })
vim.keymap.set("n", "tt", "<cmd>:Other<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true })

-- Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "akinsho/bufferline.nvim", opts = { options = { offsets = { { filetype = "NvimTree" } } } } },
  { "folke/tokyonight.nvim" },
  { "folke/trouble.nvim", opts = {} },
  { "github/copilot.vim" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/nvim-cmp" },
  { "ibhagwan/fzf-lua", opts = { winopts = { preview = {  hidden = 'hidden' } }, file_ignore_patterns = { 'node_modules/.*', 'vendor/.*', 'tmp/.*', '.git/.*' } } },
  { "ibhagwan/smartyank.nvim", opts = {  highlight = { timeout = 200 } } },
  { "j-hui/fidget.nvim", version = "v1.*", opts = {} },
  { "L3MON4D3/LuaSnip" },
  { "mfussenegger/nvim-lint" },
  { "michaeljsmith/vim-indent-object" },
  { "neovim/nvim-lspconfig" },
  { "numToStr/Comment.nvim", opts = {} },
  { "nvim-lua/plenary.nvim" },
  { "nvim-lualine/lualine.nvim", opts = { options = { theme = "tokyonight" }, sections = {  lualine_b = {'diff', 'diagnostics'} } } },
  { "nvim-tree/nvim-tree.lua", opts = {} },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-treesitter/nvim-treesitter" },
  { "rgroli/other.nvim" },
  { "RRethy/nvim-treesitter-endwise" },
  { "ruifm/gitlinker.nvim" },
  { "stevearc/conform.nvim" },
  { "sunaku/tmux-navigate", lazy = false },
  { "tamton-aquib/duck.nvim" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "VonHeikemen/lsp-zero.nvim", branch = "v3.x", lazy = true, config = false },
  { "wellle/targets.vim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "williamboman/mason.nvim", lazy = false, config = true },
}, {
  install = {
    colorscheme = {
      "tokyonight-night",
    },
  },
})

-- tokyonight
vim.cmd("colorscheme tokyonight-night")

-- other
require("other-nvim").setup({
  mappings = {
    { pattern = "(.*).ts$", target = "%1.test.ts" },
    { pattern = "(.*).test.ts$", target = "%1.ts" },
    { pattern = "(.*).tsx$", target = "%1.test.tsx" },
    { pattern = "(.*).test.tsx$", target = "%1.tsx" },
    { pattern = "(.*).js$", target = "%1.test.js" },
    { pattern = "(.*).test.js$", target = "%1.js" },
    { pattern = "(.*).jsx$", target = "%1.test.jsx" },
    { pattern = "(.*).test.jsx$", target = "%1.jsx" },
    { pattern = "(.*).go$", target = "%1_test.go" },
    { pattern = "(.*)_test.go$", target = "%1.go" },
    { pattern = "app/(.*).rb$", target = "spec/%1_spec.rb" },
    { pattern = "spec/(.*)_spec.rb$", target = "app/%1.rb" },
  },
  hooks = {
    onFindOtherFiles = function(matches)
      local filtered_matches = {}
      for _, match in ipairs(matches) do
        if not string.match(match.filename, ".test.test.") then
          table.insert(filtered_matches, match)
        end
      end
      return filtered_matches
    end,
  }
})

-- conform
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { { "prettierd", "prettier" } },
    typescript = { { "prettierd", "prettier" } },
    typescriptreact = { { "prettierd", "prettier" } },
    javascriptreact = { { "prettierd", "prettier" } },
    html = { { "prettierd", "prettier" } },
    css = { { "prettierd", "prettier" } },
    json = { { "prettierd", "prettier" } },
    yaml = { { "prettierd", "prettier" } },
    ruby = { "rubocop" },
    go = { "gofmt" },
  },
  format_on_save = function(bufnr)  end,
  format_after_save = function(bufnr)  end,
})

-- lint
local lint = require("lint")
lint.linters_by_ft = {
  javascript = { "eslint_d", "eslint" },
  typescript = { "eslint_d", "eslint" },
  typescriptreact = { "eslint_d", "eslint" },
  javascriptreact = { "eslint_d", "eslint" },
  html = { "eslint_d", "eslint" },
  css = { "stylelint" },
  json = { "jsonlint" },
  yaml = { "yamllint" },
  ruby = { "rubocop" },
  go = { "golangcilint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

-- nvim-treesitter
require("nvim-treesitter.configs").setup({
  endwise = { enable = true },
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "+",
      node_incremental = "+",
      node_decremental = "-",
    },
  },
  ensure_installed = {
    "javascript",
    "typescript",
    "tsx",
    "lua",
    "vim",
    "vimdoc",
    "css",
    "json",
    "ruby",
    "python",
    "go",
  },
})

-- lsp-zero
local lsp_zero = require("lsp-zero")
lsp_zero.on_attach(function(_, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
  vim.keymap.set("n", "gq", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", { buffer = true })
  vim.keymap.set("n", "gQ", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer = true })
end)

local cmp = require('cmp')
cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_length = 3},
  },
  mapping = cmp.mapping.preset.insert({
    ['<Enter>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  formatting = lsp_zero.cmp_format(),
})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'tsserver', 'rust_analyzer'},
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})
