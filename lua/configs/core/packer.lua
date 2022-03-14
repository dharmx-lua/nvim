local packer_util = require "packer.util"

local config = {
  ensure_dependencies = true,
  compile_path = compile_path,
  auto_clean = true,
  compile_on_sync = true,
  max_jobs = 30,
  disable_commands = false,
  depth = 1,
  clone_timeout = 60,
  default_url_format = "https://github.com/%s.git",
  auto_reload_compiled = true,
  luarocks = { python_cmd = "python" },
  log = { level = "warn" },
  profile = { enable = true, threshold = 1 },
}

config.display = {
  non_interactive = false,
  open_cmd = "65vnew \\[packer\\]",
  item_sym = "",
  header_lines = 2,
  title = " packer.nvim",
  working_sym = " ",
  error_sym = "",
  done_sym = "",
  removed_sym = "",
  moved_sym = " ",
  show_all_info = false,
  prompt_border = "single",
  keybindings = require("mappings").packer_nvim,
  open_fn = function()
    return packer_util.float {
      border = "single",
    }
  end,
}

return config

-- vim:ft=lua