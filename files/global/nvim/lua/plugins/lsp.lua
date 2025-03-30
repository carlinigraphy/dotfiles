-- Don't load LSP in diff mode. Diff markers mess it up.
if vim.opt.diff:get() then
   return {}
end

vim.api.nvim_create_autocmd("LspAttach", {
   group = vim.api.nvim_create_augroup("UserLspConfig", {}),
   callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
      vim.keymap.set('n', '<C-k>'   , vim.diagnostic.open_float)

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
         vim.lsp.handlers.hover, { border = "single" }
      )

      if client.supports_method("textDocument/signatureHelp") then
         vim.keymap.set("i", "<C-l>", vim.lsp.buf.signature_help, {
            buffer = args.buf,
            desc = "LSP::signature_help()"
         })
         vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help, { border = "single" }
         )
      end

      -- Find available methods via:
      -- :h lsp-method
      for binding, method in pairs({
         ["<leader>ca"] = {
            name = "textDocument/codeAction",
            fn   = vim.lsp.buf.code_action
         },
         ["gO"]  = {
            name = "textDocument/documentSymbol",
            fn   = function()
               vim.lsp.buf.document_symbol({ loclist = true })
            end,
         },
         ["grn"] = {
            name = "textDocument/rename",
            fn   = vim.lsp.buf.rename
         },
         ["gd"]  = {
            name = "textDocument/definition",
            fn = function()
               vim.lsp.buf.definition({ loclist=true })
            end,
         },
         ["gri"] = {
            name = "textDocument/implementation",
            fn = function()
               vim.lsp.buf.implementation(nil, { loclist=true })
            end,
         },
         ["grr"] = {
            name = "textDocument/references",
            fn = function()
               vim.lsp.buf.references(nil, { loclist=true })
            end,
         },
      }) do
         if client.supports_method(method.name) then
            vim.keymap.set("n", binding, method.fn, {
               buffer = args.buf,
               desc = method[1],
            })
         end
      end
  end,
})


vim.diagnostic.config({
   underline     = false,
   severity_sort = false,
   signs         = false,
   virtual_text  = {
      format = function() return "" end,
   },
   float = {
      header = false,
      suffix = "",
      prefix = function(diag, _, _)
         return (diag.code or "").."/", "Paynes1"
      end,
      border = "single",
   },
})

local bin =
   vim.fn.stdpath("data") .. "/mason/bin/"

-- Grab from here:
-- https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/configs
local servers = {
   {  name = "bash",
      filetypes = { "sh" },
      _root_dir = { ".jj", ".git", ".hg" },
      cmd = { bin .. "bash-language-server", "start" },
      settings = {
         bashIde = {
            globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
         },
      },
      single_file_support = true,
   },

   {  name = "lua",
      filetypes = { "lua" },
      _root_dir = { ".jj", ".git", ".hg", ".luarc.json" },
      cmd = { bin .. "lua-language-server" },
      log_level = vim.lsp.protocol.MessageType.Warning,
      single_file_support = true,
   },

   -- {  name = "fennel",
   --    filetypes = { "fennel" },
   --    cmd = { bin .. "fennel-ls" },
   --    _root_dir = { "flsproject.fnl" },
   --    settings = {},
   --    capabilities = {
   --       offsetEncoding = { "utf-8", "utf-16" },
   --    },
   -- },

   -- {  name = "fennel",
   --    filetypes = { "fennel" },
   --    cmd = { bin .. "fennel-language-server" },
   --    single_file_support = true,
   --    _root_dir = { ".git", ".jj", ".luarc.json" },
   -- },

   {  name = "terraform",
      filetypes = { "terraform", "terraform-vars" },
      cmd = { bin .. "terraform-ls", "serve" },
      _root_dir = { ".terraform", ".git", ".jj" },
   }
}

vim.iter(servers):map(function(config)
   ---@diagnostic disable-next-line: unused-local
   config.on_attach = function(client, _bufnr)
      client.server_capabilities.semanticTokensProvider = nil
   end
end)

for _, config in ipairs(servers) do
   vim.api.nvim_create_autocmd("FileType", {
      pattern = config.filetypes,
      callback = function(args)
         config.root_dir = vim.fs.root(args.buf, config._root_dir)
         vim.lsp.start(config)
      end,
   })
end

return {
   { "williamboman/mason.nvim",
      cmd  = "Mason",
      opts = {
         ui = {
            border = "single",
            height = 0.8,
            width  = 0.5,
         },
      },
   },
}
