return function(capabilities)
  return {
    cmd = { 'vscode-html-language-server', '--stdio' },
    filetypes = { 'html', 'htmldjango' },
    root_dir = function(filename)
      return vim.fs.root(filename, { 'package.json', '.git' }) or vim.fn.fnamemodify(filename, ':h')
    end,
    capabilities = capabilities,
  }
end
