return {
  "eldritch-theme/eldritch.nvim",
  lazy = false,
  priority = 1000,
	config = function()
    require("eldritch").setup({
      transparent = true,
    })
    vim.cmd("colorscheme eldritch")

	end
}
