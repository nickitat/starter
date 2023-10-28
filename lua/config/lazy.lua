local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
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
require("lualine").setup({
  options = {
    theme = lualine_material_theme,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
})

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
    "FloatShadow",
    "FloatShadowThrough",
    --"Folded",
    "NormalContrast",
    "NvimTreeNormal", -- NvimTree
    "TreesitterContext",
    "TreesitterContextLineNumber",
    -- "NoiceMini",
    -- "MsgArea",
    --"Visual",
    --"VisualNOS"
  },
  exclude_groups = {},
})
require("transparent").clear_prefix("lualine")
require("neoscroll").setup({})

require("yanky").setup({})
-- Lua snippet for LOG_DEBUG
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function fn(args, _, _)
  local function split(source, delimiters)
    local elements = {}
    local pattern = "([^" .. delimiters .. "]+)"
    _ = string.gsub(source, pattern, function(value)
      elements[#elements + 1] = value
    end)
    for key, elem in pairs(elements) do
      if string.sub(elem, -1, -1) == "," then
        elements[key] = string.sub(elem, 1, -2)
      end
    end
    return elements
  end

  local arg = split(args[1][1], " ")
  return '"' .. table.concat(arg, "={}, ") .. '={}"'
end

ls.add_snippets("cpp", {
  s("logd", {
    t("LOG_DEBUG("),
    i(1, '&Poco::Logger::get("debug")'),
    t(", "),
    f(fn, { 2 }, {}),
    t(", "),
    i(2),
    t(");"),
  }),
})

local bufferline = require("bufferline")
bufferline.setup({
  options = {
    style_preset = bufferline.style_preset.default,
    always_show_bufferline = true,
    indicator = { style = "icon" },
    hover = {
      enabled = true,
      delay = 200,
      reveal = { "close" },
    },
    groups = {
      items = {
        require("bufferline.groups").builtin.pinned:with({ icon = "📍" }),
      },
    },
    separator_style = "thick",
    diagnostics = "nvim_lsp",
    buffer_close_icon = "󰅖",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
  },
})

require("lspconfig").pylsp.setup({
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false },
        mccabe = { enabled = false },
      },
      timeout = 5,
    },
  },
})

require("noice").setup({
  -- lsp = {
  --   -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --   override = {
  --     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --     ["vim.lsp.util.stylize_markdown"] = true,
  --     ["cmp.entry.get_documentation"] = true,
  --   },
  -- },
  -- -- you can enable a preset for easier configuration
  -- presets = {
  --   bottom_search = true,         -- use a classic bottom cmdline for search
  --   command_palette = true,       -- position the cmdline and popupmenu together
  --   long_message_to_split = true, -- long messages will be sent to a split
  --   inc_rename = false,           -- enables an input dialog for inc-rename.nvim
  --   lsp_doc_border = false,       -- add a border to hover docs and signature help
  -- },
  views = {
    mini = {
      win_options = {
        winblend = 0,
      },
    },
  },
})

require("symbols-outline").setup({
  auto_close = true,
  show_numbers = true,
  keymaps = { goto_location = {} },
})

-- Somehow fixes wrong goto_location
vim.api.nvim_create_autocmd("FileType", {
  pattern = "Outline",
  callback = function()
    vim.keymap.set("n", "<CR>", function()
      local outline = require("symbols-outline")
      local node = outline._current_node()

      vim.api.nvim_win_set_cursor(outline.state.code_win, { node.line + 1, node.character })

      vim.schedule(function()
        --vim.fn.win_gotoid(outline.state.code_win)

        if require("symbols-outline.config").options.auto_close then
          outline.close_outline()
        end
      end)
    end, { buffer = true })
  end,
})
