return {
  -- 自动配对括号/引号
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- 借助 treesitter 判断上下文，避免在字符串/注释里乱配对
      fast_wrap = {},
    },
  },

  -- 注释：gcc / gc（可视模式）等
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
