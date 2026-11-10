-- 保存时格式化。优先用专用格式化器，没有时回退到 LSP 自身的格式化能力
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      desc = "格式化缓冲区",
    },
    {
      "<leader>uf",
      function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        vim.notify("保存时自动格式化: " .. (vim.g.disable_autoformat and "关闭" or "开启"))
      end,
      desc = "切换保存自动格式化",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_organize_imports", "ruff_format" },
      go = { "goimports", "gofumpt" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      toml = { "taplo" },
    },

    -- 保存即格式化；格式化器缺失或超时则退回 LSP
    format_on_save = function(bufnr)
      -- 粘贴大段内容时不要因为格式化把光标/内容弄乱
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return nil
      end
      return { timeout_ms = 1000, lsp_format = "fallback" }
    end,

    default_format_opts = { lsp_format = "fallback" },

    -- 让格式化失败时给出提示，而不是静默吞掉
    notify_on_error = true,
    notify_no_formatters = false,
  },
}
