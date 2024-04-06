return {
  { 'kyazdani42/nvim-web-devicons' },
  { 'j-hui/fidget.nvim' },
  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup {
        icons = {
          ERROR = '',
          WARN = '',
          INFO = '',
          DEBUG = '',
          TRACE = '✎',
        },
      }
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('noice').setup {
        lsp = {
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = true,
          lsp_doc_border = true,
        },
      }
    end,
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
    event = 'VeryLazy',
  },
}
