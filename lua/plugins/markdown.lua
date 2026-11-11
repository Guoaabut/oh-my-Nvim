-- Markdown 渲染 / 预览
--
-- render-markdown.nvim 直接在缓冲区里渲染标题、代码块、表格、复选框、callout 等，
-- 并提供 :RenderMarkdown preview 侧边预览，不依赖浏览器或 Node。
--
-- 这里刻意不懒加载：插件按 ft/cmd 懒加载时会跳过"首次触发 FileType 的那个缓冲区"
-- （见插件 core/manager.lua 的 lazy 判断），导致打开的第一个 Markdown 文件不渲染。
return {
  "MeanderingProgrammer/render-markdown.nvim",
  lazy = false,
  dependencies = { "nvim-treesitter/nvim-treesitter" },

  config = function(_, opts)
    require("render-markdown").setup(opts)

    vim.keymap.set("n", "<leader>mp", "<cmd>RenderMarkdown preview<CR>", { silent = true, desc = "侧边预览渲染结果" })
    vim.keymap.set("n", "<leader>mt", "<cmd>RenderMarkdown toggle<CR>", { silent = true, desc = "渲染开关" })
  end,

  opts = {
    -- 复用 blink.cmp 的 LSP 能力，补全 [x] 复选框和 [!NOTE] callout
    completions = { lsp = { enabled = true } },

    -- 没装 latex parser / pylatexenc / utftex，关掉公式渲染避免 checkhealth 警告
    latex = { enabled = false },

    -- signcolumn 留给诊断和 gitsigns，不显示标题等级标记
    heading = { sign = false },

    -- 说明：标题、复选框、callout 的默认图标来自 Nerd Font。
    -- 如果终端里显示成方块/问号，把对应 icons 换成纯文本即可，例如：
    --   heading = { icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " } },
    --   checkbox = { unchecked = { icon = "[ ] " }, checked = { icon = "[x] " } },
  },
}
