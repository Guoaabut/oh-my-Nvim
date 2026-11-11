-- nvim-treesitter(master) 与 Neovim 0.12 的兼容补丁
--
-- Neovim 0.12 起 Query:iter_matches() 返回的 match 是 table<capture_id, TSNode[]>，
-- 每个 capture 变成了“节点列表”；而已经归档的 nvim-treesitter master 里自定义的
-- directive 仍按单个 TSNode 处理，调用 node:range() 时会报：
--   attempt to call method 'range' (a nil value)
-- 典型触发场景：Markdown 代码块注入（#set-lang-from-info-string!）。
--
-- 这里用与上游相同的逻辑重新注册这几个 directive，同时兼容“单个节点”和
-- “节点列表”两种格式。迁移到 nvim-treesitter main 分支后即可删除本文件。
local M = {}

local function capture_node(match, id)
  local capture = match[id]
  if type(capture) == "table" then
    return capture[1]
  end
  return capture
end

local info_string_aliases = {
  ex = "elixir",
  pl = "perl",
  sh = "bash",
  uxn = "uxntal",
  ts = "typescript",
}

local mimetype_languages = {
  importmap = "json",
  module = "javascript",
  ["application/ecmascript"] = "javascript",
  ["text/ecmascript"] = "javascript",
}

function M.setup()
  local query = vim.treesitter.query

  -- 先确保 nvim-treesitter 的原始 directive 已注册，再用 force 覆盖
  pcall(require, "nvim-treesitter.query_predicates")

  -- Markdown / Hurl 的代码块语言：```lua
  query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
    local node = capture_node(match, pred[2])
    if not node then
      return
    end
    local alias = vim.treesitter.get_node_text(node, bufnr):lower()
    metadata["injection.language"] = vim.filetype.match({ filename = "a." .. alias })
      or info_string_aliases[alias]
      or alias
  end, { force = true })

  -- HTML <script type="...">
  query.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
    local node = capture_node(match, pred[2])
    if not node then
      return
    end
    local mimetype = vim.treesitter.get_node_text(node, bufnr)
    local language = mimetype_languages[mimetype]
    if not language then
      local parts = vim.split(mimetype, "/", {})
      language = parts[#parts]
    end
    metadata["injection.language"] = language
  end, { force = true })

  -- bash / hcl / php / ruby 的注入语言转小写
  query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
    local id = pred[2]
    local node = capture_node(match, id)
    if not node then
      return
    end
    local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
    if not metadata[id] then
      metadata[id] = {}
    end
    metadata[id].text = text:lower()
  end, { force = true })
end

return M
