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

-- better movement in wrapped text
nmap("j", function()
	return vim.v.count == 0 and "gj" or "j"
end, "Down (wrap-aware)", { expr = true, silent = true })

nmap("k", function()
	return vim.v.count == 0 and "gk" or "k"
end, "Up (wrap-aware)", { expr = true, silent = true })

nmap("<leader>pv", ":Ex<CR>", "NetRW")
nmap("<leader>sx", ":source %<CR>", "Source current file")

nmap("n", "nzzzv", "Next search result (centered)")
nmap("N", "Nzzzv", "Previous search result (centered)")
nmap("<C-d>", "<C-d>zz", "Half page down (centered)")
nmap("<C-u>", "<C-u>zz", "Half page up (centered)")

nmap("<Esc><Esc>", ":nohlsearch<CR>", "Clear search highlights")

nmap("<C-h>", "<C-w>h", "Move to left window")
nmap("<C-j>", "<C-w>j", "Move to bottom window")
nmap("<C-k>", "<C-w>k", "Move to top window")
nmap("<C-l>", "<C-w>l", "Move to right window")

nmap("<leader>sv", ":vsplit<CR>", "Split window vertically")
nmap("<leader>sh", ":split<CR>", "Split window horizontally")
nmap("<C-Up>", ":resize +2<CR>", "Increase window height")
nmap("<C-Down>", ":resize -2<CR>", "Decrease window height")
nmap("<C-Left>", ":vertical resize -2<CR>", "Decrease window width")
nmap("<C-Right>", ":vertical resize +2<CR>", "Increase window width")

nmap("<A-j>", ":m .+1<CR>==", "Move line down")
nmap("<A-k>", ":m .-2<CR>==", "Move line up")

vmap("<A-j>", ":m '>+1<CR>gv=gv", "Move selection down")
vmap("<A-k>", ":m '<-2<CR>gv=gv", "Move selection up")

vmap("<", "<gv", "Indent left and reselect")
vmap(">", ">gv", "Indent right and reselect")

nmap("<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, "Copy full file path")

nmap("<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, "Toggle diagnostics")
