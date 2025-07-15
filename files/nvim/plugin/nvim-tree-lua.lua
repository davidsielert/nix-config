require("nvim-tree").setup({
  update_focused_file = {
    enable = true,      -- Enable syncing with the active file
    -- Consider these options as well for a complete experience:
    update_root = true, -- Change nvim-tree's root to the active file's directory if it's outside the current root
    -- ignore_list = {}, -- Files or patterns to ignore when updating (e.g., if you don't want it to jump to temporary files)
  },
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
