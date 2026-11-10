return {
  "saghen/blink.cmp",
  -- 锁定 v1 系列。预编译的 fuzzy 二进制与该 tag 对应，避免 :Lazy update 后
  -- 悄悄跳到不兼容版本
  version = "*",
  -- 刻意不做 event 懒加载：LSP 的 capabilities 必须在 server 启动前注册，
  -- 而 get_lsp_capabilities() 会加载本插件，懒加载只会带来时序问题
  dependencies = {
    "saghen/blink.lib",
    "rafamadriz/friendly-snippets",
  },

  opts_extend = { "sources.default" },

  opts = {
    keymap = { preset = "default" },

    appearance = { nerd_font_variant = "mono" },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = "rounded" },
      },
      menu = {
        border = "rounded",
        draw = { treesitter = { "lsp" } },
      },
      ghost_text = { enabled = true },
    },

    signature = {
      enabled = true,
      window = { border = "rounded" },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    fuzzy = { implementation = "rust" },
  },
}
