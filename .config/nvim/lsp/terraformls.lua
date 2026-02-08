return function(capabilities)
  return {
    cmd = { 'terraform-ls', 'serve' },
    filetypes = { 'terraform', 'terraform-vars' },
    root_markers = { '.terraform', '.git' },
    capabilities = capabilities,
  }
end
