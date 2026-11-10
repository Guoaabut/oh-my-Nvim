return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000, -- 确保主题在其他插件之前加载，避免启动闪白
  lazy = false,
  config = function()
    require("gruvbox").setup({
      terminal_colors = true, -- 同步内置终端颜色
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      contrast = "", -- "hard" / "soft" / ""（默认）
      transparent_mode = false, -- 需要透明背景时改为 true
    })

    vim.o.background = "dark"
    vim.cmd.colorscheme("gruvbox")
  end,
}
