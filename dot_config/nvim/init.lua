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
vim.g.copilot_no_tab_map = true
vim.g.lsp_zero_extend_cmp = 0
vim.g.lsp_zero_extend_lspconfig = 0
vim.g.blamer_enabled = 1
vim.g.blamer_show_in_insert_modes = 0

-- Keymaps
vim.keymap.set("n", "<c-p>", "<cmd>lua require('fzf-lua').files()<cr>", { silent = true })
vim.keymap.set("n", "<c-s-p>", "<cmd>lua require('fzf-lua').live_grep()<cr>", { silent = true })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>f", "<cmd>NvimTreeFindFile<cr>")
vim.keymap.set("n", "<leader>dd", function() require("duck").hatch() end)
vim.keymap.set("n", "<leader>dk", function() require("duck").cook() end)
vim.keymap.set("n", "<m-tab>", "<cmd>BufferLineCycleNext<cr>")
vim.keymap.set("n", "<m-s-tab>", "<cmd>BufferLineCyclePrev<cr>")
vim.keymap.set("n", "<m-q>", '<cmd>lua require("bufdelete").bufdelete(0, true)<cr>')
vim.keymap.set("n", "<leader>gb", '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', { silent = true })
vim.keymap.set("v", "<leader>gb", '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', { silent = true })
vim.keymap.set("i", "<c-cr>", 'copilot#Accept("\\<cr>")', { expr = true, replace_keycodes = false })
vim.keymap.set("n", "tt", "<cmd>:Other<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true })

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

require("lazy").setup({
  { "akinsho/bufferline.nvim" },
  { "APZelos/blamer.nvim" },
  { "famiu/bufdelete.nvim" },
  { "folke/tokyonight.nvim" },
  { "folke/trouble.nvim" },
  { "github/copilot.vim" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/nvim-cmp", event = "InsertEnter" },
  { "ibhagwan/fzf-lua" },
  { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
  { "mfussenegger/nvim-lint" },
  { "mg979/vim-visual-multi", branch = "master" },
  { "neovim/nvim-lspconfig", cmd = { "LspInfo", "LspInstall", "LspStart" }, event = { "BufReadPre", "BufNewFile" } },
  { "numToStr/Comment.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-lualine/lualine.nvim" },
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
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
  format_on_save = {
    timeout_ms = 500,
    async = false,
    lsp_fallback = true,
  },
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

-- trouble
require("trouble").setup({})

-- nvim-tree
require("nvim-tree").setup({})

-- comment
require("Comment").setup({})

-- fzf-lua
require("fzf-lua").setup({
  file_ignore_patterns = { 'node_modules/.*', 'vendor/.*', 'tmp/.*', '.git/.*'},
})

-- endwise
require("nvim-treesitter.configs").setup({
  endwise = { enable = true },
})

-- lualine
require("lualine").setup({
  options = {
    theme = "tokyonight",
  },
})

-- bufferline
require("bufferline").setup({
  options = {
    offsets = {
      { filetype = "NvimTree" },
    },
  },
})

-- nvim-treesitter
require("nvim-treesitter.configs").setup({
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
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
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
lsp_zero.extend_cmp()
lsp_zero.extend_lspconfig()
lsp_zero.on_attach(function(_, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
  vim.keymap.set("n", "gQ", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", { buffer = true })
  vim.keymap.set("n", "gq", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer = true })
end)

-- cmp
local cmp = require("cmp")
local cmp_format = require("lsp-zero").cmp_format()
local cmp_action = require("lsp-zero").cmp_action()

cmp.setup({
  formatting = cmp_format,
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp_action.luasnip_supertab(),
    ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
  }),
  sources = {
    {
      name = "nvim_lsp",
      entry_filter = function(entry)
        return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
      end,
    },
    { name = "nvim_lua" },
    { name = "buffer" },
    { name = "path" },
  },
})

-- mason
require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = {
    "tsserver",
    "eslint",
    "html",
    "cssls",
    "solargraph",
    "gopls",
  },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require("lspconfig").lua_ls.setup(lua_opts)
    end,
  },
})
