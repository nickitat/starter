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
  sections = {
    lualine_c = {
      {
        'lsp_progress',
        separators = {
          component = ' ',
          progress = ' | ',
          percentage = { pre = '', post = '%% ' },
          title = { pre = '', post = ': ' },
          lsp_client_name = { pre = '[', post = ']' },
          spinner = { pre = '', post = '' },
          message = { commenced = 'In Progress', completed = 'Completed' },
        },
        display_components = { pre = '(', post = ')', 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
        timer = { progress_enddelay = 50, spinner = 100, lsp_client_name_enddelay = 100 },
        spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
      } }
  }
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
    "lualine_a_command",
    "lualine_a_inactive",
    "lualine_a_insert",
    "lualine_a_normal",
    "lualine_a_replace",
    "lualine_a_visual",
    "lualine_b_command",
    "lualine_b_diagnostics_error_command",
    "lualine_b_diagnostics_error_inactive",
    "lualine_b_diagnostics_error_insert",
    "lualine_b_diagnostics_error_normal",
    "lualine_b_diagnostics_error_replace",
    "lualine_b_diagnostics_error_terminal",
    "lualine_b_diagnostics_error_visual",
    "lualine_b_diagnostics_hint_command",
    "lualine_b_diagnostics_hint_inactive",
    "lualine_b_diagnostics_hint_insert",
    "lualine_b_diagnostics_hint_normal",
    "lualine_b_diagnostics_hint_replace",
    "lualine_b_diagnostics_hint_terminal",
    "lualine_b_diagnostics_hint_visual",
    "lualine_b_diagnostics_info_command",
    "lualine_b_diagnostics_info_inactive",
    "lualine_b_diagnostics_info_insert",
    "lualine_b_diagnostics_info_normal",
    "lualine_b_diagnostics_info_replace",
    "lualine_b_diagnostics_info_terminal",
    "lualine_b_diagnostics_info_visual",
    "lualine_b_diagnostics_warn_command",
    "lualine_b_diagnostics_warn_inactive",
    "lualine_b_diagnostics_warn_insert",
    "lualine_b_diagnostics_warn_normal",
    "lualine_b_diagnostics_warn_replace",
    "lualine_b_diagnostics_warn_terminal",
    "lualine_b_diagnostics_warn_visual",
    "lualine_b_diff_added_command",
    "lualine_b_diff_added_inactive",
    "lualine_b_diff_added_insert",
    "lualine_b_diff_added_normal",
    "lualine_b_diff_added_replace",
    "lualine_b_diff_added_terminal",
    "lualine_b_diff_added_visual",
    "lualine_b_diff_modified_command",
    "lualine_b_diff_modified_inactive",
    "lualine_b_diff_modified_insert",
    "lualine_b_diff_modified_normal",
    "lualine_b_diff_modified_replace",
    "lualine_b_diff_modified_terminal",
    "lualine_b_diff_modified_visual",
    "lualine_b_diff_removed_command",
    "lualine_b_diff_removed_inactive",
    "lualine_b_diff_removed_insert",
    "lualine_b_diff_removed_normal",
    "lualine_b_diff_removed_replace",
    "lualine_b_diff_removed_terminal",
    "lualine_b_diff_removed_visual",
    "lualine_b_inactive",
    "lualine_b_insert",
    "lualine_b_normal",
    "lualine_b_replace",
    "lualine_b_visual",
    "lualine_c_inactive",
    "lualine_c_normal",
    "lualine_transitional_lualine_a_normal_to_lualine_b_normal",
    "lualine_transitional_lualine_a_insert_to_lualine_b_insert",
    "lualine_transitional_lualine_a_command_to_lualine_b_command",
    "MsgShow",
    --"Folded",
    --"Visual",
    --"VisualNOS"
  },
  -- exclude_groups = { "OverLength" },
})
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
--
ls.add_snippets("cpp", {
  s("logfl", {
    t("LOG_DEBUG("),
    i(1, '&Poco::Logger::get("debug")'),
    t(", \"__PRETTY_FUNCTION__={}, __LINE__={}\", __PRETTY_FUNCTION__, __LINE__);"),
  }),
})
--
ls.add_snippets("cpp", {
  s("scv", {
    t("static_cast<const void*>("),
    i(1, ''),
    t(")"),
  }),
})
--
ls.add_snippets("cpp", {
  s("mu", {
    t("[[maybe_unused]]"),
  })
})
--
local bufferline = require("bufferline")
bufferline.setup({
  options = {
    style_preset = bufferline.style_preset.default,
    always_show_bufferline = true,
    indicator = { style = "underline" },
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
    separator_style = "thin",
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
    progress = { enabled = false, format = "", format_done = "", },
    -- signature = { enabled = false, },
    message = { enabled = false, },
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
  messages = {
    enabled = false, -- enables the Noice messages UI
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
require("clangd_extensions").setup({
  inlay_hints = {
    inline = vim.fn.has("nvim-0.10") == 1,
    -- Options other than `highlight' and `priority' only work
    -- if `inline' is disabled
    -- Only show inlay hints for the current line
    only_current_line = false,
    -- Event which triggers a refresh of the inlay hints.
    -- You can make this { "CursorMoved" } or { "CursorMoved,CursorMovedI" } but
    -- not that this may cause  higher CPU usage.
    -- This option is only respected when only_current_line and
    -- autoSetHints both are true.
    only_current_line_autocmd = { "CursorHold" },
    -- whether to show parameter hints with the inlay hints or not
    show_parameter_hints = true,
    -- prefix for parameter hints
    parameter_hints_prefix = "<- ",
    -- prefix for all the other hints (type, chaining)
    other_hints_prefix = "=> ",
    -- whether to align to the length of the longest line in the file
    max_len_align = false,
    -- padding from the left if max_len_align is true
    max_len_align_padding = 1,
    -- whether to align to the extreme right or not
    right_align = false,
    -- padding from the right if right_align is true
    right_align_padding = 7,
    -- The color of the hints
    highlight = "Comment",
    -- The highlight group priority for extmark
    priority = 100,
  },
  ast = {
    -- These are unicode, should be available in any font
    role_icons = {
      type = "🄣",
      declaration = "🄓",
      expression = "🄔",
      statement = ";",
      specifier = "🄢",
      ["template argument"] = "🆃",
    },
    kind_icons = {
      Compound = "🄲",
      Recovery = "🅁",
      TranslationUnit = "🅄",
      PackExpansion = "🄿",
      TemplateTypeParm = "🅃",
      TemplateTemplateParm = "🅃",
      TemplateParamObject = "🅃",
    },
    --[[ These require codicons (https://github.com/microsoft/vscode-codicons)
            role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
            },

            kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
            }, ]]

    highlights = {
      detail = "Comment",
    },
  },
  memory_usage = {
    border = "none",
  },
  symbol_info = {
    border = "none",
  },
})
require("f-string-toggle").setup({
  key_binding = "<leader>fs",
  key_binding_desc = "Toggle f-string"
})

require('glow').setup({
  width = 240, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
  height_ratio = 0.9,
})

require("chatgpt").setup({
  api_key_cmd = ""
})
