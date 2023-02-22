local ok, cursorline = pcall(require, "nvim-cursorline")
if not ok then return end

cursorline.setup({
  cursorline = {
    enable = true,
    timeout = 400,
    number = true,
  },
  cursorword = {
    enable = true,
    min_length = 100,
    hl = { underline = true },
  },
})
