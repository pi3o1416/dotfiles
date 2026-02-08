return function(capabilities)
  return {
    cmd = { 'prisma-language-server', '--stdio' },
    filetypes = { 'prisma' },
    root_markers = { 'package.json', '.git' },
    capabilities = capabilities,
  }
end
