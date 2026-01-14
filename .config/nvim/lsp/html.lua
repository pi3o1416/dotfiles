return function(lspconfig, capabilities)
  lspconfig.html.setup {
    capabilities = capabilities,
    filetypes = { 'html', 'htmldjango' },
  }
end
