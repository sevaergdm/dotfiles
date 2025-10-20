local set = vim.opt

-- indentation and tabs
set.expandtab = true
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.autoindent = true
set.wrap = true
set.breakindent = true
set.showbreak = true
set.showbreak = string.rep(" ", 2)
set.linebreak = true

-- Remapping to handle word wrap
vim.keymap.set('n', 'k', "v:count==0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count==0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Line numbers
set.relativenumber = true
set.number = true
set.cursorline = true

vim.diagnostic.config({ virtual_text = true })
