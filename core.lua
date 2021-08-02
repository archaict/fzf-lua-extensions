--  FILE  : Core Lua
--  AUTH  : Archaict
--  NOTE  : The Opinionated Configuration file

local M = {}
local codex = M

--  VAULT  : Core Configuration

    codex.core= {
      --  NOTE  : used in nvim-fzf, this part is where you specify
      --          your directories, if you have your own config file
      --          you can specify this like on README.md by using
      --          global variables!
      project_dirs = {
        '~/.config',                  -- Dots
        '~/.config/nvim',             -- Neovim Config
        '~/Dropbox',                  -- Dropbox
        '~/Dropbox/neorg',            -- Neorg
        '~/Dropbox/vault',            -- OrgMode
      }

    } --------------------------------------------------------------- [ KM ] ---

--  KEYMAP:

    Keymaps = {

        -- 'm_autopairs',                  -- Closing the brackets
        'essentials',                 -- Needed to reduce annoyance
        'movement',                   -- Movementes in NVI mode
        'shifting',                   -- Indentation and up down
        'tabs',                       -- Moving between tabs
        'buffers',                    -- Moving between buffers
        'sessions',                   -- Session management
        'terminal',                   -- Terminal movements
        'window',                     -- Navigate splits
        'quit',                       -- Do you need more desc?
        'files',
        'help',
        -- 'netrw',                      -- Navigation from netrw
        'optional',                   -- Extra stuff
        'telescope',
        'nvimfzf',
        'commentary',
        'lspsaga',

    } --------------------------------------------------------------- [ KM ] ---

--  THEMES:

    codex.highlights = { -------------------------------------------------------

        comment = true,
        transparency = true,

    } --------------------------------------------------------------- [ KM ] ---

--  MODULE:

    codex.modules = {

      leader = true;
      builtins = {
        netrw = true;
        statusline = true;
      },

      plugins ={
        -- Colorschemes
        { 'srcery-colors/srcery-vim' },
        { 'arcticicestudio/nord-vim' },
      }

    } --------------------------------------------------------------- [ MD ] ---

--  OBSTRC:
    codex.disabled={

      builtins = {
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "gzip",
        "zip",
        "zipPlugin",
        "tar",
        "tarPlugin",
        "get",
        "getPlugin",
        "vimball",
        "vimballPlugin",
        "2html_plugin",
        "logipat",
        "rrhelper",
        "spellfile_plugin",
        "matchit",
      },

      plugin = {
      },

    } --------------------------------------------------------------- [ DB ] ---



return codex
-- if need more info for this, all of this will be published in
-- neo-maxivimist, stay tuned for updates!
