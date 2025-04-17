# nvim-fountain

A modern Neovim plugin for the [Fountain](https://fountain.io/) screenplay markup language, forked from Carson Fire's [vim-fountain](http://www.vim.org/scripts/script.php?script_id=3880).

## Features

- Syntax highlighting for Fountain screenplay format
- Navigation between scene headings
- Keyboard shortcuts for common screenwriting tasks
- Screenplay statistics (scene count, character appearances, etc.)
- Export to PDF, HTML, and Final Draft formats
- Preview in browser
- Compatible with Neovim and LazyVim

## About Fountain

Fountain is a plain text markup language for screenwriting. The format can be converted into Final Draft files (FDX) and HTML, and can be imported by Final Draft and Movie Magic.

The official [Fountain website](https://fountain.io/) contains helpful material, including sample scripts and apps.

Here is an excerpt from Big Fish by John August, one of the screenwriters behind Fountain:

```
EDWARD
(whispering)
Turn off your flashlights!  She'll see 'em.

MOVING UP behind the kids, we find ourselves at the gates of...

EXT.  A CREEPY OLD HOUSE - NIGHT

ADULT EDWARD (V.O.)
Now, it's common knowledge that most towns of a certain size have a witch, if only to eat misbehaving children and the occasional puppy who wanders into her yard.  Witches use those bones to cast spells and curses that make the land infertile.
```

## Installation

### Using [LazyVim](https://github.com/LazyVim/LazyVim) / [lazy.nvim](https://github.com/folke/lazy.nvim)

Add to your LazyVim config (e.g., in `lua/plugins/fountain.lua`):

```lua
return {
  "00msjr/nvim-fountain",
  ft = "fountain",  -- Lazy-load only for fountain files
  config = function()
    require("nvim-fountain").setup({
      -- Optional configuration
      keymaps = {
        next_scene = "]]",
        prev_scene = "[[",
        uppercase_line = "<S-CR>",
      },
    })
  end,
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "00msjr/nvim-fountain",
  ft = "fountain",  -- Lazy-load only for fountain files
  config = function()
    require("nvim-fountain").setup({
      -- Optional configuration
    })
  end
}
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
" In your init.vim
Plug '00msjr/nvim-fountain', {'for': 'fountain'}

" After plug#end(), add:
augroup fountain_setup
  autocmd!
  autocmd FileType fountain lua require('nvim-fountain').setup()
augroup END
```

### Using built-in Neovim package manager

```bash
# Clone the repository
mkdir -p ~/.local/share/nvim/site/pack/plugins/start/
git clone https://github.com/00msjr/nvim-fountain.git ~/.local/share/nvim/site/pack/plugins/start/nvim-fountain
```

Then in your init.lua:

```lua
-- Initialize the plugin
require('nvim-fountain').setup()
```

## Configuration

You can customize the plugin by passing options to the setup function:

```lua
require("nvim-fountain").setup({
  keymaps = {
    next_scene = "]]",
    prev_scene = "[[",
    uppercase_line = "<S-CR>",
  },
  use_treesitter = true,  -- Enable treesitter integration if available
  -- Additional options
})
```

## Commands

### Editing and Navigation

- `:FountainStats` - Display screenplay statistics (scene count, character appearances, etc.)
- `:FountainFormat` - Format the current fountain document

### Export and Preview

- `:FountainExportPDF [filename]` - Export to PDF (optional filename)
- `:FountainExportHTML [filename]` - Export to HTML (optional filename)
- `:FountainExportFDX [filename]` - Export to Final Draft (FDX) format (optional filename)
- `:FountainPreview` - Preview screenplay in browser

## Default Keymaps

- `]]` - Navigate to next scene heading
- `[[` - Navigate to previous scene heading
- `<S-CR>` - Make current line uppercase and move to next line

## Screenplay Statistics

The `:FountainStats` command provides useful information about your screenplay:

- Total number of scenes
- List of characters with number of appearances
- Dialogue and action line counts
- Total line count

This can help track your screenplay's structure and character balance.

## Export and Preview

The export functionality requires [afterwriting](https://github.com/ifrost/afterwriting-labs/blob/master/docs/clients.md) to be installed:

```bash
npm install -g afterwriting
```

Once installed, you can use the export commands to convert your Fountain screenplay to various formats:

- PDF: `:FountainExportPDF [optional-filename.pdf]`
- HTML: `:FountainExportHTML [optional-filename.html]`
- Final Draft: `:FountainExportFDX [optional-filename.fdx]`

The preview command (`:FountainPreview`) generates a temporary HTML file and opens it in your default browser.
