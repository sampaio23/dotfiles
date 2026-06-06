local keymap = vim.keymap.set

local function query_replace(range)
  local search = vim.fn.input("Replace: ")

  if search == "" then
    return
  end

  local replacement = vim.fn.input("With: ")
  local escaped_search = vim.fn.escape(search, [[/\]])
  local escaped_replacement = vim.fn.escape(replacement, [[/\&]])

  vim.cmd(string.format([[%ss/\V%s/%s/gc]], range, escaped_search, escaped_replacement))
end

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

keymap("n", "<leader>w", "<cmd>write<CR>", { desc = "Write file" })
keymap("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit window" })
keymap("n", "<leader>x", "<cmd>x<CR>", { desc = "Write and quit" })
keymap("n", "<leader>n", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap("n", "<leader>p", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<leader>d", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
keymap("n", "<leader>r", function()
  query_replace("%")
end, { desc = "Query replace" })
keymap("v", "<leader>r", function()
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")

  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  query_replace(string.format("%d,%d", start_line, end_line))
end, { desc = "Query replace selection" })
keymap("n", "<leader>s", "<cmd>vsplit<CR>", { desc = "Vertical split" })

keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
keymap("n", "<C-Left>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-Down>", "<C-w>j", { desc = "Move to lower window" })
keymap("n", "<C-Up>", "<C-w>k", { desc = "Move to upper window" })
keymap("n", "<C-Right>", "<C-w>l", { desc = "Move to right window" })
keymap("i", "<C-Left>", "<Esc><C-w>h", { desc = "Move to left window" })
keymap("i", "<C-Down>", "<Esc><C-w>j", { desc = "Move to lower window" })
keymap("i", "<C-Up>", "<Esc><C-w>k", { desc = "Move to upper window" })
keymap("i", "<C-Right>", "<Esc><C-w>l", { desc = "Move to right window" })
keymap("v", "<C-Left>", "<Esc><C-w>h", { desc = "Move to left window" })
keymap("v", "<C-Down>", "<Esc><C-w>j", { desc = "Move to lower window" })
keymap("v", "<C-Up>", "<Esc><C-w>k", { desc = "Move to upper window" })
keymap("v", "<C-Right>", "<Esc><C-w>l", { desc = "Move to right window" })
keymap("t", "<C-Left>", "<C-\\><C-n><C-w>h", { desc = "Move to left window" })
keymap("t", "<C-Down>", "<C-\\><C-n><C-w>j", { desc = "Move to lower window" })
keymap("t", "<C-Up>", "<C-\\><C-n><C-w>k", { desc = "Move to upper window" })
keymap("t", "<C-Right>", "<C-\\><C-n><C-w>l", { desc = "Move to right window" })

keymap("n", "<Tab>", ">>", { desc = "Indent line" })
keymap("n", "<S-Tab>", "<<", { desc = "Unindent line" })
keymap("i", "<S-Tab>", "<C-d>", { desc = "Unindent line" })
keymap("v", "<Tab>", ">gv", { desc = "Indent selection" })
keymap("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })
keymap("v", "<", "<gv", { desc = "Unindent selection" })
keymap("v", ">", ">gv", { desc = "Indent selection" })

keymap("n", "<A-Up>", "<cmd>move .-2<CR>==", { desc = "Move line up" })
keymap("n", "<A-Down>", "<cmd>move .+1<CR>==", { desc = "Move line down" })
keymap("v", "<A-Up>", ":move '<-2<CR>gv=gv", { desc = "Move selection up" })
keymap("v", "<A-Down>", ":move '>+1<CR>gv=gv", { desc = "Move selection down" })
