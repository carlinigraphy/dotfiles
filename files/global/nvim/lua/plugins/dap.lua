local configured_filetypes = {
   "lua"
}

return { {
   "mfussenegger/nvim-dap",
   ft = configured_filetypes,
   config = function()
      local dap = require("dap")

      -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#lua
      local lldebug = "/home/aurelius/apps/local-lua-debugger-vscode"
      dap.adapters["local-lua"] = {
         type = "executable",
         command = "node",
         args = { lldebug .. "/extension/debugAdapter.js" },
         enrich_config = function(config, on_config)
            if config["extensionPath"] then
               on_config(config)
            else
               local c = vim.deepcopy(config)
               c.extensionPath = lldebug
               on_config(c)
            end
         end,
      }

      dap.configurations.lua = { {
         name = "Current file (local-lua-dbg)",
         type = "local-lua",
         request = "launch",
         cwd = "${workspaceFolder}",
         program = {
            lua = "luajit",
            file = "${file}",
         },
      }, {
         name = "Current file (nlua.lua)",
         type = "local-lua",
         request = "launch",
         cwd = "${workspaceFolder}",
         program = {
            lua = "nlua.lua",
            file = "${file}",
         },
      } }

      vim.keymap.set("n", "<leader>dc", dap.continue)
      vim.keymap.set("n", "<leader>o", dap.step_over)
      vim.keymap.set("n", "<leader>i", dap.step_into)
      vim.keymap.set("n", "<leader>u", dap.step_out)
      vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint)
      vim.keymap.set("n", "<leader>db", function()
         dap.set_breakpoint(vim.fn.input("Break when: "))
      end)
   end
}, {
   "rcarriga/nvim-dap-ui",
   ft = configured_filetypes,

   dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
   },

   config = function()
      local dapui = require("dapui")

      local dap = require("dap")
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end

      dapui.setup({
         controls = {
            element = "repl",
            enabled = false,
         },
         element_mappings = {},
         expand_lines = true,
         floating = {
            border = "single",
            mappings = {
               close = { "q", "<Esc>" }
            }
         },
         force_buffers = true,
         icons = {
            collapsed = "ᐅ",
            current_frame = "ᐅ",
            expanded = "▼"
         },
         layouts = { {
            elements = { {
               id = "watches",
               size = 0.5
            }, {
               id = "scopes",
               size = 0.5
            } },
            position = "top",
            size = 15
         }, {
            elements = { {
               id = "breakpoints",
               size = 0.4
            }, {
               id = "repl",
               size = 0.6
            } },
            position = "bottom",
            size = 15
         } },
         mappings = {
            edit   = "e",
            expand = "<CR>",
            open   = "o",
            remove = "d",
            repl   = "r",
            toggle = "t"
         },
         render = {
            indent = 1,
            max_value_lines = 100
         }
      })

      vim.keymap.set("n", "<leader>do", dapui.open)
      vim.keymap.set("n", "<leader>dq", dapui.close)
   end
} }
