return function(lspconfig, capabilities)
  lspconfig.volar.setup {
    capabilities = capabilities,
    init_options = {
      vue = { hybridMode = false },
    },
    settings = {
      typescript = {
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          parameterTypes = {
            enabled = true,
            suppressWhenArgumentMatchesName = true,
          },
          variableTypes = { enabled = true },
        },
      },
    },
  }
end
