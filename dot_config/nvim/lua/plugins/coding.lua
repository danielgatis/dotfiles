return {
  {
    'github/copilot.vim',
    cmd = { 'Copilot' },
    lazy = false,
    config = function()
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
          expr = true,
          replace_keycodes = false
      })

      vim.g.copilot_no_tab_map = true
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = { 'InsertEnter' },
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
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
    'tpope/vim-projectionist',
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
    event = { 'VeryLazy' },
    keys = {
      {
        '<leader>a',
        ':A<CR>',
        silent = true,
      },
    },
  },
}
