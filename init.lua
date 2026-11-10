-- ~/.config/nvim/init.lua
-- 入口：引导 lazy.nvim，加载基础配置，再加载插件

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- 基础配置（选项 / 键位 / 自动命令），必须在插件之前加载，
-- 这样 leader 键和编辑行为在任何插件注册键位前就已生效
require("config.options")
require("config.keymaps")
require("config.autocmds")

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  -- 首次安装插件时用 gruvbox 占位，避免白屏闪烁
  install = { colorscheme = { "gruvbox" } },
  checker = { enabled = false },
  change_detection = { notify = false },
  ui = { border = "rounded" },
  performance = {
    rtp = {
      -- 关掉用不到的内置插件，略微加快启动
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})
