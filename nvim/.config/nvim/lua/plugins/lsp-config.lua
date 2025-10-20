return {
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "bashls",
        "clangd",
        "dockerls",
        "gopls",
        "pyright",
        "jsonls",
        "vimls",
        "sqls",
        "terraformls",
        "tflint",
      }
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = true
          vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
          vim.keymap.set("n", "gd", "vim.lsp.buf.definition", {})
          vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, {})
        end,
        handlers = {
          gopls = function()
            lspconfig.gopls.setup({
              capabilities = capabilities,
              settings = {
                gopls = {
                  staticcheck = false,
                }
              }
            })
          end,
          terraformls = function()
            lspconfig.terraformls.setup({
              capabilities = capabilities,
              settings = {
                ["terraformls"] = {
                  formatting = {
                    timeout_ms = 5000,
                  }
                }
              }
            })
          end,
        }
      })
    end
  }
}
