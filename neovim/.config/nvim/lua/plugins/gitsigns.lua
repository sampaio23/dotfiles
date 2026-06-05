return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "^" },
            changedelete = { text = "~" },
        },
        current_line_blame = false,
        word_diff = false,
        on_attach = function(bufnr)
            local gitsigns = package.loaded.gitsigns

            vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk_inline, {
                buffer = bufnr,
                desc = "Preview Git hunk inline",
            })

            vim.keymap.set("n", "<leader>gh", gitsigns.toggle_linehl, {
                buffer = bufnr,
                desc = "Toggle Git line highlight",
            })

            vim.keymap.set("n", "<leader>gu", gitsigns.reset_hunk, {
                buffer = bufnr,
                desc = "Undo Git hunk",
            })
        end,
    },
}
