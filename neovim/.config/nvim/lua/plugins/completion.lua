return {
  "saghen/blink.cmp",
  version = "1.*",
  event = "InsertEnter",
  opts = {
    keymap = {
      preset = "none",
      ["<C-Space>"] = { function(cmp)
        if cmp.is_visible() then
          return cmp.select_next()
        else
          return cmp.show()
        end
      end },
      ["<Nul>"] = { function(cmp)
        if cmp.is_visible() then
          return cmp.select_next()
        else
          return cmp.show()
        end
      end },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      menu = {
        auto_show = false,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 300,
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
  opts_extend = { "sources.default" },
}
