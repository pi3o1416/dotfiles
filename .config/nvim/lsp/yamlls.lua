return function(capabilities)
  return {
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = { 'yaml', 'yaml.docker-compose' },
    root_markers = { '.git' },
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
