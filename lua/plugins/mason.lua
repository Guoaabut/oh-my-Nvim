-- Mason：LSP / 格式化器 / 静态检查器的实际安装端
-- 注意：这里声明的清单才是"唯一事实来源"，lsp.lua 只负责配置，不负责安装

-- 通过 mason-lspconfig 安装的 LSP（名字为 lspconfig 的 server 名）
local servers = {
  -- 配置与脚本
  "lua_ls", -- Lua / Neovim 配置
  "vimls", -- Vimscript
  "bashls", -- Shell
  "jsonls", -- JSON
  "yamlls", -- YAML
  "taplo", -- TOML
  "marksman", -- Markdown

  -- 前端 / 容器 / 基础设施
  "html",
  "cssls",
  "ts_ls", -- JavaScript / TypeScript
  "dockerls", -- Dockerfile
  "docker_compose_language_service",
  "terraformls",

  -- 编程语言
  "basedpyright", -- Python（无需 Node.js，比 pyright 省事）
  "ruff", -- Python lint + format + import 排序
  "clangd", -- C / C++
  "gopls", -- Go
  "rust_analyzer", -- Rust
}
-- 说明：cmake-language-server 与 nginx-language-server 均为 Python 包，上游要求
-- Python < 3.14，而本机只有 3.14.8，Mason 无法安装，故改用 neocmakelsp（见 tools）
-- 与 treesitter 的 nginx 语法高亮。

-- 通过 mason-tool-installer 安装的格式化器 / 检查器
local tools = {
  "stylua", -- lua
  "ruff", -- python（同时作为 LSP，重复声明是安全的）
  "gofumpt", -- go
  "goimports", -- go import 整理
  "clang-format", -- c / cpp
  "shfmt", -- shell
  "shellcheck", -- shell 静态检查
  "prettier", -- json / yaml / markdown / html / css / js / ts
  "taplo", -- toml
  "neocmakelsp", -- cmake（纯二进制，不受 Python 版本限制）
}

return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim" },
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      ensure_installed = servers,
      -- 只对"Mason 已安装"的 server 调用 vim.lsp.enable()。
      -- 这样既不会出现"配置了但没装"的启动报错，也不会漏启用新装好的 server
      -- exclude: stylua 作为格式化器安装，但新版 lspconfig 把它也登记成了 LSP
      -- （stylua --lsp），auto-enable 会额外挂一个冗余 client，这里排除
      automatic_enable = { exclude = { "stylua" } },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { { "mason-org/mason.nvim" } },
    opts = {
      ensure_installed = tools,
      run_on_start = true,
      auto_update = false,
    },
  },
}
