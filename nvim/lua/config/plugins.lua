local gh="https://github.com/"
vim.pack.add({
    -- Which Key cause I forgot?
    gh .. "folke/which-key.nvim",

    -- Colorscheme
    gh .. "folke/tokyonight.nvim",

    -- Lsp Support
    -- * LSP Config (Default Configs)
    gh .. "neovim/nvim-lspconfig",

    -- * Lsp Installer (Autoinstall lsp servers)
    gh .. "mason-org/mason.nvim",

    -- * Lsp Snippets
    gh .. "L3MON4D3/LuaSnip",
    gh .. "rafamadriz/friendly-snippets",

    -- * Lsp Signature (Live function signature hints)
    gh .. "ray-x/lsp_signature.nvim",

    -- Auto pairs and Auto tags
    gh .. "windwp/nvim-autopairs",
    gh .. "windwp/nvim-ts-autotag",

    -- Fuzzy Finder 
    gh .. "ibhagwan/fzf-lua",

    -- Note Taking Support
    -- * Tree Sitter for markdown parsing
    gh .. "nvim-treesitter/nvim-treesitter",
    -- * Markdown Renderer
    gh .. "MeanderingProgrammer/render-markdown.nvim",
    -- * Icons
    gh .. "nvim-tree/nvim-web-devicons",
    -- * Obsidian integration
    gh .. "obsidian-nvim/obsidian.nvim"

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

local function nmap(lhs, rhs, description)
    vim.keymap.set("n", lhs, rhs, {desc=description})
end

-- Keymaps For FZF  
nmap("<leader>ff",fzf.files,"Find Files")
nmap("<leader>fb",fzf.buffers,"Find Buffers")
nmap("<leader>fh",fzf.buffers,"Find History")
nmap("<leader>fg",fzf.live_grep,"Find Grep")
nmap("<leader>fc",function () fzf.files({cwd="~/.config/nvim"}) end,"Find Neovim Config")
nmap("<leader>fn",function () fzf.files({cwd="~/Documents/Vaults/Personal"}) end,"Find Notes")
vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>",
function() fzf.complete_path() end,
{ silent = true, desc = "Fuzzy complete path" })



-- Settings For Obsidian 
require("obsidian").setup{
    ui = { enable = false },
    legacy_commands = false, -- this will be removed in 4.0.0
    workspaces = {
        {
            name = "personal",
            path = "~/Documents/Vaults/Personal",
        }
    },
    attachments = { folder="_attachments" },
    templates = { folder="_templates" },
    note = { template="note" },
    frontmatter = {
        func = function (note)
            local out = { tags = note.tags }
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do
                    out[k] = v
                end
            end
            return out
        end
    }
}
-- Settings For Treesitter + Obsidian
require('nvim-treesitter').install { 'markdown' }

-- Keymaps For Obsidian
nmap("<leader>on",":Obsidian template note<CR>","Insert Obsidian Note Template")
nmap("<leader>ot",":Obsidian template<CR>","Choose Obsidian Template")
nmap("<leader>of",":s/\\(\\d\\{4}-\\d\\{2}-\\d\\{2}_\\)// | s/-/ /g<CR>","Obsidian format title")
vim.keymap.set("v","<leader>oc","c```code\n<C-r>\"```<Esc>", {desc="Obsidian wrap with code block"})


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
        nmap("gra", fzf.lsp_code_actions, "Code action")
        nmap("gri", fzf.lsp_implementations, "Implementation")
        nmap("grr", fzf.lsp_references, "References")
        nmap("grt", fzf.lsp_typedefs, "Type definition")
        nmap("grO", fzf.lsp_document_symbols, "Document symbols")
        nmap("gdd",fzf.lsp_document_diagnostics, "Document Diagnostics")
        nmap("gdw",fzf.lsp_workspace_diagnostics, "Workspace Diagnostics")
    end
})
-- Load VSCode-like Snippets
require("luasnip.loaders.from_vscode").lazy_load()

