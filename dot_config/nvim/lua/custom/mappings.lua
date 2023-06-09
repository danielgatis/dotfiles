---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<M-l>"] = { function() require('Navigator').right() end, "Navigate tmux right", opts = { nowait = true } },
    ["<M-h>"] = { function() require('Navigator').left() end, "Navigate tmux left", opts = { nowait = true } },
    ["<M-k>"] = { function() require('Navigator').up() end, "Navigate tmux up", opts = { nowait = true } },
    ["<M-j>"] = { function() require('Navigator').down() end, "Navigate tmux down", opts = { nowait = true } },
  },
  t = {
    ["<M-l>"] = { function() require('Navigator').right() end, "Navigate tmux right", opts = { nowait = true } },
    ["<M-h>"] = { function() require('Navigator').left() end, "Navigate tmux left", opts = { nowait = true } },
    ["<M-k>"] = { function() require('Navigator').up() end, "Navigate tmux up", opts = { nowait = true } },
    ["<M-j>"] = { function() require('Navigator').down() end, "Navigate tmux down", opts = { nowait = true } },
  },
}

-- more keybinds!

return M
