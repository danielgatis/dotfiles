-- stylua: ignore

return {
  { import = "lazyvim.plugins.extras.lang.typescript" },

  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "K", "5k" }
      keys[#keys + 1] = { "<leader>k", vim.lsp.buf.hover }
    end,
  },
}
