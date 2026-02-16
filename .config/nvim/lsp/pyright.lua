return function(capabilities)
  return {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_dir = function(filename)
      local util = vim.fs
      -- Try to find a project root first
      local root = util.root(filename, { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' })
      -- If no project root found, use the file's directory
      if not root then
        root = vim.fn.fnamemodify(filename, ':h')
      end
      return root
    end,
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = 'openFilesOnly',
        }
      }
    }
  }
end
