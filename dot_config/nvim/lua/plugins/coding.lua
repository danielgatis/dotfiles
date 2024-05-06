return {
  {
    'monaqa/dial.nvim',
    keys = {
      {
        '<C-a>',
        function()
          return require('dial.map').inc_normal()
        end,
        expr = true,
      },
      {
        '<C-x>',
        function()
          return require('dial.map').dec_normal()
        end,
        expr = true,
      },
    },
    config = function()
      local augend = require 'dial.augend'
      require('dial.config').augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias['%Y/%m/%d'],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new { elements = { 'let', 'const' } },
          augend.constant.new { elements = { 'True', 'False' } },
        },
      }
    end,
  },
  {
    'github/copilot.vim',
    cmd = { 'Copilot' },
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    config = function()
      vim.cmd [[
        let g:copilot_no_tab_map = v:true
        imap <expr> <C-j> copilot#Accept("\<Tab>")
      ]]
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
  },
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    config = function()
      require('Comment').setup()
    end,
  },
  {
    'rgroli/other.nvim',
    keys = { { '<leader>tt', '<cmd>:Other<cr>' } },
    opt = {
      mappings = {
        { pattern = '(.*).ts$', target = '%1.test.ts' },
        { pattern = '(.*).test.ts$', target = '%1.ts' },
        { pattern = '(.*).tsx$', target = '%1.test.tsx' },
        { pattern = '(.*).test.tsx$', target = '%1.tsx' },
        { pattern = '(.*).js$', target = '%1.test.js' },
        { pattern = '(.*).test.js$', target = '%1.js' },
        { pattern = '(.*).jsx$', target = '%1.test.jsx' },
        { pattern = '(.*).test.jsx$', target = '%1.jsx' },
        { pattern = '(.*).go$', target = '%1_test.go' },
        { pattern = '(.*)_test.go$', target = '%1.go' },
        { pattern = 'app/(.*).rb$', target = 'spec/%1_spec.rb' },
        { pattern = 'spec/(.*)_spec.rb$', target = 'app/%1.rb' },
      },
      hooks = {
        onFindOtherFiles = function(matches)
          local filtered_matches = {}
          for _, match in ipairs(matches) do
            if not string.match(match.filename, '.test.test.') then
              table.insert(filtered_matches, match)
            end
          end
          return filtered_matches
        end,
      },
    },
  },
  {
    'folke/trouble.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    keys = {
      {
        '<leader>zz',
        function()
          require('trouble').toggle()
        end,
        'n',
      },
    },
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
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        javascript = { { 'prettierd' } },
        typescript = { { 'prettierd' } },
        typescriptreact = { { 'prettierd' } },
        javascriptreact = { { 'prettierd' } },
        html = { { 'prettierd' } },
        css = { { 'prettierd' } },
        json = { { 'prettierd' } },
        yaml = { { 'prettierd' } },
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
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        html = { 'eslint_d' },
        ruby = { 'rubocop' },
        go = { 'golangcilint' },
        python = { 'pylint' },
        lua = { 'luacheck' },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
        group = vim.api.nvim_create_augroup('lint', { clear = true }),
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
}
