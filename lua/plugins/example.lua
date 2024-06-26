return {
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Color scheme
  { "marko-cerovac/material.nvim" },

  -- Transparent background
  { "xiyaowong/transparent.nvim" },

  -- Smart window showing all the errors in code
  { "folke/trouble.nvim" },

  -- Tag bar
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "tg", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },

  -- Language servers and code tools
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "clang-format",
        "cmakelang",
        "gitlint",
        "htmlbeautifier",
        "jq-lsp",
        "sql-formatter",
        -- "yamllint",
        -- "yamlfmt",
      },
    },
  },

  -- LSP config
  {
    "neovim/nvim-lspconfig",
    -- dependencies = {
    --   "jose-elias-alvarez/typescript.nvim",
    --   init = function()
    --     require("lazyvim.util").on_attach(function(_, buffer)
    --       -- stylua: ignore
    --       vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
    --       vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
    --     end)
    --   end,
    -- },
    ---@class PluginLspOpts
    opts = {
      inlay_hints = { enabled = false },
      --- @type lspconfig.options
      servers = {
        -- beautysh = {},
        -- black = {},
        -- cbfmt = {},
        -- gh = {},
        -- jq = {},
        -- mdformat = {},
        -- misspell = {},
        -- neocmake = {},
        -- shellcheck = {},
        -- shellharden = {},
        -- shfmt = {},
        awk_ls = { on_attach = require("format_diff").on_attach },
        bashls = { on_attach = require("format_diff").on_attach },
        clangd = {
          on_attach = require("format_diff").on_attach,
          cmd = {
            "clangd",
            "--offset-encoding=utf-16",
          },
        },
        cmake = { on_attach = require("format_diff").on_attach },
        docker_compose_language_service = { on_attach = require("format_diff").on_attach },
        dockerls = { on_attach = require("format_diff").on_attach },
        gopls = { on_attach = require("format_diff").on_attach },
        html = { on_attach = require("format_diff").on_attach },
        jsonls = { on_attach = require("format_diff").on_attach },
        lua_ls = { on_attach = require("format_diff").on_attach },
        marksman = { on_attach = require("format_diff").on_attach },
        pylsp = { on_attach = require("format_diff").on_attach },
        rust_analyzer = { on_attach = require("format_diff").on_attach },
        sqlls = { on_attach = require("format_diff").on_attach },
        vimls = { on_attach = require("format_diff").on_attach },
        yamlls = { on_attach = require("format_diff").on_attach },
      },
      autoformat = false,
      format = { timeout_ms = nil },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      -- @type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      -- setup = {
      --   -- example to setup with typescript.nvim
      --   tsserver = function(_, opts)
      --     require("typescript").setup({ server = opts })
      --     return true
      --   end,
      --   -- Specify * to use this function as a fallback for any server
      --   -- ["*"] = function(server, opts) end,
      -- },
    },
  },

  -- Format diff
  { "nvim-lua/plenary.nvim" },
  { "joechrisellis/lsp-format-modifications.nvim" },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "bottom", width = 0.95 },
        sorting_strategy = "descending",
        winblend = 0,
      },
    },
  },
  -- Better fuzzy search score for Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  -- Surrounding
  {
    "kylechui/nvim-surround",
    -- version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },

  -- TreeSitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "c",
        "cpp",
        "html",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "vim",
        "yaml",
      })
    end,
  },

  -- Better hover for LSP or GitHub
  {
    "lewis6991/hover.nvim",
    config = function()
      require("hover").setup({
        init = function()
          require("hover.providers.lsp")
          require("hover.providers.gh")
          require("hover.providers.gh_user")
          require("hover.providers.man")
        end,
        preview_opts = {
          border = nil,
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = true,
      })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
      }
    end,
  },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
      opts.sorting = {
        priority_weight = 42,
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.recently_used,
          require("clangd_extensions.cmp_scores"),
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      }
    end,
  },
  -- Smooth scroll
  { "karb94/neoscroll.nvim" },
  -- Github integration for TreeSitter
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = function()
      require("octo").setup()
    end,
  },

  -- Better yank/put
  { "gbprod/yanky.nvim" },

  -- FZF
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      -- require("fzf-lua").setup({})
    end,
  },
  -- Multi-cursor
  {
    "mg979/vim-visual-multi",
  },

  -- To make rust libraries work (fmt)
  {
    "rust-lang/rust.vim",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    "tpope/vim-fugitive",
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
    },
    enabled = true,
  },

  {
    "stevearc/conform.nvim",
    opts = {},
    enabled = false,
  },
  { "ojroques/nvim-osc52" },
  { "p00f/clangd_extensions.nvim" },
  { "arkav/lualine-lsp-progress" },
  { "aznhe21/actions-preview.nvim" },
  -- { "ms-jpq/coq_nvim" },
  { "roobert/f-string-toggle.nvim" },
  -- Markdown preview
  { "ellisonleao/glow.nvim",       config = true,  cmd = "Glow" },
  { "lcheylus/overlength.nvim",    enabled = false },
  -- >= 0.10.0-dev
  -- -- { "Bekaboo/dropbar.nvim" },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  {
    "wsdjeg/vim-fetch",
  },
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   config = function(_, opts) require 'lsp_signature'.setup(opts) end
  -- }
  {
    "github/copilot.vim"
  },
  { "kevinhwang91/nvim-hlslens" },
}
