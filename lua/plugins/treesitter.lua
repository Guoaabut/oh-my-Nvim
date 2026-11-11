-- 语法高亮 / 缩进使用 treesitter
--
-- 这里刻意使用 master 分支：main 分支要求系统里额外安装 tree-sitter-cli（>= 0.26.1，
-- 且不能来自 npm），而 master 分支只需 gcc 即可用仓库自带的 parser.c 编译。
-- 若以后装了 tree-sitter-cli，可改为 branch = "main" 并使用新的 setup 方式。
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false, -- 该插件不支持懒加载（高亮需要随文件打开生效）
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        -- 基础
        "c",
        "cpp",
        "lua",
        "luadoc",
        "vim",
        "vimdoc",
        "query",
        "bash",
        "make",
        "cmake",

        -- 文档与配置
        "markdown",
        "markdown_inline",
        "json",
        "yaml",
        "toml",
        "html",
        "css",
        "regex",
        "diff",
        "gitcommit",

        -- 常用语言
        "python",
        "go",
        "rust",
        "javascript",
        "typescript",
        "tsx",
        "dockerfile",
        "terraform",
        "nginx",
        "sql",
      },

      auto_install = false, -- 不在打开新文件时静默联网安装

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
        -- 这两个语言的 treesitter 缩进反而更容易出错，交回 Vim 原生逻辑
        disable = { "python", "yaml" },
      },

      incremental_selection = { enable = true },
    })

    -- Neovim 0.12 的 iter_matches() 返回节点列表，修补 nvim-treesitter master
    -- 里仍按单个节点处理的 directive（详见 compat 文件注释）
    require("config.treesitter_compat").setup()
  end,
}
