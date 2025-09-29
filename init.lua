vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"
vim.opt.expandtab = false
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.colorcolumn = "70"
vim.opt.softtabstop = 2
vim.g.mapleader = ','
vim.api.nvim_set_option("clipboard", "unnamedplus")
vim.keymap.set('n', '<C-H>', 'db', { noremap = true })
vim.keymap.set('n', '<C-De>', 'dw', { noremap = true })
vim.keymap.set('n', '<C-a>', 'ggVG', { noremap = true })
vim.keymap.set('n', '.e', ':Neotree toggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>qq', ':wqa<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>q!', ':qa!<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<M-Up>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<M-Down>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>r', function()
    vim.cmd("w")
    local runFile = vim.fn.expand("%:t:r")
    vim.cmd("term gpp " .. runFile)
end, { noremap = true })
vim.keymap.set('n', '.rs', function()
    vim.cmd("w")
    local runFile = vim.fn.expand("%:t:r")
    vim.cmd("term gppsound " .. runFile)
end, { noremap = true })
vim.keymap.set('n', '<C-_>', 'gcc', { remap = true })
vim.keymap.set('n', '<leader>s', ':w<CR>', {noremap = true})
vim.keymap.set('i', '<C-H>', '<C-w>', { noremap = true })
vim.keymap.set('i', '<C-Del>', '<C-o>dw', { noremap = true })
vim.keymap.set('i', '<C-a>', '<Esc>ggVG', { noremap = true })
vim.keymap.set('v', '<M-Up>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<M-Down>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '<C-_>', 'gcgv',  { remap = true })
require("config.lazy")
-- require 'nt-cpp-tools'.setup({
--     preview = {
--         quit = 'q', 
--         accept = '<tab>'
--     },
--     header_extension = 'h',
--     source_extension = 'cxx',
--     custom_define_class_function_commands = {
--         TSCppImplWrite = {
--             output_handle = require'nt-cpp-tools.output_handlers'.get_add_to_cpp()
--         }
--     }
-- })
local cmp = require("cmp")
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'path' },
        { name = 'cmdline' },
    },
})
cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    },
})
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--log=verbose",
        "--query-driver=C:/msys64/ucrt64/bin/g++.exe",
    },
    initOptions = {
        fallbackFlags = { "-std=c++20" },
    },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
vim.diagnostic.config({ signs = false })
vim.o.background = "dark"
vim.cmd([[colorscheme vscode]])
vim.cmd([[map q <Nop>]])
vim.cmd([[Cord enable]])
-- vim.cmd([[Neotree show]])
