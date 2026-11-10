return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "查找文件" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "全文搜索" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "切换缓冲区" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "帮助文档" },
    { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "诊断列表" },
    { "<leader>fr", "<cmd>Telescope resume<CR>", desc = "恢复上次搜索" },
    { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "键位列表" },
    { "<leader>fc", "<cmd>Telescope commands<CR>", desc = "命令列表" },
    { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "最近打开的文件" },
  },
  opts = {
    defaults = {
      prompt_prefix = "  ",
      selection_caret = "  ",
      path_display = { "smart" },
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      file_ignore_patterns = { "%.git/", "node_modules/", "%.venv/", "__pycache__/", "%.cache/" },
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
  },
}
