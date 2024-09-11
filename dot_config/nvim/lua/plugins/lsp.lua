return {
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    config = function()
      local servers = {
        'solargraph',
        'gopls',
        'ts_ls',
        'pyright',
        'lua_ls',
      }

      local linters = {
        'eslint',
        'rubocop',
        'golangci_lint_ls',
      }

      merged = {}

      -- Function to merge two tables
      function mergeTables(destination, source)
          for _, value in ipairs(source) do
              table.insert(destination, value)
          end
      end

      -- Merge the tables
      mergeTables(merged, servers)
      mergeTables(merged, linters)

      require('mason').setup()
      require('mason-lspconfig').setup {
        automatic_installation = true,
        ensure_installed = merged,
      }

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

      local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
      for _, server in ipairs(servers) do
        require('lspconfig')[server].setup {
          capabilities = lsp_capabilities,
        }
      end

      local lspconfig = require 'lspconfig'
      lspconfig.solargraph.setup {}
      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      }
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
          require("lint").try_lint()
        end,
      })
    end,
  },
}
