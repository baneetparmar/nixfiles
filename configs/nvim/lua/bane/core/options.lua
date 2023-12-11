local opt = vim.opt

-- tab numbers
opt.relativenumber = true
opt.number = true

-- indents and tabs width
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = true

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- curors line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.background = "dark"

-- backspace key
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unamedplus")

-- windows management
opt.splitright = true
opt.splitbelow = true

-- misc
opt.iskeyword:append("-")
