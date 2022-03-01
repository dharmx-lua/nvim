local T = {}

function T.get(theme)
  return {
    ["TelescopePreviewBorder"] = {
      foreground = theme.shades.shade07,
      background = theme.shades.shade07,
    },
    ["TelescopePreviewTitle"] = {
      foreground = theme.common.base01,
      background = theme.common.base09,
    },
    ["TelescopePreviewNormal"] = {
      background = theme.shades.shade07,
    },
    ["TelescopeSelectionCaret"] = {
      foreground = theme.common.base09,
      background = theme.common.base01,
    },
    ["TelescopeSelection"] = {
      background = theme.common.base01,
    },
    ["TelescopeResultsBorder"] = {
      background = theme.shades.shade09,
      foreground = theme.shades.shade09,
    },
    ["TelescopeResultsTitle"] = {
      background = theme.shades.shade09,
      foreground = theme.shades.shade09,
    },
    ["TelescopeResultsNormal"] = {
      background = theme.shades.shade09,
      foreground = theme.common.base04,
    },
    ["TelescopeMatching"] = {
      foreground = theme.common.base09,
    },
    ["TelescopePromptPrefix"] = {
      foreground = theme.common.base01,
      background = theme.common.base09,
    },
    ["TelescopePromptBorder"] = {
      background = theme.common.base09,
      foreground = theme.common.base09,
    },
    ["TelescopePromptNormal"] = {
      background = theme.common.base09,
      foreground = theme.common.base01,
    },
    ["TelescopePromptTitle"] = {
      foreground = theme.common.base01,
      background = theme.common.base07,
    },
    ["TelescopePromptCounter"] = {
      foreground = theme.common.base02,
    },
  }
end

return T
