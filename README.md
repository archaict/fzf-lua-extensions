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
    -- specify folder, it can be changed as you wish,
    -- it is also possible change it like choice = 'dirs',
    -- but it is easier to understand this way
    -- since you'll be using fd for creating functions anyway.
    local choice = fzf.fzf("fd . ~/Pictures -e png -e jpg")
    if choice then
      -- use shell [!] command feh to change wallpaper behind the scenes 
      vim.cmd('silent !feh --bg-fill ' .. choice[1])
    end
  end)()
end
```
This one need `termpix` which can be downloaded [here (it is forked)](https://github.com/mmacedoeu/termpix),
the original doesn't work on mine, you might want to use [this one](https://github.com/hopey-dishwasher/termpix) if it's working for you.
See their github page for installation.
```lua
function fzf_wallpaper() -- Poor Man Wallpaper Changer (with preview) using fzf!
  local fzf = require("fzf").fzf
  local action = require "fzf.actions".action
  coroutine.wrap(function()
    local choice = fzf('fd . ~/Pictures -e png -e jpg',
      [[--preview "((termpix --width 70 --true-colour {} > /tmp/termpixdump && cat /tmp/termpixdump) || bat {})"]])
    if choice then
      vim.cmd('silent !feh --bg-fill ' .. choice[1])
    end
  end)()
end

-- With the new update on fzf lua, you can write it like this!
previewers = {
  termpix = {
      cmd             = "termpix",
      args            = "",
      _new            = function() return require 'fzf-lua.previewer'.cmd_async end,
  },
},

-- and create a function like this

function fzf_pictures()
  require('fzf-lua').files({
    -- directory
    cwd       = "~/Pictures", 
    -- or if you have other configuration,
    -- you can specify like
    -- require'core'.directories.picture
    
    prompt    = 'Wallpaper » ',
    previewer = "termpix",
    actions = {
      ["default"]  = function(selected) vim.cmd('silent !feh --bg-fill ' .. selected[2]) end
    }
  })
end

```
And this one is using this to automatically pick your wallpaper, I didn't save your default bg as default, so you might want to consider manual approach.
```lua
function fzf_autowallpaper()
  local fzf = require("fzf").fzf
  local action = require "fzf.actions".action

  coroutine.wrap(function()
    local preview_function = action(function (args)
      if args then
        local wall = args[1]
        vim.cmd("silent !feh --bg-fill " .. wall)
      end
    end)
    local choice = fzf('fd . ~/Pictures -e png -e jpg', "--preview=" .. preview_function .. " --preview-window right:0")
    if choice then
      vim.cmd('silent !feh --bg-fill ' .. choice[1])
    end

  end)()
end
```
