return {
  {
    'monaqa/dial.nvim',
    keys = {
      {
        '<C-a>',
        function()
          return require('dial.map').inc_normal()
        end,
        expr = true,
      },
      {
        '<C-x>',
        function()
          return require('dial.map').dec_normal()
        end,
        expr = true,
      },
    },
    config = function()
      local augend = require 'dial.augend'
      require('dial.config').augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias['%Y/%m/%d'],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new { elements = { 'let', 'const' } },
          augend.constant.new { elements = { 'True', 'False' } },
        },
      }
    end,
  },
  {
    'github/copilot.vim',
    cmd = { 'Copilot' },
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    config = function()
      vim.cmd [[
        let g:copilot_no_tab_map = v:true
        imap <expr> <C-j> copilot#Accept("\<Tab>")
      ]]
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
  },
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    config = function()
      require('Comment').setup()
    end,
  },
  {
    'folke/trouble.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    keys = {
      {
        '<leader>zz',
        function()
          require('trouble').toggle()
        end,
        'n',
      },
    },
  },
  {
    'stevearc/conform.nvim',
    keys = {
      {
        '<leader>ff',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        { 'n', 'v' },
      },
    },
    opt = {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        javascript = { { 'prettierd' } },
        typescript = { { 'prettierd' } },
        typescriptreact = { { 'prettierd' } },
        javascriptreact = { { 'prettierd' } },
        html = { { 'prettierd' } },
        css = { { 'prettierd' } },
        json = { { 'prettierd' } },
        yaml = { { 'prettierd' } },
        ruby = { 'rubocop' },
        go = { 'gofmt' },
      },
      format_on_save = function(_) end,
      format_after_save = function(_) end,
    },
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufWritePost' },
    opts = {
      linters_by_ft = {
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        html = { 'eslint_d' },
        ruby = { 'rubocop' },
        go = { 'golangcilint' },
        python = { 'pylint' },
        lua = { 'luacheck' },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
        group = vim.api.nvim_create_augroup('lint', { clear = true }),
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
  {
    'tpope/vim-projectionist',
    event = 'VeryLazy',
    config = function()
      vim.g.projectionist_heuristics = {
        ['*.go'] = {
          ['*.go'] = {
            alternate = '{}_test.go',
            type = 'source',
          },
          ['*_test.go'] = {
            alternate = '{}.go',
            type = 'test',
          },
        },
        ['*.rb'] = {
          ['app/*.rb'] = {
            alternate = 'spec/{}_spec.rb',
            type = 'source',
          },
          ['spec/*_spec.rb'] = {
            alternate = 'app/{}.rb',
            type = 'test',
          },
        },
        ['*'] = {
          ['app/*.tsx'] = {
            alternate = { 'app/{}.test.tsx', 'spec/{}.test.tsx' },
          },
          ['app/*.test.tsx'] = {
            alternate = 'app/{}.tsx',
          },
          ['spec/*.test.tsx'] = {
            alternate = 'app/{}.tsx',
          },
          ['app/*.jsx'] = {
            alternate = { 'app/{}.test.jsx', 'spec/{}.test.jsx' },
          },
          ['app/*.test.jsx'] = {
            alternate = 'app/{}.jsx',
          },
          ['spec/*.test.jsx'] = {
            alternate = 'app/{}.jsx',
          },
        },
      }
    end,
    keys = {
      {
        '`]',
        ':A<CR>',
        silent = true,
      },
    },
  },
}
