return function(capabilities)
  return {
    cmd = { 'terraform-ls', 'serve' },
    filetypes = { 'terraform', 'terraform-vars' },
    root_dir = function(filename)
      return vim.fs.root(filename, { '.terraform', '.git' }) or vim.fn.fnamemodify(filename, ':h')
    end,
    capabilities = capabilities,
  }
end
