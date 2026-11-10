return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "文件树开关" },
    { "<leader>E", "<cmd>Neotree reveal<CR>", desc = "在文件树中定位当前文件" },
    {
      "<leader>eg",
      function()
        require("neo-tree.command").execute({ source = "git_status", toggle = true })
      end,
      desc = "Git 状态面板",
    },
  },
  opts = {
    filesystem = {
      follow_current_file = { enabled = true },
      hijack_netrw_behavior = "open_default",
      use_libuv_file_watcher = true,
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = true,
      },
    },
    window = {
      width = 32,
      mappings = {
        ["<space>"] = "none", -- 避免空格键误触
      },
    },
  },
}
