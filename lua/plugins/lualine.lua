return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      theme = "auto",
      globalstatus = true,
      section_separators = "",
      component_separators = "|",
      disabled_filetypes = { statusline = { "alpha", "dashboard" } },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "filetype", "encoding" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
}
