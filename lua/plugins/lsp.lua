-- LSP 配置。安装由 mason.lua 负责，这里只负责：
--   1. 注入 blink.cmp 的补全 capabilities
--   2. 各 server 的专属设置
--   3. 诊断显示方式与 LSP 键位
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim" },
    { "saghen/blink.cmp" },
  },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- 全局默认：所有 server 共用
    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    -- ===== 各语言 server 的专属设置 =====
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          hint = { enable = true, arrayIndex = "Disable" },
        },
      },
    })

    vim.lsp.config("basedpyright", {
      settings = {
        basedpyright = {
          analysis = {
            typeCheckingMode = "standard",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "openFilesOnly",
          },
        },
      },
    })

    -- ruff 的 server 设置必须放在 init_options.settings 下（见 lspconfig 的 ruff 文档）
    vim.lsp.config("ruff", {
      init_options = {
        settings = {
          lineLength = 100,
        },
      },
    })

    vim.lsp.config("clangd", {
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=never",
        "--fallback-style=LLVM",
      },
    })

    vim.lsp.config("gopls", {
      settings = {
        gopls = {
          gofumpt = true,
          staticcheck = true,
          usePlaceholders = true,
          completeUnimported = true,
          analyses = { unusedparams = true, shadow = true },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            constantValues = true,
            rangeVariableTypes = true,
          },
        },
      },
    })

    vim.lsp.config("rust_analyzer", {
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = true,
          inlayHints = { bindingModeHints = { enable = false } },
        },
      },
    })

    vim.lsp.config("yamlls", {
      settings = {
        yaml = {
          schemaStore = { enable = true },
          validate = true,
          hover = true,
          completion = true,
        },
      },
    })

    vim.lsp.config("jsonls", {
      settings = {
        json = { validate = { enable = true } },
      },
    })

    vim.lsp.config("ts_ls", {
      settings = {
        typescript = {
          inlayHints = {
            parameterNames = "literals",
            parameterTypes = "literals",
            variableTypes = "literals",
          },
        },
        javascript = {
          inlayHints = {
            parameterNames = "literals",
            parameterTypes = "literals",
            variableTypes = "literals",
          },
        },
      },
    })

    -- taplo 默认会去拉在线 schemastore catalog；本机网络下经常超时，
    -- 导致 initialize 迟迟不返回、LSP 无法挂载。catalogs = {} 关掉在线目录，
    -- schema 校验仍可通过项目内 taplo.toml 或文档内 #:schema 指令使用
    vim.lsp.config("taplo", {
      settings = {
        evenBetterToml = {
          schema = { catalogs = {} },
        },
      },
    })

    -- CMake 用 neocmakelsp（Mason 包名），mason-lspconfig 没有它的映射，
    -- 所以这里手动启用，并先确认可执行文件存在，避免"装了才启用"的启动报错
    if vim.fn.executable("neocmakelsp") == 1 then
      vim.lsp.enable("neocmake")
    end

    -- ===== 诊断显示 =====
    vim.diagnostic.config({
      virtual_text = { spacing = 4, source = "if_many" },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
      },
    })

    -- ===== LSP 键位（仅在挂载了 server 的缓冲区生效）=====
    -- 说明：Nvim 0.11+ 已内置 K / grn / gra / grr / gri / grt / gO / <C-s>，
    -- 这里只补充内置缺失的几个常用入口
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
      callback = function(event)
        local buf = event.buf
        local set = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
        end

        set("n", "gd", vim.lsp.buf.definition, "跳转定义")
        set("n", "gD", vim.lsp.buf.declaration, "跳转声明")
        set("n", "<leader>rn", vim.lsp.buf.rename, "重命名符号")
        set("n", "<leader>ca", vim.lsp.buf.code_action, "代码操作")
        set("v", "<leader>ca", vim.lsp.buf.code_action, "代码操作")

        set("n", "<leader>cd", vim.diagnostic.open_float, "查看当前行诊断")
        set("n", "[d", function()
          vim.diagnostic.jump({ count = -1, wrap = true })
        end, "上一个诊断")
        set("n", "]d", function()
          vim.diagnostic.jump({ count = 1, wrap = true })
        end, "下一个诊断")

        set("n", "<leader>uh", function()
          local bufnr = vim.api.nvim_get_current_buf()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
        end, "切换内联提示")
      end,
      desc = "注册 LSP 缓冲区键位",
    })
  end,
}
