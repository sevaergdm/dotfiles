return {
  "eldritch-theme/eldritch.nvim",
  lazy = false,
  priority = 1000,
	config = function()
    require("eldritch").setup({})
		vim.cmd("colorscheme eldritch")

    -- Diagnostic underlines
--  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#FF0000" })
--  vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = "#FFFF00" })
--  vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",  { undercurl = true, sp = "#0000FF" })
--  vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",  { undercurl = true, sp = "#00FF00" })
	end
--{
--  "xero/miasma.nvim",
--  lazy = false,
--  priority = 1000,
--  config = function()
--    vim.cmd("colorscheme miasma")

--    vim.cmd("hi! link LineNr StatusLine")
--    vim.cmd("hi! link CursorLineNr StatusLine")
--    vim.cmd("hi! link LineNrAbove ErrorMsg")
--    vim.cmd("hi! link LineNrBelow Question")
--  end,
--}
}
