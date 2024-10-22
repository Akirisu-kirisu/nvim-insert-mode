
- [Overview](<#overview>)
    - [Todo](<#todo>)

## nvim-insert-mode
Insert-Mode Search|Replace based navigation combined with quick jump features.


* ## Dynamic Text Replacement:
    Users can replace text efficiently based on their input, allowing for quick adjustments without leaving insert mode.
    Supports varying lengths of replacement text, accommodating different editing needs.

* ## Anywhere Functionality:
    Integrates with the Hop plugin to enable quick navigation within lines and across the buffer.
    Offers different hopping modes based on the context (e.g., empty lines vs. current line), making it versatile for various editing scenarios.

### Requirements

[Neovim 0.9+](https://github.com/neovim/neovim/releases) is required.

[Hop.nvim](https://github.com/smoka7/hop.nvim/)

[Noice](https://github.com/folke/noice.nvim)


* ## Setup
```lua
-- lazy.nvim
  {
    dir = "Akirisu-kirisu/nvim-insert-mode",
    dependencies = {
        "smoka7/hop.nvim",
        "folke/noice.nvim",
    },
    event = "VeryLazy", -- Lazy load your plugin based on specific event
  },

-- noice.nvim
  views = {
    cmdline_popup = {
      timeout = 10000,
      focusable = true,
      position = {
        row = "93%", -- This will position it at the bottom of the screen
        col = "100%",
      },
      relative = "editor",
      size = {
        width = get_relative_width(),
        height = "auto",
      },
      replace = true,
    },
  }
```
## keymaps
```lua
vim.keymap.set("n", "<A-r>", [[<C-o>:lua require('nvim-insert-mode').insert_find_replace()<CR>]])
vim.keymap.set("n", "<A-,>", [[<C-o>:lua require('nvim-insert-mode').insert_find_cut()<CR>]])
vim.keymap.set("n", "<A-.>", [[<C-o>:lua require('nvim-insert-mode').insert_hop()<CR>]])
```
## Todo
<A-r> Command Features:

1. The <A-r> command should function like a vertical hop, allowing the selection of empty lines, 
    with an optional width of 80 characters.

2. It should incorporate a precognition feature that utilizes gutter lines.

3. It must include a search history feature to select previous and next entries


