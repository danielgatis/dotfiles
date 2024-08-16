return {
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
        '<c-s>',
        function()
          require('fzf-lua').live_grep_glob()
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
      {
        '<c-\\>',
        '<cmd>NvimTreeFindFileToggle<cr>',
        'n',
      },
    },
    config = function()
      local HEIGHT_RATIO = 0.8
      local WIDTH_RATIO = 0.8

      local function my_on_attach(bufnr)
        local api = require 'nvim-tree.api'
        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set('n', '<esc>', api.tree.close, { buffer = bufnr, noremap = true, silent = true, nowait = true })
        vim.keymap.set('n', 'q', api.tree.close, { buffer = bufnr, noremap = true, silent = true, nowait = true })
      end

      require('nvim-tree').setup {
        on_attach = my_on_attach,
        view = {
          number = true,
          relativenumber = true,
          adaptive_size = false,
          preserve_window_proportions = true,
          float = {
            enable = true,
            quit_on_focus_loss = true,
            open_win_config = function()
              local screen_w = vim.opt.columns:get()
              local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
              local window_w = screen_w * WIDTH_RATIO
              local window_h = screen_h * HEIGHT_RATIO
              local window_w_int = math.floor(window_w)
              local window_h_int = math.floor(window_h)
              local center_x = (screen_w - window_w) / 2
              local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
              return {
                border = 'rounded',
                relative = 'editor',
                row = center_y,
                col = center_x,
                width = window_w_int,
                height = window_h_int,
              }
            end,
          },
          width = function()
            return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
          end,
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
    'famiu/bufdelete.nvim',
    keys = {
      {
        '<c-q>',
        function()
          require('bufdelete').bufdelete(0, true)
        end,
        'n',
      },
    },
  },
  {
    'sunaku/tmux-navigate',
    event = 'VeryLazy',
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
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      {
        'luukvbaal/statuscol.nvim',
        config = function()
          local builtin = require 'statuscol.builtin'
          require('statuscol').setup {
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
              { text = { '%s' }, click = 'v:lua.ScSa' },
              { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
            },
          }
        end,
      },
    },
    event = 'VeryLazy',
    opts = {
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
    },
    keys = {
      {
        '<cr>',
        'za',
        'n',
      },
      {
        'zR',
        function()
          require('ufo').openAllFolds()
        end,
        'n',
      },
      {
        'zM',
        function()
          require('ufo').closeAllFolds()
        end,
        'n',
      },
    },
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
}
