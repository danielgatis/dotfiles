return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        integrations = {
          fidget = true,
          treesitter = true,
          nvimtree = true,
          mason = true,
          cmp = true,
          gitsigns = true,
          flash = true,
        },
      }

      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
}
