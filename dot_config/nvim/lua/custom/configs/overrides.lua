local M = {}

M.copilot = {
  suggestion = {
    auto_trigger = true,
  },
}

M.treesitter = {
  ensure_installed = {
    "c",
    "css",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown_inline",
    "markdown",
    "python",
    "ruby",
    "rust",
    "scss",
    "svelte",
    "tsx",
    "typescript",
    "vim",
    "vue",
  },
  indent = {
    enable = true,
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
