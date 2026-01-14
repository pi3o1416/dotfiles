return function(lspconfig, capabilities)
  lspconfig.gopls.setup {
    capabilities = capabilities,
  }
end
