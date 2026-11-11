# Neovim 配置

基于 **lazy.nvim + Mason + nvim-lspconfig（Nvim 0.11+ 原生 API）** 的个人配置，面向 Lua / Python / C/C++ / Go / Rust / Shell 与常见配置文件的日常开发。

- 目标环境：Neovim **0.12+**（本机 0.12.6），Linux x86_64
- Leader 键：**空格**
- 所有插件版本由 `lazy-lock.json` 锁定

---

## 目录结构

```
~/.config/nvim
├── init.lua                  # 入口：引导 lazy.nvim，加载 config/*，再加载插件
├── lazy-lock.json            # 插件版本锁定
├── .gitignore
└── lua/
    ├── config/
    │   ├── options.lua       # 编辑器选项（界面 / 编辑 / 搜索 / 编码）
    │   ├── keymaps.lua       # 通用键位
    │   ├── autocmds.lua      # 复制高亮、光标位置恢复、分文件类型缩进
    │   └── treesitter_compat.lua  # Neovim 0.12 × nvim-treesitter master 兼容补丁
    └── plugins/              # 每个文件一个插件（或一组相关插件）
        ├── gruvbox.lua       # 主题
        ├── blink.lua         # 补全
        ├── mason.lua         # LSP / 工具安装（唯一事实来源）
        ├── lsp.lua           # LSP 配置、诊断、缓冲区键位
        ├── treesitter.lua    # 语法高亮 / 缩进
        ├── conform.lua       # 保存格式化
        ├── markdown.lua      # Markdown 渲染 / 侧边预览
        ├── telescope.lua     # 查找
        ├── neotree.lua       # 文件树
        ├── lualine.lua       # 状态栏
        ├── gitsigns.lua      # Git 行内提示
        ├── which-key.lua     # 键位提示
        └── editing.lua       # 自动配对 + 注释
```

设计原则：**安装清单只在 `mason.lua`，配置只在 `lsp.lua`**，避免"配置了但没装"导致的启动报错。

---

## 插件与能力

| 类别 | 插件 | 说明 |
| --- | --- | --- |
| 插件管理 | lazy.nvim | 懒加载、版本锁定、缺失自动安装 |
| 补全 | blink.cmp（rust fuzzy） | LSP / 路径 / 片段 / 缓冲区补全，签名帮助、ghost text |
| 主题 | gruvbox.nvim | dark 配色，同步内置终端颜色 |
| LSP 安装 | mason.nvim + mason-lspconfig + mason-tool-installer | 声明式安装 LSP、格式化器、检查器 |
| LSP 客户端 | nvim-lspconfig | `vim.lsp.config` / `vim.lsp.enable` 原生 API |
| 高亮 / 缩进 | nvim-treesitter（master 分支） | 30 种语言 parser，无需 tree-sitter-cli |
| 格式化 | conform.nvim | 保存即格式化，缺格式化器时回退 LSP |
| Markdown | render-markdown.nvim | 标题 / 代码块 / 表格 / 复选框渲染，侧边预览 |
| 查找 | telescope.nvim | 文件、全文、缓冲区、诊断等 |
| 文件树 | neo-tree.nvim | 文件树 + Git 状态面板 |
| 状态栏 | lualine.nvim | 分支、diff、诊断、光标位置 |
| Git | gitsigns.nvim | 行内 diff、hunk 级操作 |
| 键位提示 | which-key.nvim | 前缀分组弹窗 |
| 编辑增强 | nvim-autopairs + Comment.nvim | 自动配对、`gcc` 注释 |

---

## 语言支持

已安装并通过实测（LSP + treesitter 同时生效）：

| 文件类型 | 语言服务 | 格式化 |
| --- | --- | --- |
| Lua / Neovim 配置 | `lua_ls` | `stylua` |
| Python | `basedpyright` + `ruff` | `ruff_organize_imports` + `ruff_format` |
| C / C++ | `clangd`（含 clang-tidy、背景索引） | `clang-format` |
| Go | `gopls`（gofumpt、staticcheck） | `goimports` + `gofumpt` |
| Rust | `rust_analyzer` | — |
| Shell | `bashls` | `shfmt`（检查：`shellcheck`） |
| JSON / YAML / TOML | `jsonls` / `yamlls` / `taplo` | `prettier` / `taplo` |
| Markdown | `marksman` | `prettier` |
| HTML / CSS / JS / TS | `html` / `cssls` / `ts_ls` | `prettier` |
| Docker / Compose | `dockerls` / `docker_compose_language_service` | — |
| Terraform | `terraformls` | — |
| Vimscript | `vimls` | — |
| CMake | `neocmake`（`neocmakelsp`） | — |

---

## 快捷键

### 基础

| 键 | 功能 |
| --- | --- |
| `<leader>w` | 保存 |
| `<leader>q` / `<leader>Q` | 退出窗口 / 强制退出全部 |
| `<Esc>` | 清除搜索高亮 |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | 切到左 / 下 / 上 / 右窗口 |
| `<leader>sv` / `<leader>sh` | 垂直 / 水平分屏 |
| `<S-l>` / `<S-h>` | 下一个 / 上一个缓冲区 |
| `<leader>bd` | 关闭当前缓冲区 |
| `J`（普通模式） | 合并下一行并保持光标位置 |
| `J` / `K`（可视模式） | 下移 / 上移选中行 |
| `<leader>p`（可视模式） | 粘贴且不覆盖寄存器 |
| `<leader>xo` / `<leader>xc` | 打开 / 关闭 quickfix |
| `<Esc><Esc>`（终端模式） | 回到普通模式 |

### 查找（Telescope）

| 键 | 功能 |
| --- | --- |
| `<leader>ff` | 查找文件 |
| `<leader>fg` | 全文搜索（ripgrep） |
| `<leader>fb` | 切换缓冲区 |
| `<leader>fh` | 帮助文档 |
| `<leader>fd` | 诊断列表 |
| `<leader>fr` | 恢复上次搜索 |
| `<leader>fk` / `<leader>fc` | 键位表 / 命令表 |
| `<leader>fo` | 最近打开的文件 |

### 文件树（neo-tree）

| 键 | 功能 |
| --- | --- |
| `<leader>e` | 文件树开关 |
| `<leader>E` | 在文件树中定位当前文件 |
| `<leader>eg` | Git 状态面板 |

### LSP（仅在该缓冲区挂载了语言服务时生效）

| 键 | 功能 |
| --- | --- |
| `gd` / `gD` | 跳转定义 / 声明 |
| `K` | 悬停文档（内置） |
| `grn` / `gra` / `grr` / `gri` / `grt` / `gO` | 重命名 / 代码操作 / 引用 / 实现 / 类型定义 / 文档符号（内置） |
| `<C-s>` | 签名帮助（内置，已接 blink） |
| `<leader>rn` / `<leader>ca` | 重命名 / 代码操作（别名） |
| `<leader>cd` | 当前行诊断浮窗 |
| `[d` / `]d` | 上 / 下一个诊断 |
| `<leader>uh` | 内联提示（inlay hints）开关 |

### 格式化（conform）

| 键 | 功能 |
| --- | --- |
| `<leader>cf` | 格式化当前缓冲区 |
| `<leader>uf` | 切换"保存时自动格式化"（默认开启） |

### Git（gitsigns）

| 键 | 功能 |
| --- | --- |
| `]c` / `[c` | 下一个 / 上一个改动块 |
| `<leader>gs` / `<leader>gr` | 暂存 / 撤销当前 hunk |
| `<leader>gp` | 预览当前 hunk |
| `<leader>gb` / `<leader>gt` | 完整 blame / 行内 blame 开关 |
| `<leader>gd` / `<leader>gD` | 与索引对比 / 与上次提交对比 |
| `<leader>gS` / `<leader>gR` | 暂存 / 撤销整个文件 |

### 编辑

| 键 | 功能 |
| --- | --- |
| `gcc` / `gbc` | 注释当前行 / 块注释（`gc` 配合动作更通用） |
| 自动 | 括号、引号成对补全（基于 treesitter 判断上下文） |

### Markdown（render-markdown）

| 键 | 功能 |
| --- | --- |
| `<leader>mp` | 侧边预览渲染结果 |
| `<leader>mt` | 渲染开关 |

也可以直接用 `:RenderMarkdown enable` / `disable` / `toggle` / `preview`。

---

## 行为设置

**界面**
- 行号 + 相对行号，光标行高亮
- 常驻 `signcolumn`（避免诊断/Git 符号出现时整行抖动）
- 不自动换行，`scrolloff=8`
- 垂直分屏在右、水平分屏在下
- 浮动窗口统一圆角（`winborder`）
- 全局状态栏（`laststatus=3`）

**编辑**
- 全局 4 空格缩进；Go / Make 使用 tab；Lua / JSON / YAML / TOML / Markdown / Terraform 使用 2 空格
- 代码类文件显示 100 列参考线
- 持久化撤销（`undofile`，目录在 `stdpath("state")/undo`）
- 不生成 swap / backup 文件
- 系统剪贴板互通（Wayland 使用 `wl-copy`）
- `updatetime=250`、`timeoutlen=300`，键位响应更快
- 搜索忽略大小写但智能区分（`smartcase`）

**自动命令**
- 复制时短暂高亮选区
- 重新打开文件时恢复上次光标位置
- 窗口尺寸变化后自动均分

**诊断**
- 行尾虚拟文本（多来源时显示来源）、signs、下划线
- 插入模式不更新诊断、按严重级别排序、浮窗圆角

---

## 安装与部署

首次在新机器上使用：

```bash
git clone <this-repo> ~/.config/nvim
nvim --headless "+Lazy! sync" +qa      # 安装插件（含 treesitter 编译，需几分钟）
nvim                                    # 首次启动会触发 Mason 安装 server
```

进入 Neovim 后用 `:Mason` 查看安装进度，`<leader>ff` 开始找文件。

首次启动会安装 20 个语言服务与 9 个工具，视网络情况需要数分钟。

---

## 已知限制

| 项 | 说明 |
| --- | --- |
| `nginx-language-server` | 上游要求 Python `<3.14`，本机为 3.14.8，无法安装；nginx 配置仍有 treesitter 高亮 |
| `cmake-language-server` | 同上，改用纯二进制的 `neocmakelsp`（`neocmake`） |
| taplo 启动日志 | 会尝试拉取在线 schemastore catalog，网络受限时打印一条 WARN 后回退，不影响挂载 |
| Go 工具安装 | `proxy.golang.org` 不可达，重装 go 工具需 `GOPROXY=https://goproxy.cn,direct` |
| `nvim-treesitter` | 使用 `master` 分支（免 `tree-sitter-cli`）；若后续安装 CLI >= 0.26.1，可迁移到 `main` 分支 |
| Neovim 0.12 兼容 | 0.12 的 `iter_matches()` 改为返回节点列表，`master` 分支的自定义 directive 会报 `range` 错误；已由 `config/treesitter_compat.lua` 重新注册 `set-lang-*!` / `downcase!` 修复 |
| Markdown 图标 | 默认标题 / 复选框图标与代码块语言图标需要 Nerd Font；未装 `nvim-web-devicons` 时语言图标退化为文本 |

---

## 维护速查

| 操作 | 命令 |
| --- | --- |
| 更新插件 | `:Lazy update`（会更新 `lazy-lock.json`） |
| 查看插件状态 | `:Lazy` |
| 安装 / 卸载语言服务 | 编辑 `lua/plugins/mason.lua` 后重启，或 `:LspInstall` / `:Mason` |
| 查看 LSP 状态 | `:checkhealth lsp`、`:LspInfo` |
| 查看格式化器状态 | `:ConformInfo` |
| 查看当前生效键位 | `<leader>fk` |
