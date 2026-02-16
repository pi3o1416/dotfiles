return function(capabilities)
  return {
    cmd = { 'vue-language-server', '--stdio' },
    filetypes = { 'vue' },
    root_dir = function(filename)
      return vim.fs.root(filename, { 'package.json', 'vue.config.js', '.git' }) or vim.fn.fnamemodify(filename, ':h')
    end,
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
