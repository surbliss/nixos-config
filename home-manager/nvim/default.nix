{
  pkgs,
  inputs,
  # vimUtils,
  # lib,
  ...
}:
{
  nixpkgs = {
    overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins // {
          own-isabelle-syn = prev.vimUtils.buildVimPlugin {
            name = "isabelle-syn";
            src = inputs.plugin-isabelle-syn;
          };
        };
      })
    ];
  };

  xdg.configFile.nvim = {
    # enable = true;
    source = ./.;
    recursive = true;
  };

  # For nixd:
  # makes sure that <nixpkgs> refers to actual nixpkgs used for system
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  # NOTE: If you make an init.lua in ./nvim, then below code doesn't run.
  # But the above lets us have an after/ftplugin/ folder!!!
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    defaultEditor = true;
    vimAlias = true;
    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
      ${builtins.readFile ./commands.lua}
      ${builtins.readFile ./keymaps.lua}
    '';

    extraPackages = with pkgs; [
      # LSPs
      lua-language-server
      ### Replaced by nixd
      # nil
      nixd
      nixfmt-rfc-style
      # HACK: Only until https://github.com/neovim/neovim/pull/29601
      # is merged
      # alejandra
      # nixfmt-rfc-style
      fsautocomplete # FIX: Virker ikke :/

      # For copilot
      luajitPackages.tiktoken_core

      ### To fix haskell-lsp for xmonad
      (haskellPackages.ghcWithPackages (
        hpkgs: with hpkgs; [
          # xmobar
          xmonad
          xmonad-contrib
          # haskell-language-server
          # fast-tags
          # hoogle
          # haskell-debug-adapter
          # fourmolu
        ]
      ))
      haskellPackages.fourmolu
      haskellPackages.hoogle
      haskellPackages.haskell-language-server

      # ccls
      clang-tools_19 # clangd + clang-format

      # (python3.withPackages (
      (python3.withPackages (
        python-pkgs: with python-pkgs; [
          # select Python packages here
          # pandas
          # requests
          torch
          torchvision
          numpy
          scikit-learn
          matplotlib
          # sklearn-deap

          ### LSP-stuff:
          python-lsp-server
          rope
          pyflakes
          mccabe
          pycodestyle
          # pydocstyle
          yapf
          flake8
          pylint
        ]
      ))

      tree-sitter
      ### FOR GITHUB PLUGIN BELOW! nodejs
      nodejs

      ### Til fsharp
      # mono
    ];
    # NOTE: Options for each plugin (see
    # https://github.com/nix-community/home-manager/blob/release-24.05/modules/programs/neovim.nix):
    # config (string): Configuration for plugin type ("lua", "viml", "teal" or
    # "fennel"): . Configuration language for cconfigure optional (bool):
    # Whether to load plugin automatically, otherwise use ":packadd" plugin
    # (string): Name of plugin, automatically passed when writing a string
    # rather than a table runtime (table): Files linked in nvim config folder,
    # can be used with ftplugin Use 'map' to set default 'type' for plugins
    plugins =
      with pkgs.vimPlugins;
      map (plugin: plugin // { type = plugin.type or "lua"; }) [
        # NOTE: 'opts' options in lazy.nvim config corresponds to passing the
        # options to '<Plugin>.config()' function.

        {
          plugin = nvim-surround;
          config =
            # lua
            ''
              require('nvim-surround').setup({ keymaps = { visual = false, }, })
            '';
        }

        {
          plugin = catppuccin-nvim;
          # Same as 'catppuccin'
          config = "vim.cmd.colorscheme 'catppuccin-mocha'";
        }

        vim-nix

        # {
        #   plugin = autoclose-nvim;
        #   config =
        #     #lua
        #     ''
        #       require('autoclose').setup({
        #         keys = {
        #           ["'"] = { disabled_filetypes = { "nix" } }
        #         },
        #         options = {
        #           disabled_filetypes = { "tex" },
        #         },
        #       })
        #     '';
        #   #config = /* lua */ ''
        #   #''
        # }

        {
          plugin = nvim-autopairs;
          config = # lua
            ''
              require('nvim-autopairs').setup({
                disable_filetype = {'tex'}
              })
            '';
        }

        #FIX: neodev virker ikke i home-manger/nvim mappe.
        neodev-nvim # Archived, consider 'lazydev.nvim' instead

        # Snippets and autocomplete
        luasnip
        cmp_luasnip
        cmp-path
        {
          plugin = nvim-cmp;
          config = "${builtins.readFile ./lua/plugins/autocompletion.lua}";
        }

        cmp-nvim-lsp
        {
          plugin = nvim-lspconfig;
          config = "${builtins.readFile ./lua/plugins/lsp.lua}";
        }

        # Needs to be configured...
        nvim-dap

        # Virker ikke med nvim-hmts :/
        nvim-treesitter-textobjects
        # nvim-treesitter-context # This one sucks :/
        # OR DOES IT?
        nvim-treesitter-refactor
        {
          plugin = nvim-treesitter.withAllGrammars;
          # plugin = (
          #   nvim-treesitter.withPlugins (p: [
          #     p.tree-sitter-nix
          #     p.tree-sitter-vim
          #     p.tree-sitter-lua
          #     p.tree-sitter-bash
          #     p.tree-sitter-c
          #     p.tree-sitter-rasi # rofi syntax, maybe not needed
          #     p.tree-sitter-haskell
          #     p.tree-sitter-python
          #   ])
          # );
          config = "${builtins.readFile ./lua/plugins/treesitter.lua}";
        }

        kmonad-vim # syntax-highlighting for .kbd files

        vim-repeat

        {
          plugin = leap-nvim;
          config =
            # lua
            ''
              require('leap').create_default_mappings()
              require('leap.user').set_repeat_keys('<enter>', '<backspace>')
              vim.keymap.set('n',        's', '<Plug>(leap)')
              vim.keymap.set('n',        'S', '<Plug>(leap-from-window)')
              vim.keymap.set({'x', 'o'}, 's', '<Plug>(leap-forward)')
              vim.keymap.set({'x', 'o'}, 'S', '<Plug>(leap-backward)')
            '';
        }

        # {
        #   plugin = flash-nvim;
        #   config = "${builtins.readFile ./plugins/flash.lua}";
        # }

        {
          plugin = oil-nvim;
          config =
            # lua
            "require('oil').setup()";
        }

        # plenary-nvim
        {
          #NOTE: Possible commands: NOTE, FIX, TOD, HACK, WARN, PERF & TEST.
          plugin = todo-comments-nvim;
          config =
            # lua
            ''
              require('todo-comments').setup()
              vim.keymap.set("n", "]t", function()
              require("todo-comments").jump_next({
                keywords = { "TODO", "HACK", "WARN", "FIX", "PERF" }
              })
              end, { desc = "Next error/warning todo comment" })
              vim.keymap.set("n", "[t", function()
              require("todo-comments").jump_prev({
                keywords = { "TODO", "HACK", "WARN", "FIX", "PERF"}
              })
              end, { desc = "Next error/warning todo comment" })
            '';
        }

        {
          plugin = vimtex;
          config = "vim.g.vimtex_view_method = 'zathura'";
        }

        # hmts-nvim

        # Måske senere, når behovet rammer:
        # telekasten-nvim
        # markdown-preview-nvim
        # harpoon
        # neorg
        # sideways (lav med treesitter i stedet)
        # vim-orgmode (logseq i stedet)

        # Behøves ikk:
        # conform
        # colorscheme

        # Mangler (ik på nixpkgs)
        # scrollEOF

        ### Resterende, fra nvim/lua/angryluck/plugins:
        #
        ### completion.lua
        #
        ### git.lua
        # vim-fugitive
        # vim-rhubarb
        # gitsigns-nvim

        # Keybinds defined in nvim/after/ftplugin/haskell.lua:
        # Replaced with haskell-language-server for now
        haskell-tools-nvim

        Ionide-vim
        markdown-preview-nvim

        # code formatter:
        {
          plugin = conform-nvim;
          config = "${builtins.readFile ./lua/plugins/conform.lua}";
        }

        #zarchive-vim-fsharp
        ### NEED TO ADD STUDENT MAIL TO GITHUB FIRST!
        {
          plugin = CopilotChat-nvim;
          config =
            # lua
            ''
              local chat = require('CopilotChat')
              chat.setup({
                -- debug = true,
                window = {
                  layout = 'horizontal',
                  height = 0.382, -- golden ratio
                  -- relative = 'editor',
                  -- border = 'rounded',
                },
                model = 'claude-3.5-sonnet',
                auto_insert_mode = true,
              })
              vim.keymap.set('n', '<leader>co', chat.open, {silent = true})
              vim.keymap.set('n', '<leader>ce', ':CopilotChatExplain<CR>', {silent = true})
              vim.keymap.set('n', '<leader>cf', ':CopilotChatFix<CR>', {silent = true})
              vim.keymap.set('n', '<leader>cr', ':CopilotChatReview<CR>', {silent = true})
              -- with argument:
              -- vim.keymap.set('n', '<leader>co', function() chat.open('your_argument') end)
              -- or
              -- vim.api.nvim_set_keymap('n', '<leader>co', ':lua chat.open('argument')<CR>)

            '';
        }
        {
          plugin = copilot-lua;
          config = "require('copilot').setup({})";
        }
        plenary-nvim

        nvim-web-devicons
        telescope-fzf-native-nvim
        telescope-ui-select-nvim
        {
          plugin = telescope-nvim;
          config = "${builtins.readFile ./lua/plugins/telescope.lua}";
        }
        # Optional dependencies (define above):
        # fd
        # nvim-treesitter

        ## herunder:
        # telescope-fzf-native-nvim
        # telescope-ui-select-nvim
        # nvim-web-devicons
        # telescope-emoji-nvim (mangler fra nixpkgs)
        #
        # vim-template
        #
        # which-key-nvim (mangler fra nixpkgs)

        {
          plugin = nvim-colorizer-lua;
          config =
            # lua
            ''
              require('colorizer').setup({
                user_default_options = { names = false }
              })
            '';
        }

        # Defined through overlay up top
        # isabelle-lsp.lua (skal stadig have det til at virke)
        own-isabelle-syn
        # (plugin "Treeniks/isabelle-lsp.nvim")

        {
          plugin = tabout-nvim;
          config =
            # lua
            ''
              require('tabout').setup {
                tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
                backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
                act_as_tab = true, -- shift content if tab out is not possible
                act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
                default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
                default_shift_tab = '<C-d>', -- reverse shift default action,
                enable_backwards = true, -- well ...
                completion = false, -- if the tabkey is used in a completion pum
                tabouts = {
                  { open = "'", close = "'" },
                  { open = '"', close = '"' },
                  { open = '`', close = '`' },
                  { open = '(', close = ')' },
                  { open = '[', close = ']' },
                  { open = '{', close = '}' }
                },
                ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
                exclude = {} -- tabout will ignore these filetypes
              }
            '';
        }

        futhark-vim
      ];
  };
}
