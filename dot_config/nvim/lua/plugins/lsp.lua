return {
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
    event = 'VeryLazy',
    opts = {
      servers = {
        solargraph = {},
        gopls = {},
        ts_ls = {},
        pyright = {},
        lua_ls = {},
      },
    },
    config = function(_, opts)
      require('mason').setup()
      require('mason-lspconfig').setup {
        automatic_installation = true,
        ensure_installed = {
          'solargraph',
          'gopls',
          'ts_ls',
          'pyright',
          'lua_ls',
          'eslint',
          'rubocop',
          'golangci_lint_ls',
        },
      }

      local lspconfig = require 'lspconfig'
      for server, config in pairs(opts.servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set('n', '<leader>qq', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

          vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
          vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
          vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
        end,
      })
    end,
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
        javascript = { { 'eslint' } },
        typescript = { { 'eslint' } },
        typescriptreact = { { 'eslint' } },
        javascriptreact = { { 'eslint' } },
        html = { { 'eslint' } },
        css = { { 'eslint' } },
        json = { { 'eslint' } },
        yaml = { { 'eslint' } },
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
        javascript = { 'eslint' },
        typescript = { 'eslint' },
        typescriptreact = { 'eslint' },
        javascriptreact = { 'eslint' },
        html = { 'eslint' },
        ruby = { 'rubocop' },
        go = { 'golangcilint' },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
}
