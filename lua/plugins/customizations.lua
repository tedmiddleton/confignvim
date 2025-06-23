if lazyvim_docs then
  -- In case you don't want to use `:LazyExtras`,
  -- then you need to set the option below.
  vim.g.lazyvim_picker = "snacks"
end

require('lspconfig').clangd.setup{}
local context = require('CopilotChat.context')
local utils = require('CopilotChat.utils')

return {
  {
    "CopilotC-Ide/CopilotChat.nvim",
    enabled = false,
  },
  {
    "yetone/avante.nvim",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = function()
      -- conditionally use the correct build system for the current OS
      if vim.fn.has("win32") == 1 then
        return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      else
        return "make"
      end
    end,
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      -- add any opts here
      -- for example
      provider = "claude",
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-sonnet-4-20250514",
          timeout = 30000, -- Timeout in milliseconds
            extra_request_body = {
              temperature = 0.75,
              max_tokens = 20480,
            },
        },
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "stevearc/dressing.nvim", -- for input provider dressing
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },

    keys = {
      { "<c-s>", "<CR>", ft = "avante-chat", desc = "Submit Prompt", remap = true },
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        function()
          return require("avante").toggle()
        end,
        desc = "Toggle (Avante)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("avante").reset()
        end,
        desc = "Clear (Avante)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          vim.ui.input({
            prompt = "Quick Chat: ",
          }, function(input)
            if input ~= "" then
              require("avante").ask(input)
            end
          end)
        end,
        desc = "Quick Chat (Avante)",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("avante").select_prompt()
        end,
        desc = "Prompt Actions (Avante)",
        mode = { "n", "v" },
      },
    },
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
      --notifier = {
      --  enabled = false, -- Enable notifications
      --},
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
    branch = "neovim"
  },
  {   
    "mason-org/mason.nvim", 
    version = "^1.0.0" 
  },
  { 
    "mason-org/mason-lspconfig.nvim", 
    version = "^1.0.0" 
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
      servers = {
        clangd = {
          mason = false, -- this just doesn't work anywhere other than macos
          filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
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
    "nvim-treesitter/nvim-treesitter",
    --enabled = false,
    opts = {
      indent = {
        enable = true,
        disable = {
          "python", -- disable python indenting
          "cpp",    -- disable cpp indenting
          "c",      -- disable c indenting
          "h",      -- disable h indenting
        }
      }
    }
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
