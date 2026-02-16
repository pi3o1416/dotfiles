return function(capabilities)
  return {
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = { 'yaml', 'yaml.docker-compose' },
    root_dir = function(filename)
      return vim.fs.root(filename, { '.git' }) or vim.fn.fnamemodify(filename, ':h')
    end,
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
