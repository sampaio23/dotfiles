vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = false

opt.clipboard = "unnamedplus"

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 10

opt.termguicolors = true
opt.signcolumn = "yes"
opt.showmode = false

opt.list = true
opt.listchars = {
  space = "·",
  tab = "» ",
  trail = "·",
  extends = "›",
  precedes = "‹",
  nbsp = "␣",
}

opt.completeopt = { "menu", "menuone", "noselect" }
opt.tags = { "./tags;", "tags" }

vim.diagnostic.config({
  signs = false,
  underline = false,
  virtual_text = false,
})

vim.cmd.colorscheme("koehler")
vim.api.nvim_set_hl(0, "Whitespace", { fg = "#303030" })
