local ok, aerial = pcall(require, "aerial")
if not ok then return end
local kind = require("dharmx.util.kind")

aerial.setup({
  ignore = {
    unlisted_buffers = false,
    filetypes = {
      "TelescopeResults",
      "query",
      "tsplayground",
      "lazy",
      "lsp-installer",
      "markdown",
      "mason",
      "txt",
      "dashboard",
      "alpha",
      "NvimTree",
      "undotree",
      "diff",
      "fugitive",
      "fugitiveblame",
      "Outline",
      "SidebarNvim",
      "packer",
      "lsp-installer",
      "TelescopePrompt",
      "help",
      "telescope",
      "lspinfo",
      "Trouble",
      "null-ls-info",
      "quickfix",
      "chadtree",
      "fzf",
      "NeogitStatus",
      "terminal",
      "console",
      "term://*",
      "Term://*",
      "toggleterm",
      "qf",
      "prompt",
      "noice",
      "",
    },
    buftypes = {
      "terminal",
      "nofile",
    },
  },
  icons = kind,
  guides = {
    mid_item = "├─",
    last_item = "└─",
    nested_top = "│ ",
    whitespace = "  ",
  },
  float = {
    border = "solid",
  },
})

-- vim:filetype=lua