-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
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
require("lazy").setup({
  spec = {
    -- import your plugins
	{ "tpope/vim-sleuth" },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = 
      {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
      },
      lazy = false,
      ---@module "neo-tree"
      ---@type neotree.Config?
      opts = {},
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
		  ensure_installed = "all",
		  highlight = { enable = true },
		  indent = { enable = true },
		  autotag = { 
			enable = true,
			enable_close_on_slash = false 
		  },
		})
	  end,
    },
    {
      "Badhi/nvim-treesitter-cpp-tools",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      opts = function()
					local options = {
          preview = {
            quit = "q",
            accept = "<tab>",
          },
          header_extension = "h",
          source_extension = "cpp",
          custom_define_class_function_commands = {
            TSCppImplWrite = {
              output_handle = require("nt-cpp-tools.output_handlers").get_add_to_cpp(),
            },
          },
        }
        return options
      end,
      config = true,
    },
    { "Mofiqul/vscode.nvim", priority = 1000, config = true, opts = ... },
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
	cmp.setup({
	  snippet = {
	    expand = function(args)
	      require("luasnip").lsp_expand(args.body)
	    end
	  },
	mapping = cmp.mapping.preset.insert({
	  ['<C-Space>'] = cmp.mapping.complete(),
	  ['<CR>'] = cmp.mapping.confirm({ select = true }),
	  ['<Tab>'] = cmp.mapping.select_next_item(),
	  ['<S-Tab>'] = cmp.mapping.select_prev_item(),
	}),
	sources = cmp.config.sources({
	  { name = 'nvim_lsp' },
	  { name = 'luasnip' },
	}, {
	  { name = 'buffer' },
	  { name = 'path' },
	}),
      })
      end,
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = {"williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim",}
    },
    {
      "m4xshen/autoclose.nvim"
    },
    {
      "numToStr/Comment.nvim",
      opts = {},
      lazy = false
    },
  },
  install = { colorscheme = { "vscode" } },
  checker = { enabled = true },
})
