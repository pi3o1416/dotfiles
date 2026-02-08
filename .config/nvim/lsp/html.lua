return function(capabilities)
  return {
    cmd = { 'vscode-html-language-server', '--stdio' },
    filetypes = { 'html', 'htmldjango' },
    root_markers = { 'package.json', '.git' },
    capabilities = capabilities,
  }
end
