--[[ TODO

[ ] Customizing floating windows:

    Things are mostly there, but not complete. I'd like to spend some more time
    in the future working on theming floats. The current configuration is
    pretty good for LSP popups (the added space given by edge-borders, rather
    than boxes, makes lighter than background floating windows possible).

[ ] Better navigation, editing

--]]


-- Setup language servers.
local lspconfig = require('lspconfig')

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<C-k>', vim.diagnostic.open_float)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
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
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
  end,
})

-- https://codepoints.net/block_elements
local border = {
      {"▛", "FloatBorder"},      -- top left
      {"▔", "FloatBorder"},      -- top
      {"▜", "FloatBorder"},      -- top right
      {"▕", "FloatBorder"},      -- right
      {"▟", "FloatBorder"},      -- bottom right
      {"▁", "FloatBorder"},      -- bottom
      {"▙", "FloatBorder"},      -- bottom left
      {"▏", "FloatBorder"},      -- left
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
   virtual_text  = {
      format = function(_)
         return ''
      end,
   },
   float = {
      border = 'single',
   },
})

for server, opts in pairs({
   lua_ls = {},
   bashls = {},
   elixirls = {
      cmd = { '/home/aurelius/.local/share/nvim/mason/bin/elixir-ls' }
   }
}) do
   --lspconfig[server].setup(vim.tbl_deep_extend("keep", opts, { }))
   lspconfig[server].setup(opts)
end
