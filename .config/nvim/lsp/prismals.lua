return function(capabilities)
  return {
    cmd = { 'prisma-language-server', '--stdio' },
    filetypes = { 'prisma' },
    root_dir = function(filename)
      return vim.fs.root(filename, { 'package.json', '.git' }) or vim.fn.fnamemodify(filename, ':h')
    end,
    capabilities = capabilities,
  }
end
