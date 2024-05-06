return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'VeryLazy',
    dependencies = {
      { 'RRethy/nvim-treesitter-endwise' },
      { 'nvim-treesitter/nvim-treesitter' },
      { 'windwp/nvim-ts-autotag' },
      {
        'kiyoon/treesitter-indent-object.nvim',
        keys = {
          {
            'ai',
            function()
              require('treesitter_indent_object.textobj').select_indent_outer()
            end,
            mode = { 'x', 'o' },
          },
          {
            'aI',
            function()
              require('treesitter_indent_object.textobj').select_indent_outer(true)
            end,
            mode = { 'x', 'o' },
          },
          {
            'ii',
            function()
              require('treesitter_indent_object.textobj').select_indent_inner()
            end,
            mode = { 'x', 'o' },
          },
          {
            'iI',
            function()
              require('treesitter_indent_object.textobj').select_indent_inner(true, 'V')
            end,
            mode = { 'x', 'o' },
          },
        },
      },
    },
    config = function()
      local configs = require 'nvim-treesitter.configs'
      configs.setup {
        endwise = { enable = true },
        highlight = { enable = true },
        autotag = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = { query = '@class.inner' },
              ['as'] = { query = '@scope', query_group = 'locals' },
            },
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = true,
          },
        },
        ensure_installed = {
          'javascript',
          'typescript',
          'tsx',
          'lua',
          'css',
          'json',
          'ruby',
          'python',
          'go',
        },
      }
    end,
  },
}
