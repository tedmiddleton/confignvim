if lazyvim_docs then
  -- In case you don't want to use `:LazyExtras`,
  -- then you need to set the option below.
  vim.g.lazyvim_picker = "snacks"
end

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_insert_mode = true,
        question_header = "  " .. user .. " ",
        answer_header = "  Copilot ",
        model = "gemini-2.0-flash-001",
        window = {
          width = 0.4,
        },
      }
    end,
  },
  {
    "folke/noice.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  {
    "folke/snacks.nvim",
    opts = {
      scroll = {
        enabled = false, -- Disable scroll animation
      },
      indent = {
        enabled = false,
      }
    },

    keys = {
      --{ "<C-p>", LazyVim.pick("grep"), desc = "Grep (Root Dir)" },
      { "<C-j>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      -- find
      {
        "<C-y>",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      { "<C-h>", LazyVim.pick("oldfiles"), desc = "Recent" },
      { "<C-p>", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
    },
  },
  {
    "jpalardy/vim-slime",
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized8",
    },
  },
  {
    "lifepillar/vim-solarized8",
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
      servers = {
        clangd = {
          mason = false, -- this just doesn't work anywhere other than macos
          keys = {
            { "<C-a>", "<cmd>ClangdSwitchSourceHeader<cr>" },
            {
              "<C-m>",
              function()
                Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter })
              end,
              desc = "LSP Workspace Symbols",
              has = "workspace/symbols",
            },
          },
        },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<C-n>",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cpp = { "clang-format" },
        c = { "clang-format" },
        h = { "clang-format" },
      },
      formatters = {
        -- add any custom formatters here
        -- prettier = {
        --   command = "prettier",
        --   args = { "--stdin-filepath", "$FILENAME" },
        -- },
        --clang_format = {
        --  command = "clang-format",
        --  stdin = true,
        --  --prepend_args = { "--style=Microsoft" },
        --  args = { "--assume-filename", "$FILENAME" },
        --},
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    optional = true,
    opts = function()
      require("copilot.api").status = require("copilot.status")
    end,
  },
}
