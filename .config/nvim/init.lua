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

-- Setup lazy.nvim
require("lazy").setup({
  -- Core utilities
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter",

  -- LSP and language support
  "mason-org/mason.nvim",
  "ray-x/lsp_signature.nvim",

  -- Formatting and diagnostics
  "mfussenegger/nvim-lint",
  "rshkarin/mason-nvim-lint",

  -- Debugging
  "mfussenegger/nvim-dap",
  "jayp0521/mason-nvim-dap.nvim",

  -- Autocompletion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",

  -- File navigation
  "ctrlpvim/ctrlp.vim",
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  "nvim-telescope/telescope.nvim",

  -- Git integration
  "tpope/vim-fugitive",

  -- Appearance and themes
  "morhetz/gruvbox",
  "rafi/awesome-vim-colorschemes",
  "Yggdroot/indentLine",

  -- Editor enhancements
  "editorconfig/editorconfig-vim",
  "Raimondi/delimitMate",
  {
    "kylechui/nvim-surround",
    version = "*",
    config = function()
      require("nvim-surround").setup()
    end
  },
})


-- Solarized setup in Lua
vim.o.background = "dark"
vim.g.solarized_termcolors = 256
vim.cmd('colorscheme solarized8')

-- Gruvbox setup in Lua
-- vim.cmd('syntax enable') -- Ensures syntax highlighting is enabled
-- vim.o.background = "dark"
-- vim.g.gruvbox_contrast_dark = "soft"
-- vim.g.gruvbox_contrast_light = "medium"
-- vim.cmd('colorscheme gruvbox')

-- PaperColor setup in Lua
-- vim.o.background = "dark"
-- vim.cmd('colorscheme PaperColor')

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
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "EE",
      [vim.diagnostic.severity.WARN] = ">>",
      [vim.diagnostic.severity.INFO] = ">>",
      [vim.diagnostic.severity.HINT] = ">>",
    }
  },
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
vim.opt.termguicolors = true
vim.opt.updatetime = 500  -- Faster CursorHold trigger (500ms)

-- Indentation settings
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true

-- Filetype specific indentation
vim.cmd [[
    autocmd FileType javascript setlocal ts=2 sw=2 expandtab
    autocmd FileType typescript setlocal ts=2 sw=2 expandtab
    autocmd FileType html setlocal ts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sw=2 expandtab
    autocmd FileType markdown setlocal ts=2 sw=2 expandtab
    autocmd FileType python setlocal ts=4 sw=4 sts=0 expandtab
]]

-- Add Mason bin directory to PATH
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

-- Mason setup with improved UI
require("mason").setup({
    ui = {
        check_outdated_packages_on_open = true,
        border = "rounded",
        width = 0.8,
        height = 0.9,
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        },
        keymaps = {
            toggle_package_expand = "<CR>",
            install_package = "i",
            update_package = "u",
            check_package_version = "c",
            update_all_packages = "U",
            check_outdated_packages = "C",
            uninstall_package = "X",
            cancel_installation = "<C-c>",
            apply_language_filter = "<C-f>",
        },
    }
})

require("mason-nvim-dap").setup({
    ensure_installed = { "pylint", "python" },
    automatic_installation = true,
})

require("mason-nvim-lint").setup({
    ensure_installed = { "eslint_d" },
    automatic_installation = true,
})

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
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
  }, {
    { name = 'buffer' },
  })
})

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

-- Set up LSP configuration
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Add config directory to Lua path
local config_dir = vim.fn.stdpath("config")
package.path = package.path .. ";" .. config_dir .. "/?.lua"

-- LSP servers to load
local lsp_servers = {
  'pyright',
  'gopls',
  'lua_ls',
  'ts_ls',
  'terraformls',
  'html',
  'rust_analyzer',
  'prismals',
  'volar',
  'yamlls'
}

-- Setup all LSP servers
for _, server in ipairs(lsp_servers) do
  local config_fn = require('lsp.' .. server)
  local config = config_fn(capabilities)

  vim.api.nvim_create_autocmd("FileType", {
    pattern = config.filetypes,
    callback = function(args)
      local bufnr = args.buf
      local filename = vim.api.nvim_buf_get_name(bufnr)

      -- Skip if buffer already has this LSP client
      if #vim.lsp.get_clients({ bufnr = bufnr, name = server }) > 0 then
        return
      end

      local root = config.root_dir(filename)
      if root then
        vim.lsp.start({
          name = server,
          cmd = config.cmd,
          root_dir = root,
          capabilities = config.capabilities,
          settings = config.settings,
          init_options = config.init_options,
        }, { bufnr = bufnr })
      end
    end,
  })
end

-- Set up linter
require('lint').linters_by_ft = {
  python = {'pylint'},
  javascript = {'eslint_d'},
  typescript = {'eslint_d'},
  javascriptreact = {'eslint_d'},
  typescriptreact = {'eslint_d'},
  vue = {'eslint_d'}
}

-- Set running linters on buffer save
vim.api.nvim_create_autocmd({"BufWritePost"}, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- Set pylint to work in virtualenv
require('lint').linters.pylint.cmd = 'python'
require('lint').linters.pylint.args = {'-m', 'pylint', '-f', 'json'}

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

-- Setup for delimitMate
vim.g.delimitMate_expand_space = 1
vim.g.delimitMateBackspace = 1
vim.cmd [[
    autocmd filetype htmldjango let b:delimitMate_matchpairs = "(:),[:],<:>"
]]

-- Setup for nvim-tree
require("nvim-web-devicons").setup({
  default = true,
})

require("nvim-tree").setup({
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")

    -- Default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- Custom mappings
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Open in new tab and switch to it (default <C-t> behavior)
    vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))

    -- Open in new tab but stay in nvim-tree
    vim.keymap.set('n', 'T', function()
      api.node.open.tab()
      vim.cmd('tabprevious')  -- Go back to previous tab (nvim-tree)
    end, opts('Open: New Tab (Stay)'))
  end,
})

-- Telescope setup
require("telescope").setup({
  defaults = {
    file_ignore_patterns = {
      -- Dependencies & package managers
      "node_modules",
      "venv", ".venv", "env", ".env",
      "vendor/",
      "__pycache__/",
      "target/",

      -- Version control
      ".git/", ".svn/", ".hg/",

      -- Build outputs
      "dist/", "build/", "out/",
      "%.min%.js", "%.min%.css",

      -- IDE/Editor
      ".vscode/", ".idea/", ".vs/",

      -- OS files
      ".DS_Store", "Thumbs.db", "desktop.ini",

      -- Logs & temporary
      "%.log", "%.tmp", "%.cache",
      ".coverage", "coverage/", ".nyc_output/",

      -- Compiled files
      "%.o", "%.so", "%.dll", "%.class", "%.pyc",
    },
  }
})

-- Telescope keybindings
local telescope_opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', telescope_opts)  -- Find files
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', telescope_opts)   -- Search in files
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', telescope_opts)     -- Find buffers
vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>', telescope_opts)   -- Find help

-- Setup for jsx
vim.g.jsx_ext_required = 0

-- Keybindings
local opts = { noremap = true, silent = true }

-- Fix Tab behavior 
vim.api.nvim_set_keymap('i', '<Tab>', '<C-t>', opts)

-- General navigation
vim.api.nvim_set_keymap('n', '<F3>', ':noh<CR>', opts)  -- Clear search highlights
vim.api.nvim_set_keymap('n', '<C-l>', ':tabnext<CR>', opts)  -- Next tab
vim.api.nvim_set_keymap('n', '<C-h>', ':tabprevious<CR>', opts)  -- Previous tab
vim.api.nvim_set_keymap('n', '<F6>', ':silent !clear <Enter>', opts)  -- Clear terminal

-- Quick movement
vim.api.nvim_set_keymap('n', '<leader>j', ':+10<CR>', opts)  -- Jump down 10 lines
vim.api.nvim_set_keymap('n', '<leader>k', ':-10<CR>', opts)  -- Jump up 10 lines

-- Configuration management
vim.api.nvim_set_keymap('n', '<leader>ev', ':vsplit $MYVIMRC<CR>', opts)  -- Edit init.lua
vim.api.nvim_set_keymap('n', '<leader>sv', ':source $MYVIMRC<CR>', opts)  -- Reload config

-- LSP and diagnostics
vim.api.nvim_set_keymap('n', '<leader><C-f>', ':lua vim.lsp.buf.format({ async = true })<CR>', opts)  -- Format code
vim.api.nvim_set_keymap('n', '<leader>n', ':lnext<CR>', opts)  -- Next diagnostic
vim.api.nvim_set_keymap('n', '<leader>m', ':lprev<CR>', opts)  -- Previous diagnostic
vim.api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)  -- Show LSP hover documentation
vim.api.nvim_set_keymap('n', '<leader>d', ':lua vim.diagnostic.open_float()<CR>', opts)  -- Show diagnostics

-- File tree
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', opts)  -- Toggle file tree

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


-- Terraform settings
-- Terraform filetype detection
vim.cmd [[
    autocmd BufRead,BufNewFile *.tf set filetype=hcl
    autocmd BufRead,BufNewFile *.hcl set filetype=hcl
    autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl
    autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform
    autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json
]]

-- Terraform keybindings
vim.api.nvim_set_keymap('n', '<leader>ti', ':!terraform init<CR>', opts)  -- Terraform init
vim.api.nvim_set_keymap('n', '<leader>tv', ':!terraform validate<CR>', opts)  -- Terraform validate
vim.api.nvim_set_keymap('n', '<leader>tp', ':!terraform plan<CR>', opts)  -- Terraform plan
vim.api.nvim_set_keymap('n', '<leader>taa', ':!terraform apply -auto-approve<CR>', opts)  -- Terraform apply
