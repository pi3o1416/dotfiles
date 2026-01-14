return function(lspconfig, capabilities)
  lspconfig.terraformls.setup {
    capabilities = capabilities,
  }
end
