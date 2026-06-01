local modes = {
  n = "NORMAL",
  no = "OP-PENDING",
  nov = "OP-PENDING",
  noV = "OP-PENDING",
  ["no\22"] = "OP-PENDING",
  niI = "NORMAL",
  niR = "NORMAL",
  niV = "NORMAL",
  nt = "NORMAL",
  v = "VISUAL",
  vs = "VISUAL",
  V = "V-LINE",
  Vs = "V-LINE",
  ["\22"] = "V-BLOCK",
  ["\22s"] = "V-BLOCK",
  s = "SELECT",
  S = "S-LINE",
  ["\19"] = "S-BLOCK",
  i = "INSERT",
  ic = "INSERT",
  ix = "INSERT",
  R = "REPLACE",
  Rc = "REPLACE",
  Rx = "REPLACE",
  Rv = "V-REPLACE",
  Rvc = "V-REPLACE",
  Rvx = "V-REPLACE",
  c = "COMMAND",
  cv = "EX",
  ce = "EX",
  r = "PROMPT",
  rm = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  t = "TERMINAL",
}

function _G.Statusline()
  local mode = modes[vim.api.nvim_get_mode().mode] or "UNKNOWN"

  return table.concat({
    " ",
    mode,
    "  %f",
    "%m",
    "%r",
    "%=",
    "%y",
    "  %l:%c",
    "  %p%% ",
  })
end

vim.opt.laststatus = 2
vim.opt.statusline = "%!v:lua.Statusline()"
