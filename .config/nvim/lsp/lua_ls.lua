return function(capabilities)
  return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = {
          globals = { 'vim' },
          disable = { 'missing-fields', 'inject-field', 'undefined-field' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
        telemetry = { enable = false },
        hint = { enable = true },
      },
    },
  }
end
