-- Settings
vim.opt.breakindent = true
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.scrolloff = 10
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.updatetime = 250
vim.opt.wrap = true

-- Global Variables
vim.g.mapleader = " "
vim.g.localmapleader = " "

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
  {
    "junegunn/fzf",
    event = "VeryLazy",
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
  },
  {
    "famiu/bufdelete.nvim",
    keys = {
      { "<c-x>",     "<cmd>lua require('bufdelete').bufdelete(0, true)<cr>", "n" },
      { "<c-tab>",   "<cmd>BufferLineCycleNext<cr>",                         "n" },
      { "<c-s-tab>", "<cmd>BufferLineCyclePrev<cr>",                         "n" },
    }
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<m-tab>",   "<cmd>BufferLineCycleNext<cr>", "n" },
      { "<m-s-tab>", "<cmd>BufferLineCyclePrev<cr>", "n" },
    },
    opts = { options = { offsets = { { filetype = "NvimTree" } } } }
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  {
    "folke/trouble.nvim",
    config = true
  },
  {
    "github/copilot.vim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" }
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = { "hrsh7th/cmp-buffer", "L3MON4D3/LuaSnip" },
    config = function()
      local cmp = require("cmp")
      local lspzero = require("lsp-zero")
      cmp.setup({
        formatting = lspzero.cmp_format(),
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer",  keyword_length = 3 },
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        })
      })
    end
  },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<c-p>",   function() require("fzf-lua").files() end,     "n" },
      { "<c-s-p>", function() require("fzf-lua").live_grep() end, "n" },
    },
    opts = {
      winopts = { preview = { hidden = "hidden" } },
      file_ignore_patterns = { "node_modules/.*", "vendor/.*", "tmp/.*", ".git/.*" },
    },
  },
  {
    "ibhagwan/smartyank.nvim",
    opts = { highlight = { timeout = 200 } }
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      linters_by_ft = {
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
      },
    },
    config = function()
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        callback = function()
          require("lint").try_lint()
        end,
      })
    end
  },
  {
    "michaeljsmith/vim-indent-object",
    event = "VeryLazy"
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "j-hui/fidget.nvim" },
    },
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = true
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = { options = { theme = "tokyonight" }, sections = { lualine_b = { "diff", "diagnostics" } } },
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = true,
    keys = {
      { "<leader>e", "<cmd>:NvimTreeFindFileToggle<cr>" },
    },
    opts = { view = { side = "right" } }
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    dependencies = { "RRethy/nvim-treesitter-endwise" },
    opts = {
      endwise = { enable = true },
      highlight = { enable = true },
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
    }
  },
  {
    "rgroli/other.nvim",
    keys = { { "<leader>t", "<cmd>:Other<cr>" } },
    opt = {
      mappings = {
        { pattern = "(.*).ts$",           target = "%1.test.ts" },
        { pattern = "(.*).test.ts$",      target = "%1.ts" },
        { pattern = "(.*).tsx$",          target = "%1.test.tsx" },
        { pattern = "(.*).test.tsx$",     target = "%1.tsx" },
        { pattern = "(.*).js$",           target = "%1.test.js" },
        { pattern = "(.*).test.js$",      target = "%1.js" },
        { pattern = "(.*).jsx$",          target = "%1.test.jsx" },
        { pattern = "(.*).test.jsx$",     target = "%1.jsx" },
        { pattern = "(.*).go$",           target = "%1_test.go" },
        { pattern = "(.*)_test.go$",      target = "%1.go" },
        { pattern = "app/(.*).rb$",       target = "spec/%1_spec.rb" },
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
    },
  },
  {
    "ruifm/gitlinker.nvim",
    keys = {
      { "<leader>gb", function()
        require("gitlinker").get_buf_range_url("n", { action_callback = require("gitlinker.actions").open_in_browser })
      end, { "n", "v" } }
    }
  },
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>ff",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        { "n", "v" },
      },
    },
    opt = {
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
    },
  },
  {
    "sunaku/tmux-navigate",
    event = { "VeryLazy" },
  },
  {
    "tamton-aquib/duck.nvim",
    keys = {
      {
        "<leader>dd",
        function()
          require("duck").hatch()
        end,
        "n",
      },
      {
        "<leader>dk",
        function()
          require("duck").cook()
        end,
        "n",
      },
    },
  },
  {
    "tpope/vim-repeat",
    event = { "VeryLazy" },
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
  },
  {
    "wellle/targets.vim",
    event = { "VeryLazy" },
  },
}, {
  install = {
    colorscheme = {
      "tokyonight-night",
    },
  },
})

local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(_, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
end)
lsp_zero.set_server_config({
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  },
})
