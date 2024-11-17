return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'danielfalk/smart-open.nvim',
        branch = '0.2.x',
        dependencies = {
          'kkharji/sqlite.lua',
        },
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      },
    },
    keys = {
      { '<C-p>', function() require('telescope').extensions.smart_open.smart_open() end },
      { '<C-M-p>', function() require('telescope.builtin').git_status() end },
      { '<C-s>', function() require('telescope.builtin').live_grep() end },
    },
    config = function()
      local telescope = require('telescope')

      telescope.setup {
        extensions = {
          smart_open = {
            match_algorithm = 'fzf',
          },
        },
      }

      telescope.load_extension('smart_open')
      telescope.load_extension('fzf')
    end,
  },
}
