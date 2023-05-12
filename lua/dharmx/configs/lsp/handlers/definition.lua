local M = {}

function M.goto_definition(split_cmd)
  local util = vim.lsp.util
  local log = require("vim.lsp.log").info

  return function(_, result, context)
    if result == nil or vim.tbl_isempty(result) then
      _ = log() and log(context.method, "No location found")
      return
    end

    if split_cmd then vim.cmd(split_cmd) end
    if vim.tbl_islist(result) then
      util.jump_to_location(result[1], vim.bo.fileencoding, true)
      if #result > 1 then vim.cmd.wincmd("p") end
    else
      util.jump_to_location(result, "utf8", true)
    end
  end
end

return M