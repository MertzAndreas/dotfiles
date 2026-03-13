local last_colorscheme = nil

return {
  {
    name = "theme-hotreload",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    priority = 1000,
    config = function()
      local function apply_theme()
        package.loaded["plugins.theme"] = nil
        vim.schedule(function()
          local ok, theme_spec = pcall(require, "plugins.theme")
          if not ok then return end

          local active_spec = nil
          for _, spec in ipairs(theme_spec) do
            if spec.colorscheme then
              active_spec = spec
              break
            end
          end
          if not active_spec then return end

          local new_colorscheme = type(active_spec.colorscheme) == "string"
              and active_spec.colorscheme
              or tostring(active_spec.colorscheme)

          if new_colorscheme == last_colorscheme then return end
          last_colorscheme = new_colorscheme

          vim.cmd("highlight clear")
          if vim.fn.exists("syntax_on") == 1 then
            vim.cmd("syntax reset")
          end
          vim.o.background = "dark"

          if type(active_spec.colorscheme) == "function" then
            active_spec.colorscheme()
            vim.cmd("redraw!")
          else
            local theme_plugin_name = active_spec.name or active_spec[1]
            local plugin = require("lazy.core.config").plugins[theme_plugin_name]
            if plugin then
              local plugin_dir = plugin.dir .. "/lua"
              require("lazy.core.util").walkmods(plugin_dir, function(modname)
                package.loaded[modname] = nil
                package.preload[modname] = nil
              end)
            end
            require("lazy.core.loader").colorscheme(active_spec.colorscheme)
            vim.defer_fn(function()
              pcall(vim.cmd.colorscheme, active_spec.colorscheme)
              vim.cmd("redraw!")
            end, 5)
          end
        end)
      end

      apply_theme()
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyReload",
        callback = apply_theme,
      })
    end,
  },
}
