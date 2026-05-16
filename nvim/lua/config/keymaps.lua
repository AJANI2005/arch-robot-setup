-- keymap helpers
local function nmap(lhs, rhs, description, opts)
	opts = opts or {}
	opts.desc = description
	vim.keymap.set("n", lhs, rhs, opts)
end

local function vmap(lhs, rhs, description, opts)
	opts = opts or {}
	opts.desc = description
	vim.keymap.set("v", lhs, rhs, opts)
end

-- wrapped navigation
nmap("j", function()
	return vim.v.count == 0 and "gj" or "j"
end, "Down (wrap-aware)", { expr = true, silent = true })

nmap("k", function()
	return vim.v.count == 0 and "gk" or "k"
end, "Up (wrap-aware)", { expr = true, silent = true })

-- search + scroll centering
nmap("n", "nzzzv", "Next search result (centered)")
nmap("N", "Nzzzv", "Previous search result (centered)")
nmap("<C-d>", "<C-d>zz", "Half page down (centered)")
nmap("<C-u>", "<C-u>zz", "Half page up (centered)")

-- file ops
nmap("<leader>pv", ":Ex<CR>", "NetRW")
nmap("<leader>sx", ":source %<CR>", "Source current file")
nmap("<leader>cd", ":cd %:h<CR>", "Change directory to current buffer parent")

-- window navigation
nmap("<C-h>", "<C-w>h", "Move to left window")
nmap("<C-j>", "<C-w>j", "Move to bottom window")
nmap("<C-k>", "<C-w>k", "Move to top window")
nmap("<C-l>", "<C-w>l", "Move to right window")

-- splits + resize
nmap("<leader>sv", ":vsplit<CR>", "Split vertically")
nmap("<leader>sh", ":split<CR>", "Split horizontally")
nmap("<C-Up>", ":resize +2<CR>", "Increase height")
nmap("<C-Down>", ":resize -2<CR>", "Decrease height")
nmap("<C-Left>", ":vertical resize -2<CR>", "Decrease width")
nmap("<C-Right>", ":vertical resize +2<CR>", "Increase width")

-- move lines
nmap("<A-j>", ":m .+1<CR>==", "Move line down")
nmap("<A-k>", ":m .-2<CR>==", "Move line up")

vmap("<A-j>", ":m '>+1<CR>gv=gv", "Move selection down")
vmap("<A-k>", ":m '<-2<CR>gv=gv", "Move selection up")

-- indentation
vmap("<", "<gv", "Indent left")
vmap(">", ">gv", "Indent right")

-- misc
nmap("<Esc><Esc>", ":nohlsearch<CR>", "Clear highlights")

nmap("<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, "Copy file path")

nmap("<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, "Toggle diagnostics")
