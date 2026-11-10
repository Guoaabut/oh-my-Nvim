return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    -- 不依赖 nerd font，用纯文本
    icons = { mappings = false },
    win = { border = "rounded" },
    spec = {
      { "<leader>b", group = "缓冲区" },
      { "<leader>c", group = "代码" },
      { "<leader>f", group = "查找" },
      { "<leader>g", group = "Git" },
      { "<leader>s", group = "窗口/分屏" },
      { "<leader>u", group = "界面开关" },
      { "<leader>x", group = "quickfix" },
    },
  },
}
