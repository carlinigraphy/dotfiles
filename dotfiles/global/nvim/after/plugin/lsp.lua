--[[ TODO

[ ] Customizing floating windows:

    Things are mostly there, but not complete. I'd like to spend some more time
    in the future working on theming floats. The current configuration is
    pretty good for LSP popups (the added space given by edge-borders, rather
    than boxes, makes lighter than background floating windows possible).

--]]


-- Setup language servers.
local lspconfig = require('lspconfig')

-- Global mappings.
--^ don't love this binding here

-- Use LspAttach autocommand to map the following keys only after the language
-- server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
   group = vim.api.nvim_create_augroup('UserLspConfig', {}),
   callback = function(ev)
      ---[[ Disables @lsp semantic tokens.
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      client.server_capabilities.semanticTokensProvider = nil
      --]]

      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
  end,
})

-- https://codepoints.net/block_elements
local border = {
   --[=[ Thick borders.
   -- Definitely too chunky, but was getting around a problem of inconsistency
   -- with floating windows. Likely will remove in a future version. The below
   -- glyphs are the only half/quarter-width glyphs that I can find, which
   -- actually align. The ones suggested by nvim-lspconfig don't line up.
   {"▛", "FloatBorder"},
   {"▀", "FloatBorder"},
   {"▜", "FloatBorder"},
   {"▐", "FloatBorder"},
   {"▟", "FloatBorder"},
   {"▄", "FloatBorder"},
   {"▙", "FloatBorder"},
   {"▌", "FloatBorder"},
   --]=]

   -- Just adds a bit of padding to the left/right sides.
   {" ", "FloatBorder"}, -- top left
   { "", "FloatBorder"}, -- top
   {" ", "FloatBorder"}, -- top right
   {" ", "FloatBorder"}, -- right
   {" ", "FloatBorder"}, -- bottom right
   { "", "FloatBorder"}, -- bottom
   {" ", "FloatBorder"}, -- bottom left
   {" ", "FloatBorder"}, -- left
}

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
local orig_preview_fn = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_preview_fn(contents, syntax, opts, ...)
end

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
      border = border,
   },
})

for server, opts in pairs({
   bashls = {},
   ccls = {
      init_options = {
         cache = {
            directory = ".ccls-cache";
         };
      }
   },
   lua_ls = {},
   elixirls = {
      cmd = { '/home/aurelius/.local/share/nvim/mason/bin/elixir-ls' }
   },
   racket_langserver = {
      filetypes = { 'racket' },
   },
}) do
   lspconfig[server].setup(opts)

   --[=[ Unneeded right now, but keeping around in case for later.
   lspconfig[server].setup(vim.tbl_deep_extend("keep", opts, {
      capabilities = capabilities
   }))
   --]=]
end
