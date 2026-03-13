return {
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
        reportMissingTypeStubs = false,
        reportUnknownMemberType = false,
        reportUnknownVariableType = false,
        exclude = { "pygrametl" }, -- ignore this dynamic library
      },
    },
  },
}
