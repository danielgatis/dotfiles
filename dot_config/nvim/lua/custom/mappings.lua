---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "Enter command mode", opts = { nowait = true } },
    ["<M-Right>"] = { function() require('Navigator').right() end, "Navigate tmux right", opts = { nowait = true } },
    ["<M-Left>"] = { function() require('Navigator').left() end, "Navigate tmux left", opts = { nowait = true } },
    ["<M-Up>"] = { function() require('Navigator').up() end, "Navigate tmux up", opts = { nowait = true } },
    ["<M-Down>"] = { function() require('Navigator').down() end, "Navigate tmux down", opts = { nowait = true } },
  },
  t = {
    ["<M-Right>"] = { function() require('Navigator').right() end, "Navigate tmux right", opts = { nowait = true } },
    ["<M-Left>"] = { function() require('Navigator').left() end, "Navigate tmux left", opts = { nowait = true } },
    ["<M-Up>"] = { function() require('Navigator').up() end, "Navigate tmux up", opts = { nowait = true } },
    ["<M-Down>"] = { function() require('Navigator').down() end, "Navigate tmux down", opts = { nowait = true } },
  }
}

return M
