local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "numToStr/Navigator.nvim",
    config = function()
      require("Navigator").setup()
    end
  },

  {
    "NvChad/nvterm",
    enabled = false
  },
}

return plugins
