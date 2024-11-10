return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    -- "natecraddock/telescope-zf-native.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-dap.nvim",
    "nvim-telescope/telescope-media-files.nvim",
    "kkharji/sqlite.lua",
  },
  keys = {
    { "<leader>pf", require("telescope.builtin").find_files }
  },
  config = function()
    local builtin = require('telescope.builtin')
    local action_state = require('telescope.actions.state')
    local telescope = require("telescope")
    local icons = require("configs.icons")

    vim.keymap.set('n', '<C-e>', function()
      builtin.buffers({
        initial_mode = "normal",
        attach_mappings = function(prompt_bufnr, map)
          local delete_buf = function()
            local current_picker = action_state.get_current_picker(prompt_bufnr)
            current_picker:delete_selection(function(selection)
              vim.api.nvim_buf_delete(selection.bufnr, { force = true })
            end)
          end

          map('n', '<C-d>', delete_buf)

          return true
        end
      }, {
        sort_lastused = true,
        sort_mru = true,
        theme = "dropdown"
      })
    end)

    telescope.setup({
      defaults = {
        path_display = {
          "filename_first",
        },
        previewer = false,
        prompt_prefix = " " .. icons.ui.Telescope .. " ",
        selection_caret = icons.ui.BoldArrowRight .. " ",
        file_ignore_patterns = { "node_modules", "package-lock.json" },
        initial_mode = "insert",
        select_strategy = "reset",
        sorting_strategy = "descending",
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        layout_config = {
          prompt_position = "bottom",
          preview_cutoff = 120,
        },
      }
    })


    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
    telescope.load_extension("dap")
    telescope.load_extension("media_files")
  end
}