return {
   "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    lazy = false,
    priority = 1000,
    config = function()
      require("colorizer").setup({})
    end
}
