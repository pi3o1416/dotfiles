-- Linters [clj-kondo, ruby, inko, janet] are absent in the mason's registry. Please, install them manually and remove from configuration.
-- Initialize packer for managing plugins
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'nvim-lua/plenary.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'mfussenegger/nvim-lint'
  use 'rshkarin/mason-nvim-lint'
  use 'mfussenegger/nvim-dap'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'jayp0521/mason-nvim-dap.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'jayp0521/mason-null-ls.nvim'
  use 'ray-x/lsp_signature.nvim'
  use 'Raimondi/delimitMate'
  use 'hashivim/vim-terraform'
  use 'vim-airline/vim-airline'
  use 'justinj/vim-react-snippets'
  use 'ctrlpvim/ctrlp.vim'
  use 'scrooloose/nerdtree'
  use 'morhetz/gruvbox'
  use 'rafi/awesome-vim-colorschemes'
  use 'neomake/neomake'
  use 'Yggdroot/indentLine'
  use 'sheerun/vim-polyglot'
  use 'jidn/vim-dbml'
  use 'editorconfig/editorconfig-vim'
  use 'tpope/vim-fugitive'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'SirVer/ultisnips'
  use 'quangnguyen30192/cmp-nvim-ultisnips'

  if packer_bootstrap then
    require('packer').sync()
  end
end)


-- Solarized setup in Lua
-- vim.cmd('syntax enable') -- This line is typically not needed in Neovim with Lua
-- vim.o.background = "light"
-- vim.g.solarized_termcolors = 256
-- vim.cmd('colorscheme solarized')

-- Gruvbox setup in Lua
vim.cmd('syntax enable') -- Ensures syntax highlighting is enabled
vim.o.background = "light"
vim.g.gruvbox_contrast_dark = "soft"
vim.g.gruvbox_contrast_light = "medium"
vim.cmd('colorscheme gruvbox')

-- PaperColor setup in Lua
-- vim.o.t_Co = 256 -- This is not necessary in Neovim as it handles colors differently
-- vim.o.background = "dark"
-- vim.cmd('colorscheme PaperColor')

-- Diagnostic Signs
vim.fn.sign_define("DiagnosticSignError", { text = "EE", texthl = "DiagnosticSignError", linehl="", numhl="" })
vim.fn.sign_define("DiagnosticSignWarn", { text = ">>", texthl = "DiagnosticSignWarn", linehl="", numhl="" })
vim.fn.sign_define("DiagnosticSignInfo", { text = ">>", texthl = "DiagnosticSignInfo", linehl="", numhl="" })
vim.fn.sign_define("DiagnosticSignHint", { text = ">>", texthl = "DiagnosticSignHint", linehl="", numhl="" })

-- Highlight Groups
vim.cmd [[
  highlight DiagnosticError guifg=#FF0000
  highlight DiagnosticSignError guifg=#FF0000
  highlight DiagnosticSignWarn guifg=#808080
  highlight DiagnosticUnderlineError gui=undercurl guifg=#FF0000 guisp=#FF0000
  highlight DiagnosticUnderlineWarn gui=undercurl guisp=#808080
]]

-- Floating Diagnostics Configuration
vim.cmd [[
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]]
vim.diagnostic.config({
  virtual_text = false,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
  signs = true,
  underline = true,
  severity_sort = true,
})

-- Custom settings
vim.g.python3_host_prog = "/usr/bin/python"
vim.g.mapleader = ","
vim.opt.compatible = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.guicursor = ""

-- Indentation settings
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Filetype specific indentation
vim.cmd [[
    autocmd FileType javascript setlocal ts=2 sw=2 expandtab
    autocmd FileType typescript setlocal ts=2 sw=2 expandtab
    autocmd FileType html setlocal ts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sw=2 expandtab
    autocmd FileType markdown setlocal ts=2 sw=2 expandtab
    autocmd FileType python setlocal ts=4 sw=4 sts=0 expandtab
]]

-- mason setup
require("mason").setup({
    ui = {
        icons = {
            package_installed = "â��",
            package_pending = "â��",
            package_uninstalled = "â��"
        }
    }
})
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyright", "ts_ls", "ruby", "inko", "clj-kondo", "janet"},
    automatic_installation = true,
})

require("mason-nvim-dap").setup({
    ensure_installed = { "python" },
    automatic_installation = true,
})

require("mason-nvim-lint").setup({
    ensure_installed = { },
    autoatic_installation = true,
})

require("mason-null-ls").setup({
    ensure_installed = { "prettier" },
    automatic_installation = true,
})

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})
require("cmp_git").setup() ]]-- 

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require("lspconfig")
lspconfig.pyright.setup {}
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}
lspconfig.ts_ls.setup {}
lspconfig.terraformls.setup {}

-- Set up linter
-- require('lint').linters_by_ft = {
--   python = {'pylint'}
-- }
-- 
-- Set running linters on buffer save
-- vim.api.nvim_create_autocmd({"BufWritePost"}, {
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })
-- 
-- -- Set pylint to work in virtualenv
-- require('lint').linters.pylint.cmd = 'python'
-- require('lint').linters.pylint.args = {'-m', 'pylint', '-f', 'json'}
-- 
local null_ls = require("null-ls")
local sources = {
    null_ls.builtins.diagnostics.pylint.with({
        filetypes = { "python" },
    }),
    null_ls.builtins.formatting.autopep8.with({
        filetypes = { "python" },
    }),
}

null_ls.setup({
    sources = sources,
})


-- Set up formatter
vim.api.nvim_set_keymap('n', '<leader><C-f>', ':lua vim.lsp.buf.format({ async = true })<CR>', { noremap = true, silent = true })

-- Setup lsp signature

require'lsp_signature'.setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded" -- Double border for better visibility
  },
  hint_enable = true, -- Disable inline hints (optional)
})

-- Setup for ctrlp
vim.g.ctrlp_working_path_mode = 'aw'

-- Setup for editorconfig
vim.g.EditorConfig_exclude_patterns = {'fugitive://.*', 'scp://.*'}

-- Setup for ultisnips
vim.g.UltiSnipsExpandTrigger = "<c-s>"
vim.g.UltiSnipsJumpForwardTrigger = "<c-j>"
vim.g.UltiSnipsJumpBackwardTrigger = "<c-k>"
vim.g.UltiSnipsListSnippets = "<c-?>"

-- Setup for delimitMate
vim.g.delimitMate_expand_space = 1
vim.g.delimitMateBackspace = 1
vim.cmd [[
    autocmd filetype htmldjango let b:delimitMate_matchpairs = "(:),[:],<:>"
]]

-- Setup for NERDTree
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
vim.cmd [[
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
]]

-- Setup for jsx
vim.g.jsx_ext_required = 0 

-- Setup for Neomake
vim.g.neomake_python_enabled_makers = {'flake8'}

-- My keybindings
vim.api.nvim_set_keymap('n', '<F3>', ':noh<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':tabnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', ':tabprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ev', ':vsplit $MYVIMRC<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sv', ':source $MYVIMRC<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', ':+10<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', ':-10<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sc', ':Neomake<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':lnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>m', ':lprev<CR>', { noremap = true, silent = true })

-- Filetype specific keybindings
--vim.cmd [[
--    autocmd filetype scss nnoremap <F5> :w <bar>!node-sass -o css %<CR>
--    autocmd filetype python nnoremap <F5> :w <bar>make py<CR>
--    autocmd filetype python nnoremap <F9> :w <bar>!python %<CR>
--    autocmd filetype html nnoremap <leader>n :setfiletype htmldjango<CR>
--    autocmd FileType cpp nnoremap <F9> :w !clear <bar>make<CR>
--    autocmd FileType cpp nnoremap <F5> :./%:r<CR>
--    autocmd FileType c nnoremap <F5> :!./%:r<CR>
--    autocmd filetype dart nnoremap <F9> :w <bar>!dart %<CR>
--]]

vim.api.nvim_set_keymap('n', '<F6>', ':silent !clear <Enter>', { noremap = true, silent = true })

-- Terraform settings
vim.cmd [[
    autocmd BufRead,BufNewFile *.tf set filetype=hcl
    autocmd BufRead,BufNewFile *.hcl set filetype=hcl
    autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl
    autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform
    autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json
]]

vim.g.terraform_fmt_on_save = 1
vim.g.terraform_align = 1

-- Terraform keybindings
vim.api.nvim_set_keymap('n', '<leader>ti', ':!terraform init<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tv', ':!terraform validate<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tp', ':!terraform plan<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>taa', ':!terraform apply -auto-approve<CR>', { noremap = true, silent = true })
