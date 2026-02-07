vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.cmd [[
      hi Normal guibg=NONE
      hi NormalNC guibg=NONE
      hi EndOfBuffer guibg=NONE
      hi SignColumn guibg=NONE

      hi NeoTreeNormal guibg=NONE
      hi NeoTreeNormalNC guibg=NONE
    ]]
  end,
})


