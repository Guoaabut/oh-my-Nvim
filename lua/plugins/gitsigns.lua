return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
      end

      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next")
        end
      end, "下一个改动块")

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end, "上一个改动块")

      map("n", "<leader>gs", gs.stage_hunk, "暂存当前改动块")
      map("n", "<leader>gr", gs.reset_hunk, "撤销当前改动块")
      map("n", "<leader>gp", gs.preview_hunk, "预览当前改动块")
      map("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end, "查看当前行 blame")
      map("n", "<leader>gd", gs.diffthis, "与索引对比")
      map("n", "<leader>gD", function()
        gs.diffthis("~")
      end, "与上次提交对比")
      map("n", "<leader>gt", gs.toggle_current_line_blame, "切换行内 blame")
      map("n", "<leader>gS", gs.stage_buffer, "暂存整个文件")
      map("n", "<leader>gR", gs.reset_buffer, "撤销整个文件改动")
    end,
  },
}
