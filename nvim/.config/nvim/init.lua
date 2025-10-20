require("config.keybinds")
require("config.lazy")
require("config.options")

-- Undercurl
vim.cmd([[
  let &t_Cs = "\e[4:3m"  " start undercurl
  let &t_Ce = "\e[4:0m"  " end undercurl
]])

--vim.opt.spell = true
--vim.opt.spelllang = { "en_us" }

