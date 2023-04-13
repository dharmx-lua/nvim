local _mason, mason = pcall(require, "mason-lspconfig")
if not _mason then return end

local _lsp, lsp = pcall(require, "lspconfig")
if not _lsp then return end

-- {{{
local _navic, navic = pcall(require, "nvim-navic")
local _cmp, cmp = pcall(require, "cmp_nvim_lsp")
local kind = require("dharmx.util").kind

local autocmd = require("dharmx.plug.config.lsp.presets.autocmd")
local cmd = require("dharmx.plug.config.lsp.presets.cmd")

local function on_attach(client, buffer)
  vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")
  local options = { noremap = true, silent = true, buffer = buffer }
  vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, options)
  vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, options)
  vim.keymap.set("n", "<leader>gk", vim.lsp.buf.hover, options)
  vim.keymap.set("n", "<leader>gb", vim.lsp.buf.implementation, options)
  vim.keymap.set("n", "<leader>gK", vim.lsp.buf.signature_help, options)
  vim.keymap.set("n", "<leader>ga", vim.lsp.buf.add_workspace_folder, options)
  vim.keymap.set("n", "<leader>gi", vim.diagnostic.goto_next, options)
  vim.keymap.set("n", "<leader>gi", vim.diagnostic.goto_prev, options)
  vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, options)
  vim.keymap.set("n", "<leader>rn", require("dharmx.plug.config.lsp.handlers.rename").lsp_rename, options)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, options)
  vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, options)
  vim.keymap.set("n", "<leader>f", vim.cmd.Format, options)
  vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, options)
  vim.keymap.set("n", "<leader>ge", vim.diagnostic.open_float, options)
  vim.keymap.set("n", "<leader>gl", vim.diagnostic.setloclist, options)

  autocmd.setup(client, buffer)
  cmd.setup(client, buffer)

  vim.lsp.protocol.CompletionItemKind = kind
  if client.config.flags then client.config.flags.allow_incremental_sync = true end
  if _navic and client.server_capabilities.documentSymbolProvider then navic.attach(client, buffer) end
end

local function capabilities(name)
  local capability = vim.lsp.protocol.make_client_capabilities()
  capability.textDocument.completion.completionItem.snippetSupport = true
  capability.textDocument.completion.completionItem.preselectSupport = true
  capability.textDocument.completion.completionItem.insertReplaceSupport = true
  capability.textDocument.completion.completionItem.labelDetailsSupport = true
  capability.textDocument.completion.completionItem.deprecatedSupport = true
  capability.textDocument.completion.completionItem.commitCharactersSupport = true
  capability.textDocument.semanticHighlighting = true
  capability.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
  capability.textDocument.completion.completionItem.resolveSupport =
    { properties = { "documentation", "detail", "additionalTextEdits" } }
  capability.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }

  if name == "clangd" then capability.offsetEncoding = "utf-8" end
  if _cmp then capability = cmp.default_capabilities() end
  return capability
end

local function configure(name)
  local exists, defaults = pcall(require, "dharmx.plug.config.lsp.servers." .. name)
  if not exists then defaults = {} end

  return vim.tbl_deep_extend("keep", {
    autostart = true,
    init_options = { documentFormatting = true },
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
    capabilities = capabilities(name),
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "solid", focusable = true }),
      ["textDocument/definition"] = require("dharmx.plug.config.lsp.handlers.definition").goto_definition("vs"),
      ["textDocument/references"] = vim.lsp.with(vim.lsp.handlers["textDocument/references"], { loclist = true }),
      ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "solid", focusable = true }
      ),
      ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = { prefix = "● ", spacing = 1 },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      }),
    },
  }, defaults)
end

require("dharmx.plug.config.lsp.neoconf")
require("dharmx.plug.config.lsp.neodev")
-- }}}

local ignore = { "rust_analyzer", "jdtls" }
mason.setup_handlers({
  function(name)
    if vim.tbl_contains(ignore, name) then return end
    lsp[name].setup(configure(name))
  end,
  jdtls = function()
    if vim.bo.filetype ~= "java" then return end
    local jdtls = require("dharmx.plug.config.lsp.presets.jdtls")
    jdtls.setup(configure("jdtls"))
    jdtls.load_telescope()
  end,
  rust_analyzer = function()
    if vim.bo.filetype ~= "rust" then return end
    local root_dir = require("lspconfig.util").root_pattern({ "Cargo.toml", "rust-project.json" }) or vim.loop.cwd()
    local _rust_tools, rust_tools = pcall(require, "rust-tools")
    if not _rust_tools then
      lsp.rust_analyzer.setup({ root_dir = root_dir })
      return
    end
    rust_tools.setup({
      server = vim.tbl_deep_extend("keep", { root_dir = root_dir }, configure("rust_analyzer")),
      tools = { hover_actions = { border = "solid" } },
    })
  end,
})
