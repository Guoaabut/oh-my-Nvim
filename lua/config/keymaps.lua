-- 通用键位（LSP / 插件相关的键位在各插件配置里定义）
local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- ===== 保存 / 退出 =====
map("n", "<leader>w", "<cmd>write<CR>", "保存")
map("n", "<leader>q", "<cmd>quit<CR>", "退出当前窗口")
map("n", "<leader>Q", "<cmd>quitall!<CR>", "强制退出全部")

-- ===== 窗口切换 =====
map("n", "<C-h>", "<C-w>h", "切换到左侧窗口")
map("n", "<C-j>", "<C-w>j", "切换到下方窗口")
map("n", "<C-k>", "<C-w>k", "切换到上方窗口")
map("n", "<C-l>", "<C-w>l", "切换到右侧窗口")
map("n", "<leader>sv", "<C-w>v", "垂直分屏")
map("n", "<leader>sh", "<C-w>s", "水平分屏")

-- ===== 缓冲区 =====
map("n", "<S-l>", "<cmd>bnext<CR>", "下一个缓冲区")
map("n", "<S-h>", "<cmd>bprevious<CR>", "上一个缓冲区")
map("n", "<leader>bd", "<cmd>bdelete<CR>", "关闭当前缓冲区")

-- ===== 移动与滚动 =====
map("n", "<C-d>", "<C-d>zz", "向下翻页并居中")
map("n", "<C-u>", "<C-u>zz", "向上翻页并居中")
map("n", "n", "nzzzv", "下一个匹配并居中")
map("n", "N", "Nzzzv", "上一个匹配并居中")
map("n", "J", "mzJ`z", "合并下一行并保持光标位置")
map("v", "J", ":m '>+1<CR>gv=gv", "下移选中行")
map("v", "K", ":m '<-2<CR>gv=gv", "上移选中行")

-- 可视模式粘贴：不覆盖当前寄存器内容
map("x", "<leader>p", '"_dP', "粘贴并保留寄存器")

-- ===== 搜索高亮 =====
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "清除搜索高亮")

-- ===== quickfix =====
map("n", "<leader>xo", "<cmd>copen<CR>", "打开 quickfix")
map("n", "<leader>xc", "<cmd>cclose<CR>", "关闭 quickfix")

-- ===== 终端 =====
map("t", "<Esc><Esc>", "<C-\\><C-n>", "从终端模式回到普通模式")
