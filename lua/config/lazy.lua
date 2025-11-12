-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo(
            {
                {"Failed to clone lazy.nvim:\n", "ErrorMsg"},
                {out, "WarningMsg"},
                {"\nPress any key to exit..."}
            },
            true,
            {}
        )
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup(
    {
        spec = {
            -- import your plugins
            {"Mofiqul/vscode.nvim", priority = 1000, config = true, opts = ...},
            {
                "nvim-neo-tree/neo-tree.nvim",
                branch = "v3.x",
                dependencies = {
                    "nvim-lua/plenary.nvim",
                    "nvim-tree/nvim-web-devicons",
                    "MunifTanjim/nui.nvim"
                },
                lazy = false,
                ---@module "neo-tree"
                ---@type neotree.Config?
                opts = {}
            },
            {
                "hrsh7th/nvim-cmp",
                dependencies = {
                    "L3MON4D3/LuaSnip",
                    "saadparwaiz1/cmp_luasnip",
                    "hrsh7th/cmp-nvim-lsp",
                    "hrsh7th/cmp-buffer",
                    "hrsh7th/cmp-path",
                    "hrsh7th/cmp-cmdline",
                    "L3MON4D3/LuaSnip",
                    "saadparwaiz1/cmp_luasnip"
                },
                config = function()
                    local cmp = require("cmp")
                    cmp.setup(
                        {
                            snippet = {
                                expand = function(args)
                                    require("luasnip").lsp_expand(args.body)
                                end
                            },
                            mapping = cmp.mapping.preset.insert(
                                {
                                    ["<C-Space>"] = cmp.mapping.complete(),
                                    ["<CR>"] = cmp.mapping.confirm({select = true}),
                                    ["<Tab>"] = cmp.mapping.select_next_item(),
                                    ["<S-Tab>"] = cmp.mapping.select_prev_item()
                                }
                            ),
                            sources = cmp.config.sources(
                                {
                                    {name = "nvim_lsp"},
                                    {name = "luasnip"}
                                },
                                {
                                    {name = "buffer"},
                                    {name = "path"}
                                }
                            )
                        }
                    )
                end
            },
            {
                "neovim/nvim-lspconfig",
                dependencies = {"williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim"}
            },
            {
                "numToStr/Comment.nvim",
                opts = {},
                lazy = false
            },
            {
                "vyfor/cord.nvim",
                build = ":Cord update",
                opts = {
                    -- log_level = "debug",
                    hooks = {
                        post_activity = function(_, activity)
                            activity.details = "unraveling the stack limit"
                            return activity
                        end
                    },
                    buttons = {
                        {
                            label = "mfw no autoindents in neovim",
                            url = "https://i.postimg.cc/fR8j78v7/my-honest-reaction-gun-pointing-in-mouth.jpg"
                        },
                        {
                            label = "std::print in c++23!!!",
                            url = "https://en.cppreference.com/w/cpp/io/print.html"
                        }
                    }
                }
            }
        },
        install = {colorscheme = {"vscode"}},
        checker = {enabled = true, notify = false}
    }
)

