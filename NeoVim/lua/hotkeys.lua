vim.keymap.set('i', 'jj', '<Esc>')
-- quick-open
vim.keymap.set('', '<C-p>', '<cmd>Files<cr>')
vim.keymap.set('', '<leader>o', '<cmd>Files<cr>')
-- search buffers
vim.keymap.set('n', '<leader>b', '<cmd>Buffers<cr>')
-- copy to system clipboard
vim.keymap.set('v', '<C-c>', '"*y')
