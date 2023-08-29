local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Material theme for bg & status line
require("material").setup({
  lualine_style = "stealth",
})
vim.cmd("colorscheme material-palenight")

-- Transparent statusline
local lualine_material_theme = require("lualine.themes.material-stealth")
lualine_material_theme.normal.c.bg = "None"
require("lualine").setup({ options = { theme = lualine_material_theme } })

-- To suppress some random notification
require("notify").setup({
  background_colour = "#000000",
})

-- Transparent everything
require("transparent").setup({
  groups = {
    "Comment",
    "Conditional",
    "Constant",
    "CursorLineNr",
    "EndOfBuffer",
    "Function",
    "Identifier",
    "LineNr",
    "NonText",
    "Normal",
    "NormalNC",
    "Operator",
    "PreProc",
    "Repeat",
    "SignColumn",
    "Special",
    "Statement",
    "String",
    "Structure",
    "Todo",
    "Type",
    "Underlined",
  },
  extra_groups = {
    "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
    "FloatBorder",
    "NvimTreeNormal", -- NvimTree
  },
  exclude_groups = {},
})
require("neoscroll").setup({})

require("yanky").setup({})
