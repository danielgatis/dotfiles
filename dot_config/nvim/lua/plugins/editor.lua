return {
  {
    'folke/flash.nvim',
    opts = {
      search = {
        forward = true,
        multi_window = false,
        wrap = false,
        incremental = true,
      },
    },
  },
  {
    'ibhagwan/fzf-lua',
    keys = {
      {
        '<c-p>',
        function()
          require('fzf-lua').files()
        end,
        'n',
      },
      {
        '<c-s-p>',
        function()
          require('fzf-lua').live_grep()
        end,
        'n',
      },
      {
        '<c-m-p>',
        function()
          require('fzf-lua').git_status()
        end,
        'n',
      },
    },
    opts = {
      winopts = { preview = { hidden = 'hidden' } },
      file_ignore_patterns = { 'node_modules/.*', 'vendor/.*', 'tmp/.*', '.git/.*' },
    },
  },
  {
    'ibhagwan/smartyank.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = { highlight = { timeout = 200 } },
  },
  {
    'nvim-tree/nvim-tree.lua',
    keys = {
      { '<leader>e', '<cmd>:NvimTreeFindFileToggle<cr>' },
    },
    config = function()
      require('nvim-tree').setup {}
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    config = function()
      require('gitsigns').setup {
        current_line_blame = true,
      }
    end,
  },
  {
    'mg979/vim-visual-multi',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
  },
  {
    'kevinhwang91/nvim-bqf',
    event = 'VeryLazy',
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      { '<m-z>', ':bd<cr>', 'n' },
      { '<m-tab>', '<cmd>BufferLineCycleNext<cr>', 'n' },
      { '<m-s-tab>', '<cmd>BufferLineCyclePrev<cr>', 'n' },
    },
    config = function()
      require('bufferline').setup {
        options = {
          offsets = {
            {
              filetype = 'NvimTree',
            },
          },
        },
      }
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
      options = { theme = 'catppuccin-mocha' },
    },
  },
  {
    'sunaku/tmux-navigate',
    event = 'VeryLazy',
  },
  {
    'tamton-aquib/duck.nvim',
    keys = {
      {
        '<leader>dd',
        function()
          require('duck').hatch()
        end,
        'n',
      },
      {
        '<leader>dk',
        function()
          require('duck').cook()
        end,
        'n',
      },
    },
  },
  {
    'tpope/vim-repeat',
    event = { 'VeryLazy' },
  },
  {
    'wellle/targets.vim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
  },
  {
    'ruifm/gitlinker.nvim',
    keys = {
      {
        '<leader>gb',
        function()
          require('gitlinker').get_buf_range_url('n', { action_callback = require('gitlinker.actions').open_in_browser })
        end,
        { 'n', 'v' },
      },
    },
  },
}
