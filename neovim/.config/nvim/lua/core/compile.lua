local keymap = vim.keymap.set

local compile_buf = nil
local compile_job = nil

local function create_compile_buffer()
  if compile_buf and vim.api.nvim_buf_is_valid(compile_buf) then
    vim.api.nvim_buf_delete(compile_buf, { force = true })
  end

  compile_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(compile_buf, "*compile*")
  vim.bo[compile_buf].buftype = "nofile"
  vim.bo[compile_buf].bufhidden = "hide"
  vim.bo[compile_buf].swapfile = false
  vim.bo[compile_buf].filetype = "compile"
  vim.bo[compile_buf].modified = false

  return compile_buf
end

local function open_compile_window(buf)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == buf then
      vim.api.nvim_set_current_win(win)
      vim.cmd("resize 10")
      return win
    end
  end

  vim.cmd("botright 10split")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)
  return win
end

local function append_lines(buf, lines)
  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end

  if #lines == 0 or (#lines == 1 and lines[1] == "") then
    return
  end

  vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
  vim.bo[buf].modified = false

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == buf then
      local line_count = vim.api.nvim_buf_line_count(buf)
      vim.api.nvim_win_set_cursor(win, { line_count, 0 })
    end
  end
end

local function find_compile_window(buf)
  if not (buf and vim.api.nvim_buf_is_valid(buf)) then
    return nil
  end

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == buf then
      return win
    end
  end

  return nil
end

local function set_modifiable(buf, modifiable)
  if vim.api.nvim_buf_is_valid(buf) then
    vim.bo[buf].modifiable = modifiable
    vim.bo[buf].modified = false
  end
end

local function run_compile(command)
  if command == "" then
    return
  end

  if compile_job then
    vim.fn.jobstop(compile_job)
    compile_job = nil
  end

  local buf = create_compile_buffer()
  open_compile_window(buf)
  set_modifiable(buf, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "$ " .. command, "" })
  set_modifiable(buf, false)

  compile_job = vim.fn.jobstart(command, {
    stdout_buffered = false,
    stderr_buffered = false,
    on_stdout = function(_, data)
      vim.schedule(function()
        set_modifiable(buf, true)
        append_lines(buf, data)
        set_modifiable(buf, false)
      end)
    end,
    on_stderr = function(_, data)
      vim.schedule(function()
        set_modifiable(buf, true)
        append_lines(buf, data)
        set_modifiable(buf, false)
      end)
    end,
    on_exit = function(job_id, code)
      vim.schedule(function()
        set_modifiable(buf, true)
        append_lines(buf, { "", "[process exited " .. code .. "]" })
        set_modifiable(buf, false)

        if compile_job == job_id then
          compile_job = nil
        end
      end)
    end,
  })

  if compile_job <= 0 then
    compile_job = nil
    set_modifiable(buf, true)
    append_lines(buf, { "", "[failed to start process]" })
    set_modifiable(buf, false)
  end
end

local function compile_prompt()
  local command = vim.fn.input("Compile: ")
  run_compile(command)
end

local function compile_toggle()
  if not (compile_buf and vim.api.nvim_buf_is_valid(compile_buf)) then
    vim.notify("No compilation buffer exists", vim.log.levels.INFO)
    return
  end

  local win = find_compile_window(compile_buf)

  if not win then
    open_compile_window(compile_buf)
    return
  end

  if vim.api.nvim_get_current_win() == win then
    pcall(vim.api.nvim_win_close, win, false)
    return
  end

  vim.api.nvim_set_current_win(win)
end

keymap("n", "<leader>c", compile_prompt, { desc = "Compile command" })
keymap("n", "<leader>C", compile_toggle, { desc = "Toggle compilation split" })
