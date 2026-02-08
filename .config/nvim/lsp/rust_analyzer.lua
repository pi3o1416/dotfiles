return function(capabilities)
  return {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        cargo = { loadOutDirsFromCheck = true },
        procMacro = { enable = true },
      },
    },
  }
end
