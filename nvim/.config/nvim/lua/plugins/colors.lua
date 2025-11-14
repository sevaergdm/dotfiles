return {
  'f4z3r/gruvbox-material.nvim',
  lazy = false,
  priority = 1000,
  config = function()
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
  end

  --"eldritch-theme/eldritch.nvim",
  --lazy = false,
  --priority = 1000,
  --config = function()
  --  require("eldritch").setup({
  --    transparent = true,
  --  })
  --  vim.cmd("colorscheme eldritch")

  --end
}
