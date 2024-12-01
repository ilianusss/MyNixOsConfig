local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Telescope keybindings
keymap('n', '<leader>ff', ':Telescope find_files<CR>', opts)
keymap('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
keymap('n', '<leader>fb', ':Telescope buffers<CR>', opts)
keymap('n', '<leader>fh', ':Telescope help_tags<CR>', opts)

-- NvimTree toggle
keymap('n', '<leader>n', ':NvimTreeToggle<CR>', opts)

-- Basic operations
keymap('n', '<leader>q', ':q<CR>', opts)
keymap('n', '<leader>w', ':w<CR>', opts)

-- Diagnostic key mappings
keymap('n', '[d', vim.diagnostic.goto_prev, opts)
keymap('n', ']d', vim.diagnostic.goto_next, opts)
keymap('n', '<leader>e', vim.diagnostic.open_float, opts)
keymap('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Twilight mapping
vim.keymap.set('n', '<leader>tw', ':Twilight<CR>', { noremap = true, silent = true })
