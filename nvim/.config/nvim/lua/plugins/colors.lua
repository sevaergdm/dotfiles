vim.pack.add({
  {
    src = "https://github.com/f4z3r/gruvbox-material.nvim"
  },
})

require("gruvbox-material").setup({
  italics = true,
  contrast = "hard",
  comments = {
    italics = true
  },
  background = {
    transparent = true
  }
})
vim.cmd.colorscheme('gruvbox-material')
