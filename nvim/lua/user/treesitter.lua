-- Treesitter Configuration
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'bash', 'c', 'cpp', 'css', 'html', 'javascript', 'json', 'lua',
    'python', 'rust', 'typescript', 'java', 'dart', 'sql'
  },
  highlight = {
    enable = true,
  },
}
