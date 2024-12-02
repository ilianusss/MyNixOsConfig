-- LSP Configurations

-- Mason Setup (LSP/DAP installer)
require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = {
    'clangd',        -- C/C++
    'rust_analyzer', -- Rust
    'pyright',       -- Python
    'ts_ls',         -- JavaScript/TypeScript (using ts_ls instead of tsserver)
    'jdtls',         -- Java
    --'sqls',          -- SQL
    'sqlls',          -- SQL
    'gopls',         -- Go
    -- 'dartls' is handled by flutter-tools
  },
}

-- Capabilities for nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Common on_attach function to bind LSP keymaps
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Key mappings for LSP functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  local keymap = vim.keymap.set

  keymap('n', 'gD',        vim.lsp.buf.declaration, bufopts)
  keymap('n', 'gd',        vim.lsp.buf.definition, bufopts)
  keymap('n', 'K',         vim.lsp.buf.hover, bufopts)
  keymap('n', 'gi',        vim.lsp.buf.implementation, bufopts)
  keymap('n', '<C-k>',     vim.lsp.buf.signature_help, bufopts)
  keymap('n', '<leader>wa',vim.lsp.buf.add_workspace_folder, bufopts)
  keymap('n', '<leader>wr',vim.lsp.buf.remove_workspace_folder, bufopts)
  keymap('n', '<leader>wl',function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  keymap('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  keymap('n', '<leader>rn',vim.lsp.buf.rename, bufopts)
  keymap('n', '<leader>ca',vim.lsp.buf.code_action, bufopts)
  keymap('n', 'gr',        vim.lsp.buf.references, bufopts)
  keymap('n', '<leader>f', vim.lsp.buf.format, bufopts)
end

-- Setup LSP servers
local lspconfig = require('lspconfig')
local servers = {
  'clangd',       -- C/C++
  'pyright',      -- Python
  'ts_ls',        -- JavaScript/TypeScript (using ts_ls instead of tsserver)
  'jdtls',        -- Java
  --'sqls',         -- SQL
  'sqlls',         -- SQL
  'gopls',        -- Go
}

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = on_attach,
    capabilities = capabilities, -- Pass capabilities here for autocompletion
  }
end

-- Rust configuration using rust-tools.nvim
require('rust-tools').setup {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
}

-- Flutter/Dart configuration using flutter-tools.nvim
--require('flutter-tools').setup {
--  lsp = {
--    on_attach = on_attach,
--    capabilities = capabilities,
--    settings = {
--      dart = {
--        completeFunctionCalls = true,
--        showTodos = true,
--      },
--    },
--  },
--}

-- Fidget (LSP status)
require('fidget').setup{}

-- Neodev (Neovim Lua API completion)
require('neodev').setup{}

-- nvim-cmp setup for autocompletion
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `LuaSnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept selected item.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require('luasnip').expand_or_jumpable() then
        require('luasnip').expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require('luasnip').jumpable(-1) then
        require('luasnip').jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For LuaSnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` in the command line
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' in the command line
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
