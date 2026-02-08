return function(capabilities)
  return {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    root_markers = { 'tsconfig.json', 'package.json', 'jsconfig.json', '.git' },
    capabilities = capabilities,
    init_options = {
      plugins = {
        {
          name = '@vue/typescript-plugin',
          location = vim.fn.stdpath('data') .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
          languages = { 'vue' },
        },
      },
    },
  }
end
