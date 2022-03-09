local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp = capabilities.textDocument.completion.completionItem

for item, config in
  pairs {
    ["snippetSupport"] = true,
    ["preselectSupport"] = true,
    ["insertReplaceSupport"] = true,
    ["labelDetailsSupport"] = true,
    ["deprecatedSupport"] = true,
    ["commitCharactersSupport"] = true,
    ["tagSupport"] = { valueSet = { 1 } },
    ["resolveSupport"] = { properties = { "documentation", "detail", "additionalTextEdits" } },
    ["documentationFormat"] = { "markdown", "plaintext" },
  }
do
  if cmp[item] then
    cmp[item] = config
  end
end

return capabilities

-- lua:ft=lua
