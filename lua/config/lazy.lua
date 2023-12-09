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
    "NoiceMini",
    "NoicePopupmenu",
    "NoiceScrollbar",
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

ls.add_snippets("cpp", {
  s("cf", {
    t("// clang-format off"),
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
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    -- progress = { enabled = false, },
    -- signature = { enabled = false, },
    -- message = { enabled = false, },
    -- documentation = { enabled = false, },
    -- hover = { enabled = false, },
    -- smart_move = { enabled = false, },
  },
  popupmenu = {
    enabled = true,  -- enables the Noice popupmenu UI
    ---@type 'nui'|'cmp'
    backend = "nui", -- backend to use to show regular cmdline completions
    ---@type NoicePopupmenuItemKind|false
    -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
    kind_icons = {}, -- set to `false` to disable icons
  },
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

local actions = require("fzf-lua.actions")
require("fzf-lua").setup({
  grep = {
    prompt         = 'Rg❯ ',
    input_prompt   = 'Grep 4❯ ',
    multiprocess   = true, -- run command in a separate process
    git_icons      = true, -- show git icons?
    file_icons     = true, -- show file icons?
    color_icons    = true, -- colorize file|git icons
    -- executed command priority is 'cmd' (if exists)
    -- otherwise auto-detect prioritizes `rg` over `grep`
    -- default options are controlled by 'rg|grep_opts'
    -- cmd            = "rg --vimgrep",
    grep_opts      = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e",
    rg_opts        = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
    -- set to 'true' to always parse globs in both 'grep' and 'live_grep'
    -- search strings will be split using the 'glob_separator' and translated
    -- to '--iglob=' arguments, requires 'rg'
    -- can still be used when 'false' by calling 'live_grep_glob' directly
    rg_glob        = false,     -- default to glob parsing?
    glob_flag      = "--iglob", -- for case sensitive globs use '--glob'
    glob_separator = "%s%-%-",  -- query separator pattern (lua): ' --'
    -- advanced usage: for custom argument parsing define
    -- 'rg_glob_fn' to return a pair:
    --   first returned argument is the new search query
    --   second returned argument are addtional rg flags
    -- rg_glob_fn = function(query, opts)
    --   ...
    --   return new_query, flags
    -- end,
    actions        = {
      -- actions inherit from 'actions.files' and merge
      -- this action toggles between 'grep' and 'live_grep'
      ["ctrl-g"] = { actions.grep_lgrep }
    },
    no_header      = false, -- hide grep|cwd header?
    no_header_i    = false, -- hide interactive header?
  },

})
