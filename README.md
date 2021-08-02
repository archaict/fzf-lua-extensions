# fzf-lua-extensions
A small collection of functions that can be used for fzf-lua!

To call this all of this function, you can use `:lua fzf_projectionist{}` and so on.

## Fzf Projects
You can specify directory in `project_dirs`.
```lua
function fzf_projectionist()
  -- this is your list of directories
  local project_dirs = {
    "~/.config",
    "~/.config/nvim",
  }
  coroutine.wrap(function()                         -- wrap functions to fzf
    local choice = require "fzf".fzf(project_dirs)  -- taking dirs from project_dirs
    if choice then                                  -- usual if function
      require('fzf-lua').files({ cwd = choice[1] }) -- using files command from fzf-lua and specify working directory
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
      vim.cmd('chdir' .. choice[1]) -- change directory
    end
  end)()
end
```
Or if you want global variable, you can create this:
```lua
-- you can put vim.g.project_dirs anywhere in your config file
-- since it will be called as global variable!

vim.g.project_dirs ={ -- creating global variable for project_dirs
  "~/.config",
  "~/.config/nvim",
}
function fzf_projectionist()
  coroutine.wrap(function()
    local choice = require "fzf".fzf(vim.g.project_dirs)
    if choice then
      require('fzf-lua').files({ cwd = choice[1] })
    end
  end)()
end
```

## Dotfiles
Searching your dotfiles? here!

```lua
function fzf_vimconfig()
  -- specify vimconfig directory
  local choice = '~/.config/nvim'
  require('fzf-lua').files({
    prompt  = 'VimConfig » ',
    cwd = choice;
  })
  vim.cmd('chdir ' .. choice )
end

function fzf_dotfiles()
  -- this is using dropbox, you can use your git dir
  local choice = '~/Dropbox/codex'
  require('fzf-lua').files({
    prompt  = 'DotFiles» ',
    cwd = choice;
  })
  vim.cmd('chdir ' .. choice )
end
```

## Neorg / OrgMode
You can actually just specify the directory, it's the same function with different function name,
it is actually same with above function, just change the directory and you're done.
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
    -- specify folder, it can be changed as you wish, it is
    -- also possible change it like choice = 'dirs', but
    -- it is easier to understand this way, since you'll be
    -- using fd for creating functions anyway.
    local choice = fzf.fzf("fd . ~/Pictures -e png -e jpg")
    if choice then
      vim.cmd('silent !feh --bg-fill ' .. choice[1]) -- use feh to change wallpaper bts
    end
  end)()
end
```
