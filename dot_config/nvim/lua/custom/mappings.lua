---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "Enter command mode", opts = { nowait = true } },
    ["<M-Right>"] = { function() require('Navigator').right() end, "Navigate tmux right", opts = { nowait = true } },
    ["<M-Left>"] = { function() require('Navigator').left() end, "Navigate tmux left", opts = { nowait = true } },
    ["<M-Up>"] = { function() require('Navigator').up() end, "Navigate tmux up", opts = { nowait = true } },
    ["<M-Down>"] = { function() require('Navigator').down() end, "Navigate tmux down", opts = { nowait = true } },
    ["f"] = { function() require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true }) end, "Hop to char forward", opts = { nowait = true } },
    ["F"] = { function() require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true }) end, "Hop to char forward", opts = { nowait = true } },
    ["t"] = { function() require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }) end, "Hop to char forward", opts = { nowait = true } },
    ["T"] = { function() require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }) end, "Hop to char forward", opts = { nowait = true } },
    ["<leader>s"] = { function() require('spectre').open() end, "Open Spectre", opts = { nowait = true } },
    ["<leader>sw"] = { function() require('spectre').open_visual({select_word=true}) end, "Search current word", opts = { nowait = true } },
    ["<leader>sp"] = { function() require('spectre').open_file_search({select_word=true}) end, "Search on current file", opts = { nowait = true } },
  },
  t = {
    ["<M-Right>"] = { function() require('Navigator').right() end, "Navigate tmux right", opts = { nowait = true } },
    ["<M-Left>"] = { function() require('Navigator').left() end, "Navigate tmux left", opts = { nowait = true } },
    ["<M-Up>"] = { function() require('Navigator').up() end, "Navigate tmux up", opts = { nowait = true } },
    ["<M-Down>"] = { function() require('Navigator').down() end, "Navigate tmux down", opts = { nowait = true } },
  },
  v = {
    ["<leader>sw"] = { function() require('spectre').open_visual() end, "Search current word", opts = { nowait = true } },
  },
}

return M
