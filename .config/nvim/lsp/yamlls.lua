return function(lspconfig, capabilities)
  lspconfig.yamlls.setup {
    capabilities = capabilities,
    settings = {
      yaml = {
        validate = true,
        completion = true,
        hover = true,
      },
    },
  }
end
