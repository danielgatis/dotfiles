return {
  {
    'ibhagwan/fzf-lua',
    keys = {
      {
        '`p',
        function()
          require('fzf-lua').files()
        end,
        'n',
      },
      {
        '``p',
        function()
          require('fzf-lua').live_grep()
        end,
        'n',
      },
      {
        '```p',
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
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },
  {
    'stevearc/oil.nvim',
    keys = {
      {
        '`\\',
        function()
          require('oil').toggle_float()
        end,
        'n',
      },
    },
    config = function()
      require('oil').setup {
        delete_to_trash = true,
        keymaps = {
          ['g?'] = 'actions.show_help',
          ['<CR>'] = 'actions.select',
          ['<C-s>'] = 'actions.select_vsplit',
          ['<C-h>'] = 'actions.select_split',
          ['<C-t>'] = 'actions.select_tab',
          ['<C-p>'] = 'actions.preview',
          ['<C-c>'] = 'actions.close',
          ['<C-l>'] = 'actions.refresh',
          ['-'] = 'actions.parent',
          ['_'] = 'actions.open_cwd',
          ['`'] = 'actions.cd',
          ['~'] = 'actions.tcd',
          ['gs'] = 'actions.change_sort',
          ['gx'] = 'actions.open_external',
          ['g.'] = 'actions.toggle_hidden',
          ['g\\'] = 'actions.toggle_trash',
          ['q'] = 'actions.close',
          ['<esc>'] = 'actions.close',
        },
      }
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
    'famiu/bufdelete.nvim',
    keys = {
      {
        '<m-x>',
        function()
          require('bufdelete').bufdelete(0, true)
        end,
        'n',
      },
    },
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
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
