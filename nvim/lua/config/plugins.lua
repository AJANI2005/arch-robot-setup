local gh="https://github.com/"
vim.pack.add({
    -- Which Key cause I forgot?
    gh .. "folke/which-key.nvim",

    -- Colorscheme
    gh .. "folke/tokyonight.nvim",

    -- Lsp Configs
    gh .. "neovim/nvim-lspconfig",

    -- Lsp Installer
    gh .. "mason-org/mason.nvim",

    -- Lsp Snippets
    gh .. "L3MON4D3/LuaSnip",
    gh .. "rafamadriz/friendly-snippets",

    -- Lsp Signature
    gh .. "ray-x/lsp_signature.nvim",

    -- Auto pairs and Auto tags
    gh .. "windwp/nvim-autopairs",
    gh .. "windwp/nvim-ts-autotag",

    -- Fuzzy Finder 
    gh .. "ibhagwan/fzf-lua"

})


-- Settings For Tokyonight
require("tokyonight").setup({ transparent=true })
vim.cmd("colorscheme tokyonight")

-- Settings For Auto(pairs|tags)
require("nvim-autopairs").setup {}
require("nvim-ts-autotag").setup {}

-- Settings For FZF
local fzf = require("fzf-lua")
fzf.setup {}

local function map(lhs, rhs, description)
    vim.keymap.set("n", lhs, rhs, {desc=description})
end
-- Keymaps For FZF  
map("ff",fzf.files,"Find Files")
map("fb",fzf.buffers,"Find Buffers")
map("fh",fzf.buffers,"Find History")
map("fg",fzf.live_grep,"Find Grep")

-- Settings For LSP 
require("mason").setup()

-- Configure LSP
local lspconfigs=require("config.lspconfigs")
vim.lsp.config("lua_ls",lspconfigs.lua_ls)
vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("ts_ls")

-- On Attach LSP Settings
vim.api.nvim_create_autocmd("LspAttach", {
    group=vim.api.nvim_create_augroup("my.lsp",{}),
    callback=function(ev)

        -- Function Signature Hints
        require("lsp_signature").on_attach({},ev.buf)

        -- Inlay Hints
        vim.keymap.set('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = '[T]oggle Inlay [H]ints' })

        -- -- Keymaps
        map("gra", fzf.lsp_code_actions, "Code action")
        map("gri", fzf.lsp_implementations, "Implementation")
        map("grr", fzf.lsp_references, "References")
        map("grt", fzf.lsp_typedefs, "Type definition")
        map("grO", fzf.lsp_document_symbols, "Document symbols")
        map("gdd",fzf.lsp_document_diagnostics, "Document Diagnostics")
        map("gdw",fzf.lsp_workspace_diagnostics, "Workspace Diagnostics")
    end
})
-- Load VSCode-like Snippets
require("luasnip.loaders.from_vscode").lazy_load()

