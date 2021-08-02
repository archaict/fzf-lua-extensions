# fzf-lua-extensions
A small collection of functions that can be used for fzf-lua!

To call this all of this function, you can use `:lua fzf_projectionist{}` and so on.

## Fzf Projects
You can specify directory in `project_dirs`.
```lua
function fzf_projectionist()
  local project_dirs = {
    "~/.config",
    "~/.config/nvim",
  }
  coroutine.wrap(function()
    local choice = require "fzf".fzf(project_dirs)
    if choice then
      require('fzf-lua').files({ cwd = choice[1] })
    end
  end)()
end
```
Or if you're like me and have your own config file, you can run it like this:
```lua
function fzf_projectionist()
  -- this should be your path, you can see example in core.lua file!
  local project_dirs = require'core'.core.project_dirs
  coroutine.wrap(function()
    local choice = require "fzf".fzf(project_dirs)
    if choice then
      require('fzf-lua').files({
        prompt  = 'Project » ',
        cwd = choice[1];
      })
      vim.cmd('chdir' .. choice[1])
    end
  end)()
end
```

## Dotfiles
Searching your dotfiles? here!

```lua
function fzf_vimconfig()
  local choice = '~/.config/nvim'
  require('fzf-lua').files({
    prompt  = 'VimConfig » ',
    cwd = choice;
  })
  vim.cmd('chdir ' .. choice )
end

function fzf_dotfiles()
  local choice = '~/Dropbox/codex'
  require('fzf-lua').files({
    prompt  = 'DotFiles» ',
    cwd = choice;
  })
  vim.cmd('chdir ' .. choice )
end
```

## Neorg / OrgMode
You can actually just specify the directory, it's the same function with different function name
```lua
function fzf_orgmode()
  local choice = '~/org'
  require('fzf-lua').files({
    prompt  = 'OrgFiles » ',
    cwd = choice;
  })
  vim.cmd('chdir ' .. choice )
end

function fzf_neorg()
  local choice = '~/neorg'
  require('fzf-lua').files({
    prompt  = 'Neorg » ',
    cwd = choice;
  })
  vim.cmd('chdir ' .. choice )
end
```

## Wallpaper
Wanna change wallpaper? use this instead!
You can swap feh with nitrogen or any other command that you like!
```lua
function fzf_wallpaper()
  coroutine.wrap(function()
    local fzf = require("fzf")
    local choice = fzf.fzf("fd . ~/Pictures -e png -e jpg")
    if choice then
      vim.cmd('silent !feh --bg-fill ' .. choice[1])
    end
  end)()
end
```
