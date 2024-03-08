_G.GROUP = vim.api.nvim_create_augroup("DharmxGroup", {})
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "MoreMsg",
      on_visual = true
    })
  end,
  group = GROUP,
})

autocmd({ "TermOpen", "BufReadCmd" }, {
  command = "set nonu nornu",
  pattern = { "term://*", "zsh", "*/zsh", "sh", "bash", "toggleterm" },
  group = GROUP,
})

autocmd("BufWritePre", {
  callback = function()
    local directory = vim.fn.expand("<afile>:p:h")
    if directory:find("%l+://") == 1 then return end
    if vim.fn.isdirectory(directory) == 0 then vim.fn.mkdir(directory, "p") end
  end,
  group = GROUP,
})

autocmd({ "FileType", "BufWinEnter" }, {
  pattern = "*.md",
  command = "silent! loadview",
  group = GROUP,
})

autocmd({ "FileType", "BufWinLeave" }, {
  pattern = "*.md",
  command = "mkview",
  group = GROUP,
})

autocmd("FileType", {
  pattern = { "checkhealth", "help", "notify", "oil", "qf", "query", "man://*" },
  command = "nmap <buffer> q :q<CR>",
  group = GROUP,
})

autocmd("FileType", {
  pattern = "notify",
  command = "set ft=markdown",
  group = GROUP,
})

autocmd("FileType", {
  pattern = "alpha",
  command = "nmap <buffer> q :Alpha<CR>",
  group = GROUP,
})

autocmd("FileType", {
  pattern = "tsplayground",
  command = "nmap <buffer> q :TSPlaygroundToggle<CR>",
  group = GROUP,
})

autocmd("FileType", {
  pattern = "qf",
  command = "setlocal number!",
  group = GROUP,
})

autocmd("InsertLeave", {
  callback = function() vim.diagnostic.enable(0) end,
  group = GROUP,
})

autocmd("InsertEnter", {
  callback = function() vim.diagnostic.disable(0) end,
  group = GROUP,
})

command("PickColors", function()
  local Task = require("plenary.job")
    Task:new({
      "xcolor",
      on_exit = vim.schedule_wrap(function(self, code, _)
        if code ~= 0 then
          vim.notify("Could not run xcolor.")
          return
        end
        local result = self:result()
        vim.notify("Copied " .. result[1]:upper() .. " into +.")
        vim.fn.setreg("+", result)
      end),
    }):start()
end, { nargs = 0 })

command("Paste", function(args)
  require("scratch.paste").paste(args)
end, { range = true })

local M = {}

local U = vim.loop
local V = vim.fn
local A = vim.api

local wrap = vim.schedule_wrap
local cmd = A.nvim_create_user_command

local function create_ranges(file, starting, ending)
  local tokens = {}
  table.insert(tokens, file)
  if starting and ending then
    table.insert(tokens, string.format(":%s-%s", starting, ending))
  elseif starting and not ending then
    table.insert(tokens, string.format(":%s", starting))
  elseif not starting and ending then
    table.insert(tokens, string.format(":%s", ending))
  end
  return table.concat(tokens)
end

local function print_errors(errors)
  local store = {}
  table.insert(store, "# An ERROR occured.\n")
  for _, line in ipairs(errors) do table.insert(store, "- " .. line) end
  A.nvim_notify(table.concat(store, "\n"), vim.log.levels.ERROR, {
    icon = " ",
    title = "permalink.lua",
  })
end

function M.fetch_permalink(file, starting, ending, options)
  local Task = require("plenary.job")
  options = vim.F.if_nil(options, {})
  options.open_brower = vim.F.if_nil(options.open_brower, false)
  options.browser = vim.F.if_nil(options.browser, vim.env.BROWSER)

  if options.open_brower then assert(options.browser) end
  if not U.fs_realpath(file) then
    print_errors({ file .. " does not exist!" })
    return
  end

  Task:new({
    command = "gh",
    args = {
      "browse",
      "--no-browser",
      create_ranges(file, starting, ending),
    },
    on_start = wrap(function()
      A.nvim_notify("Fetching permalink. Please wait... ", vim.log.levels.INFO, {
        icon = " ",
        title = "permalink.lua",
      })
    end),
    on_exit = wrap(function(self, code, _)
      local result = self:result()
      if code ~= 0 then
        print_errors(result)
        return
      end

      V.setreg("+", result[1])
      A.nvim_notify("Copied fetched link into the +register.", vim.log.levels.INFO, {
        icon = " ",
        title = "permalink.lua",
      })
      if options.open_browser then
        Task:new({
          command = options.browser,
          args = { result[1] },
          detached = true,
          on_start = wrap(function()
            A.nvim_notify("Opened fetched link in " .. options.browser .. ".", vim.log.levels.INFO, {
              icon = " ",
              title = "permalink.lua",
            })
          end),
        }):start()
      end
    end),
  }):start()
end

command("GHBrowse", function(args)
  local starting
  local ending
  local file = vim.F.if_nil(args.fargs[1], vim.fn.expand("%"))
  if args.range ~= 0 then
    starting = args.line1
    ending = args.line2
  end
  require("scratch.github").fetch_permalink(file, starting, ending, { open_browser = true })
end, {
  range = true,
  desc = "Browse GH.",
  complete = "file",
  nargs = "?",
})

command("Overview", function()
  require("scratch.overview").toggle()
end, {
  desc = "Open keymap overview.",
  nargs = 0,
})
