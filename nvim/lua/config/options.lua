-- Options for NEOVIM
vim.g.mapleader=" " -- <leader>
vim.g.maplocalleader="\\"  -- <localleader>

-- Colorscheme

vim.opt.termguicolors=true

vim.opt.autocomplete=true -- Show Completion Menu as I type
vim.opt.autocompletetimeout=80

vim.opt.complete=".,o"
vim.opt.completeopt={"fuzzy", "nosort", "menu", "popup","noselect"}


vim.opt.clipboard={"unnamedplus"} -- Sync with System Clipboard
vim.opt.expandtab=true -- tabs as spaces
vim.opt.tabstop=4
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.smartindent=true

vim.opt.relativenumber=true -- Line numbers

vim.opt.splitbelow=true 
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50


































