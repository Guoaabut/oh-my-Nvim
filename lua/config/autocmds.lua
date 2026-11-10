-- 自动命令
local aug = vim.api.nvim_create_augroup("user_autocmds", { clear = true })

-- 复制时短暂高亮，确认"复制到了哪一段"
vim.api.nvim_create_autocmd("TextYankPost", {
  group = aug,
  callback = function()
    vim.hl.on_yank({ timeout = 150 })
  end,
  desc = "复制时高亮选区",
})

-- 重新打开文件时回到上次编辑位置
vim.api.nvim_create_autocmd("BufReadPost", {
  group = aug,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "恢复上次光标位置",
})

-- 窗口大小变化后自动均分
vim.api.nvim_create_autocmd("VimResized", {
  group = aug,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
  desc = "窗口变化后均分",
})

-- 按文件类型覆盖缩进（全局默认是 4 空格）
local indent = {
  go = { expandtab = false, tabstop = 4, shiftwidth = 4 }, -- go 官方使用 tab
  make = { expandtab = false, tabstop = 4, shiftwidth = 4 },
  lua = { expandtab = true, tabstop = 2, shiftwidth = 2 }, -- neovim 生态约定 2 空格
  json = { expandtab = true, tabstop = 2, shiftwidth = 2 },
  yaml = { expandtab = true, tabstop = 2, shiftwidth = 2 },
  toml = { expandtab = true, tabstop = 2, shiftwidth = 2 },
  markdown = { expandtab = true, tabstop = 2, shiftwidth = 2 },
  terraform = { expandtab = true, tabstop = 2, shiftwidth = 2 },
  nginx = { expandtab = true, tabstop = 4, shiftwidth = 4 },
}

vim.api.nvim_create_autocmd("FileType", {
  group = aug,
  callback = function(event)
    local ft = vim.bo[event.buf].filetype
    local opts = indent[ft]
    if opts then
      for k, v in pairs(opts) do
        vim.bo[event.buf][k] = v
      end
    end
    -- 代码类文件显示 100 列参考线
    if vim.tbl_contains({ "c", "cpp", "lua", "python", "go", "rust", "sh", "bash" }, ft) then
      vim.opt_local.colorcolumn = "100"
    end
  end,
  desc = "按文件类型调整缩进",
})
