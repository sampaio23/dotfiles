return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
  },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    local function tag_definition()
      local word = vim.fn.expand("<cword>")

      if word == "" then
        return
      end

      vim.cmd.tag(word)
    end

    local function grep_references()
      require("telescope.builtin").grep_string({
        search = vim.fn.expand("<cword>"),
      })
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "Configure LSP keymaps",
      callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("n", "gd", tag_definition, opts)
        vim.keymap.set("n", "gD", "<cmd>tselect <C-r><C-w><CR>", opts)
        vim.keymap.set("n", "gr", grep_references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      end,
    })

    vim.lsp.config("clangd", {
      capabilities = capabilities,
      cmd = { "clangd", "--background-index" },
    })
    vim.lsp.enable("clangd")
  end,
}
