return {
  settings = {
    haskell = {
      checkParents = "CheckOnSave",
      checkProject = true,
      formattingProvider = "fourmolu",
      maxCompletions = 40,
      plugin = {
        alternateNumberFormat = { globalOn = true },
        callHierarchy = { globalOn = true },
        changeTypeSignature = { globalOn = true },
        class = { codeActionsOn = true, codeLensOn = true },
        eval = {
          config = { diff = true, exception = true },
          globalOn = true,
        },
        explicitFixity = { globalOn = true },
        gadt = { globalOn = true },
        ["ghcide-code-actions-bindings"] = { globalOn = true },
        ["ghcide-code-actions-fill-holes"] = { globalOn = true },
        ["ghcide-code-actions-imports-exports"] = { globalOn = true },
        ["ghcide-code-actions-type-signatures"] = { globalOn = true },
        ["ghcide-completions"] = {
          config = { autoExtendOn = true, snippetsOn = true },
          globalOn = true,
        },
        ["ghcide-hover-and-symbols"] = { hoverOn = true, symbolsOn = true },
        ["ghcide-type-lenses"] = {
          config = { mode = "always" },
          globalOn = true,
        },
        haddockComments = { globalOn = true },
        hlint = { codeActionsOn = true, diagnosticsOn = true },
        importLens = { codeActionsOn = true, codeLensOn = true, globalOn = true },
        moduleName = { globalOn = true },
        pragmas = { codeActionsOn = true, completionOn = true },
        qualifyImportedNames = { globalOn = true },
        refineImports = { codeActionsOn = true, codeLensOn = true },
        rename = {
          config = { crossModule = true },
          globalOn = true,
        },
        retrie = { globalOn = true },
        splice = { globalOn = true },
        tactics = {
          codeActionsOn = true,
          codeLensOn = true,
          config = {
            auto_gas = 4,
            max_use_ctor_actions = 5,
            proofstate_styling = true,
            timeout_duration = 2,
          },
          hoverOn = true,
        },
      },
    },
  },
}
