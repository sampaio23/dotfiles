local function find_files()
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  require("telescope.builtin").find_files({
    attach_mappings = function(prompt_bufnr, map)
      local function open_or_create_file()
        local selection = action_state.get_selected_entry()

        if selection then
          actions.select_default(prompt_bufnr)
          return
        end

        local filename = vim.trim(action_state.get_current_line())

        if filename == "" then
          return
        end

        local picker = action_state.get_current_picker(prompt_bufnr)
        local cwd = picker.cwd or vim.fn.getcwd()
        local path = vim.fn.expand(filename)

        if not vim.startswith(path, "/") then
          path = cwd .. "/" .. path
        end

        path = vim.fn.fnamemodify(path, ":p")

        actions.close(prompt_bufnr)
        vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")

        if vim.fn.filereadable(path) == 0 then
          vim.fn.writefile({}, path)
        end

        vim.cmd.edit(vim.fn.fnameescape(path))
      end

      map("i", "<CR>", open_or_create_file)
      map("n", "<CR>", open_or_create_file)
      return true
    end,
  })
end

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "Telescope",
  keys = {
    {
      "<leader>f",
      find_files,
      desc = "Find files",
    },
    {
      "<leader>/",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Grep files",
    },
    {
      "<leader>b",
      function()
        require("telescope.builtin").buffers()
      end,
      desc = "List buffers",
    },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
  },
}
