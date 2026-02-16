return function(capabilities)
  return {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_dir = function(filename)
      return vim.fs.root(filename, { 'Cargo.toml', 'rust-project.json', '.git' }) or vim.fn.fnamemodify(filename, ':h')
    end,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        cargo = { loadOutDirsFromCheck = true },
        procMacro = { enable = true },
      },
    },
  }
end
