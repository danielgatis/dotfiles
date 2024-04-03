return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'RRethy/nvim-treesitter-endwise' },
    opts = {
      endwise = { enable = true },
      highlight = { enable = true },
      ensure_installed = {
        'javascript',
        'typescript',
        'tsx',
        'jsx',
        'lua',
        'css',
        'json',
        'ruby',
        'python',
        'go',
      },
    },
  },
}
