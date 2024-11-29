vim.api.nvim_create_autocmd('LspAttach', {
   group = vim.api.nvim_create_augroup('UserLspConfig', {}),
   callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if client.supports_method('textDocument/definition') then
         -- This one specifically overwrites the built in `gd` mapping, as it's
         -- strictly a drop-in replacement, but better.
         vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {
            buffer = args.buf,
            desc = "LSP::definition()"
         })
      end

      if client.supports_method('textDocument/codeAction') then
         vim.keymap.set('n', 'grc', vim.lsp.buf.code_action, {
            buffer = args.buf,
            desc = "LSP::codeAction()"
         })
      end

      if client.supports_method('textDocument/rename') then
         vim.keymap.set('n', 'grn', vim.lsp.buf.rename, {
            buffer = args.buf,
            desc = "LSP::rename()"
         })
      end

      if client.supports_method('textDocument/implementation') then
         vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, {
            buffer = args.buf,
            desc = "LSP::implementation()"
         })
      end

      if client.supports_method('textDocument/references') then
         vim.keymap.set('n', 'grr', vim.lsp.buf.references, {
            buffer = args.buf,
            desc = "LSP::references()"
         })
      end
  end,
})


-- 2024-11-27
--    Moving away from this style for a little while. It just never felt
--    "right", and was constantly running into visibility concerns.
--[[
local border = {
  {" ", "FloatBorder"}, -- top left
  { "", "FloatBorder"}, -- top
  {" ", "FloatBorder"}, -- top right
  {" ", "FloatBorder"}, -- right
  {" ", "FloatBorder"}, -- bottom right
  { "", "FloatBorder"}, -- bottom
  {" ", "FloatBorder"}, -- bottom left
  {" ", "FloatBorder"}, -- left
}
local orig_preview_fn = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(_1, _2, opts, ...)
 opts = opts or {}
 opts.border = opts.border or border
 return orig_preview_fn(_1, _2, opts, ...)
end
--]]


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
         return (diag.code or "").."/", "Todo"
      end,
      border = "single",
   },
})

local bin =
   vim.fn.stdpath('data') .. '/mason/bin/'

-- Grab from here:
-- https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/configs
local servers = {
   {  name = "bash",
      filetypes = { "sh" },
      _root_dir = { ".git", ".hg" },
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
      _root_dir = { ".git", ".hg", ".luarc.json" },
      cmd = { bin .. "lua-language-server" },
      log_level = vim.lsp.protocol.MessageType.Warning,
      single_file_support = true,
   },

   {  name = "fennel",
      filetypes = { "fennel" },
      cmd = { bin .. "fennel-ls" },
      _root_dir = { "flsproject.fnl" },
      settings = {},
      capabilities = {
         offsetEncoding = { "utf-8", "utf-16" },
      },
   },

   -- {  name = "elixer",
   --    filetypes = { "elixir", "eelixir", "heex", "surface" },
   --    cmd = { bin .. "elixir-ls" },
   --    _root_dir = { "mix.esx", ".git", ".hg" },
   --    single_file_support = true,
   -- }
}

vim.iter(servers):map(function(config)
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
   { 'williamboman/mason.nvim',
      cmd  = 'Mason',
      opts = {
         ui = {
            border = "single",
            height = 0.8,
            width  = 0.5,
         },
      },
   },
}
