vim.opt.exrc = true
vim.opt.termguicolors = true
vim.opt.textwidth = 120
vim.opt.colorcolumn = { 0 }
vim.opt.laststatus = 3
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.title = true
vim.opt.hidden = false
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.clipboard = ""
vim.opt.cmdheight = 1
vim.opt.autowrite = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.wildignore = { "*/cache/*", "*/tmp/*" }
vim.opt.errorformat = "%f|%l col %c|%m"
vim.opt.foldcolumn = "auto"
vim.opt.foldmethod = "marker"
vim.opt.ignorecase = false
vim.opt.smartcase = true
vim.opt.mouse = "a"
vim.opt.undolevels = 10000
vim.opt.number = true
vim.opt.numberwidth = 1
vim.opt.relativenumber = false
vim.opt.fileencoding = "utf-8"
vim.opt.tabstop = 4
vim.opt.timeoutlen = 250
vim.opt.undofile = true
vim.opt.updatetime = 500
vim.opt.wrap = false
vim.opt.spell = false
vim.opt.spelllang = "en_us,en_gb,cjk"
vim.opt.spellsuggest = "best,9"
vim.opt.spelloptions = { "camel", "noplainbuffer" }
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/words.add"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.backup = false
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.showtabline = 2
vim.opt.hlsearch = true
vim.opt.conceallevel = 2
vim.opt.swapfile = false
vim.opt.cursorline = false
vim.opt.cursorlineopt = "both"
vim.opt.pumheight = 25
vim.opt.pumwidth = 35
vim.opt.pumblend = 0
vim.opt.winblend = 0
vim.opt.history = 10000
vim.opt.emoji = true
vim.opt.ruler = true
vim.opt.list = true
vim.opt.menuitems = 30
vim.opt.magic = true
vim.opt.icon = true
vim.opt.omnifunc = "syntaxcomplete#Complete"
vim.opt.background = "dark"
vim.opt.fillchars = {
  eob = " ",
  stlnc = " ",
  diff = "░",
  msgsep = "━",
  foldopen = "",
  foldsep = "│",
  foldclose = "",
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
  fold = "─",
}

vim.opt.iskeyword = "@,48-57,_,192-255"
vim.opt.whichwrap:append("<>[]hl")
vim.opt.shortmess:append("sI")
vim.opt.diffopt:append("algorithm:patience")
vim.opt.formatoptions:remove({ "c", "r", "o" })
