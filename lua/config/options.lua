-- 基础编辑器选项
local opt = vim.opt
local fn = vim.fn

-- ===== 领导键（必须在插件注册键位之前设置）=====
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- ===== 界面 =====
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes" -- 常驻，避免诊断/版本控制符号出现时整行左右抖动
opt.wrap = false
opt.linebreak = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitright = true
opt.splitbelow = true
opt.termguicolors = true
opt.winborder = "rounded" -- Nvim 0.11+：所有浮动窗口默认圆角
opt.showmode = false -- 状态栏插件/原生已显示模式，去掉重复提示
opt.pumheight = 12
opt.laststatus = 3 -- 全局状态栏，多窗口不重复
opt.mouse = "a"

-- ===== 编辑行为 =====
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true -- 缩进按 shiftwidth 的整数倍对齐
opt.autoindent = true
opt.smartindent = true
opt.undofile = true -- 关闭文件后仍可撤销
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.updatetime = 250 -- 诊断/悬停响应更快
opt.timeoutlen = 300
opt.confirm = true -- 有未保存修改时问一句，而不是直接报错
opt.clipboard = "unnamedplus" -- 与系统剪贴板（Wayland 的 wl-copy）互通
opt.virtualedit = "block" -- 可视块模式可以移动到行尾之外

-- ===== 搜索 =====
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- ===== 编码 =====
opt.fileencoding = "utf-8"

-- ===== 撤销目录（不存在时自动创建）=====
local undodir = fn.stdpath("state") .. "/undo"
if fn.isdirectory(undodir) == 0 then
  fn.mkdir(undodir, "p")
end
opt.undodir = undodir

-- 终端里 Ctrl+h/j/k/l 在部分环境下会被吞掉，这里让箭头/BS 更好用
opt.whichwrap:append("<,>,[,]")
