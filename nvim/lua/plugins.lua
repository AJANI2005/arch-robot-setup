-- Plugins
-- Update : vim.pack.update()
-- Delete : 1. Remove plugin from above, 2. call vim.pack.del({ "plugin" })
-- .local/share/nvim/site/pack/core/opt

vim.pack.add({
  -- File Explorer
  "https://www.github.com/nvim-tree/nvim-tree.lua",

  -- Random Plugins
  "https://www.github.com/nvim-mini/mini.nvim",

  -- Fuzzy Finder
  "https://www.github.com/ibhagwan/fzf-lua",

  -- LSP
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",

  -- Autocompete
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/Saghen/blink.cmp",
  "https://github.com/saghen/blink.lib",
})


-- FZF (GLOBAL)
local fzf = require("fzf-lua")
fzf.setup({})

vim.keymap.set("n", "<leader>ff", function() fzf.files() end, { desc = "FZF Files" })
vim.keymap.set("n", "<leader>fg", function() fzf.live_grep() end, { desc = "FZF Live Grep" })
vim.keymap.set("n", "<leader>fb", function() fzf.buffers() end, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", function() fzf.help_tags() end, { desc = "FZF Help Tags" })
vim.keymap.set("n", "<leader>fx", function() fzf.diagnostics_document() end, { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fX", function() fzf.diagnostics_workspace() end, { desc = "FZF Diagnostics Workspace" })

vim.keymap.set("n", "<leader>fd", function()
  fzf.lsp_definitions({ jump1 = true })
end, { desc = "FZF Definitions" })
vim.keymap.set("n", "<leader>fr", function() fzf.lsp_references() end, { desc = "FZF References" })
vim.keymap.set("n", "<leader>ft", function() fzf.lsp_typedefs() end, { desc = "FZF TypeDefs" })
vim.keymap.set("n", "<leader>fs", function() fzf.lsp_document_symbols() end, { desc = "FZF Document Symbols" })
vim.keymap.set("n", "<leader>fw", function() fzf.lsp_workspace_symbols() end, { desc = "FZF Workspace Symbols" })
vim.keymap.set("n", "<leader>fi", function() fzf.lsp_implementations() end, { desc = "FZF Implementations" })


-- MINI
vim.cmd.colorscheme("miniautumn") ---Theme

require("mini.pairs").setup({})
require("mini.icons").setup({})

local miniclue = require("mini.clue")
miniclue.setup({
  triggers = {
    { mode = { "n", "x" }, keys = "<Leader>" },
    { mode = "n", keys = "g" },
    { mode = "n", keys = "z" },
  },
  clues = {
    -- miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})


-- Nvim Tree
require("nvim-tree").setup({})

vim.keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle NvimTree" })


-- LSP CONFIG
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = { "lua_ls", "stylua", "pyright" }
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim", "require" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    },
  },
})


local augroup = vim.api.nvim_create_augroup

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp-attach", { clear = true }),
  callback = function(e)
    local map = function(keys, fn, desc, mode)
      vim.keymap.set(mode or "n", keys, fn, {
        buffer = e.buf,
        desc = "LSP: " .. desc,
      })
    end

    -- LSP core mappings (buffer-local only)
    map("K", vim.lsp.buf.hover, "hover")
    map("gd", vim.lsp.buf.definition, "definition")
    map("gD", vim.lsp.buf.declaration, "declaration")
    map("grn", vim.lsp.buf.rename, "rename")
    map("gca", vim.lsp.buf.code_action, "code action", { "n", "x" })

    map("gS", function()
      vim.cmd("vsplit")
      vim.lsp.buf.definition()
    end, "split definition")

    local client = vim.lsp.get_client_by_id(e.data.client_id)
    if not client then return end

    -- highlight references
    if client:supports_method("textDocument/documentHighlight", e.buf) then
      local g = augroup("lsp-highlight", {})
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = e.buf,
        group = g,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = e.buf,
        group = g,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd("LspDetach", {
        group = augroup("lsp-detach", { clear = true }),
        callback = function(ev)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = g, buffer = ev.buf })
        end,
      })
    end

    -- inlay hints
    if client:supports_method("textDocument/inlayHint", e.buf) then
      map("<leader>th", function()
        local ih = vim.lsp.inlay_hint
        ih.enable(not ih.is_enabled({ bufnr = e.buf }))
      end, "inlay hints")
    end
  end,
})


-- Diagnostics
vim.keymap.set("n", "<leader>q", function()
  vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })

vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
  float = {
    border = "rounded",
    source = true,
    style = "minimal",
    focusable = false,
  },
})


-- Completion
require("luasnip.loaders.from_vscode").lazy_load()

require("blink.cmp").setup({
  signature = { enabled = true },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    },
    menu = {
      auto_show = true,
    },
  },
})
