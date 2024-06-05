-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- restore cursor shape: https://github.com/neovim/neovim/issues/21480
vim.cmd([[
    augroup RestoreCursorShapeOnExit
        autocmd!
        autocmd VimLeave * set guicursor=a:ver1
    augroup END
]])
