return function(capabilities)
  return {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_dir = function(filename)
      return vim.fs.root(filename, { 'go.work', 'go.mod', '.git' }) or vim.fn.fnamemodify(filename, ':h')
    end,
    capabilities = capabilities,
  }
end
