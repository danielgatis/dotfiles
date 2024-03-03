-- luacheck: globals vim
vim = vim

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
vim.g.localmapleader = " "

-- Keymaps
vim.keymap.set("n", "<c-p>", function()
  require("fzf-lua").files()
end, { silent = true })
vim.keymap.set("n", "<c-s-p>", function()
  require("fzf-lua").live_grep()
end, { silent = true })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>f", "<cmd>NvimTreeFindFile<cr>")
vim.keymap.set("n", "<leader>dd", function()
  require("duck").hatch()
end)
vim.keymap.set("n", "<leader>dk", function()
  require("duck").cook()
end)
vim.keymap.set("n", "<m-tab>", "<cmd>BufferLineCycleNext<cr>")
vim.keymap.set("n", "<m-s-tab>", "<cmd>BufferLineCyclePrev<cr>")
vim.keymap.set("n", "<leader>gb", function()
  require("gitlinker").get_buf_range_url("n", { action_callback = require("gitlinker.actions").open_in_browser })
end, { silent = true })
vim.keymap.set("v", "<leader>gb", function()
  require("gitlinker").get_buf_range_url("v", { action_callback = require("gitlinker.actions").open_in_browser })
end, { silent = true })
vim.keymap.set("n", "tt", "<cmd>:Other<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>ff", function()
  require("conform").format({ async = true, lsp_fallback = true })
end)

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
  { "akinsho/bufferline.nvim", opts = { options = { offsets = { { filetype = "NvimTree" } } } } },
  { "folke/tokyonight.nvim" },
  { "folke/trouble.nvim", opts = {} },
  { "github/copilot.vim" },
  { "hrsh7th/nvim-cmp", event = "InsertEnter", dependencies = { "hrsh7th/cmp-buffer", "L3MON4D3/LuaSnip" } },
  {
    "ibhagwan/fzf-lua",
    opts = {
      winopts = { preview = { hidden = "hidden" } },
      file_ignore_patterns = { "node_modules/.*", "vendor/.*", "tmp/.*", ".git/.*" },
    },
  },
  { "ibhagwan/smartyank.nvim", opts = { highlight = { timeout = 200 } } },
  { "j-hui/fidget.nvim", version = "v1.*", opts = {} },
  { "mfussenegger/nvim-lint" },
  { "michaeljsmith/vim-indent-object" },
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp", "williamboman/mason-lspconfig.nvim" },
  },
  { "numToStr/Comment.nvim", opts = {} },
  {
    "nvim-lualine/lualine.nvim",
    opts = { options = { theme = "tokyonight" }, sections = { lualine_b = { "diff", "diagnostics" } } },
  },
  { "nvim-tree/nvim-tree.lua", opts = {} },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-treesitter/nvim-treesitter" },
  { "rgroli/other.nvim" },
  { "RRethy/nvim-treesitter-endwise" },
  { "ruifm/gitlinker.nvim" },
  { "stevearc/conform.nvim" },
  { "sunaku/tmux-navigate" },
  { "tamton-aquib/duck.nvim" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
  { "wellle/targets.vim" },
  { "williamboman/mason.nvim" },
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
  },
})

require("conform").setup({
  -- conform
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
  format_on_save = function(_) end,
  format_after_save = function(_) end,
})

-- lint
require("lint").linters_by_ft = {
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

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
  group = vim.api.nvim_create_augroup("lint", { clear = true }),
  callback = function()
    require("lint").try_lint()
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
require("lsp-zero").extend_cmp()
require("lsp-zero").extend_lspconfig()

require("lsp-zero").on_attach(function(_, bufnr)
  require("lsp-zero").default_keymaps({ buffer = bufnr })
end)

require("lsp-zero").set_server_config({
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

-- nvim-cmp
require("cmp").setup({
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer", keyword_length = 3 },
  },
  mapping = require("cmp").mapping.preset.insert({
    ["<CR>"] = require("cmp").mapping.confirm({ select = true }),
    ["<C-Space>"] = require("cmp").mapping.complete(),
  }),
  formatting = require("lsp-zero").cmp_format(),
})

--- mason
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = { "tsserver", "rust_analyzer" },
  handlers = {
    require("lsp-zero").default_setup,
    lua_ls = function()
      local lua_opts = require("lsp-zero").nvim_lua_ls()
      require("lspconfig").lua_ls.setup(lua_opts)
    end,
  },
})
