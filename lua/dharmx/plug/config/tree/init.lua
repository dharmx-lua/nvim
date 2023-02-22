local ok, tree = pcall(require, "nvim-treesitter.configs")
if not ok then return end
vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/parsers")

tree.setup({
  ensure_installed = {
    "lua",
    "regex",
    "scheme",
    "racket",
    "gitignore",
    "gitcommit",
    "gitattributes",
    "sxhkdrc",
    "gitattributes",
    "python",
    "make",
    "json",
    "todotxt",
    "c",
    "help",
    "rust",
    "awk",
    "jq",
    "vim",
    "markdown",
    "markdown_inline",
    "git_rebase",
    "css",
    "ini",
    "rasi",
    "html",
    "scss",
    "toml",
    "http",
    "diff",
    "json",
    "yaml",
    "java",
    "json",
    "bash",
    "query",
  },
  auto_install = true,
  ignore_install = { "comment" },
  parser_install_dir = vim.fn.stdpath("data") .. "/parsers",
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true },
  context_commentstring = { enable = true, enable_autocmd = true },
  incremental_selection = { enable = true },
})
