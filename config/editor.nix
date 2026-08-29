{ pkgs, ... }: {
  vim = {
    # nvf pins other tools by store path in the generated Lua; these two are
    # looked up on PATH at runtime.
    extraPackages = with pkgs; [
      direnv
      fd
    ];

    treesitter = {
      enable = true;
      fold = true;
      indent.enable = true;
      textobjects.enable = true;
    };

    # --- Picker -------------------------------------------------------------
    fzf-lua = {
      enable = true;
      profile = "telescope";
      setupOpts = {
        # The telescope profile sets --layout=default, which fills the window
        # bottom-up with the prompt on the last line.
        fzf_opts."--layout" = "reverse";
      };
    };

    # --- File tree ----------------------------------------------------------
    filetree.neo-tree = {
      enable = true;
      setupOpts = {
        close_if_last_window = true;
        filesystem = {
          follow_current_file.enabled = true;
          hijack_netrw_behavior = "open_default";
          filtered_items = {
            visible = true;
            hide_dotfiles = false;
            hide_gitignored = true;
          };
        };
        window.width = 32;
      };
    };

    # --- Git ----------------------------------------------------------------
    git = {
      enable = true;
      gitsigns.enable = true;
    };

    # --- Motions and text objects -------------------------------------------
    utility = {
      motion.flash-nvim.enable = true;

      surround = {
        enable = true;
        useVendoredKeybindings = true;
      };

      direnv.enable = true;

      grug-far-nvim.enable = true;

      diffview-nvim.enable = true;
      undotree.enable = true;

      sleuth.enable = true;
    };

    mini.bufremove.enable = true;

    comments.comment-nvim.enable = true;
    autopairs.nvim-autopairs.enable = true;
    notes.todo-comments.enable = true;
    snippets.luasnip.enable = true;

    # --- Completion ---------------------------------------------------------
    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
      setupOpts.signature.enabled = true;
    };

    # --- Terminal and sessions ----------------------------------------------
    terminal.toggleterm = {
      enable = true;
      setupOpts.direction = "float";
      lazygit.enable = true;
    };

    session.persisted.enable = true;
    projects.project-nvim.enable = true;

    # --- Keymaps ------------------------------------------------------------
    # Lua actions must be wrapped in `function() ... end`: a bare
    # `require('fzf-lua').files` runs the require at startup, defeating lazy
    # loading and capturing the module before setup() has run.
    keymaps = [
      # File tree
      {
        key = "<leader>e";
        mode = "n";
        action = "<cmd>Neotree toggle<cr>";
        silent = true;
        desc = "Toggle file explorer";
      }
      {
        key = "<leader>E";
        mode = "n";
        action = "<cmd>Neotree reveal<cr>";
        silent = true;
        desc = "Reveal current file in explorer";
      }

      # Find (files)
      {
        key = "<leader><space>";
        mode = "n";
        action = "function() require('fzf-lua').files() end";
        lua = true;
        silent = true;
        desc = "Find files";
      }
      {
        key = "<leader>fr";
        mode = "n";
        action = "function() require('fzf-lua').oldfiles() end";
        lua = true;
        silent = true;
        desc = "Recent files";
      }
      {
        key = "<leader>fb";
        mode = "n";
        action = "function() require('fzf-lua').buffers() end";
        lua = true;
        silent = true;
        desc = "Buffers";
      }
      {
        key = "<leader>fg";
        mode = "n";
        action = "function() require('fzf-lua').git_files() end";
        lua = true;
        silent = true;
        desc = "Find git files";
      }

      # Search (grep and friends)
      {
        key = "<leader>/";
        mode = "n";
        action = "function() require('fzf-lua').live_grep() end";
        lua = true;
        silent = true;
        desc = "Grep in project";
      }
      {
        key = "<leader>sw";
        mode = [
          "n"
          "x"
        ];
        action = "function() require('fzf-lua').grep_cword() end";
        lua = true;
        silent = true;
        desc = "Grep word under cursor";
      }
      {
        key = "<leader>sb";
        mode = "n";
        action = "function() require('fzf-lua').lgrep_curbuf() end";
        lua = true;
        silent = true;
        desc = "Grep in current buffer";
      }
      {
        key = "<leader>sh";
        mode = "n";
        action = "function() require('fzf-lua').helptags() end";
        lua = true;
        silent = true;
        desc = "Help pages";
      }
      {
        key = "<leader>sk";
        mode = "n";
        action = "function() require('fzf-lua').keymaps() end";
        lua = true;
        silent = true;
        desc = "Keymaps";
      }
      {
        key = "<leader>sd";
        mode = "n";
        action = "function() require('fzf-lua').diagnostics_document() end";
        lua = true;
        silent = true;
        desc = "Document diagnostics";
      }
      {
        key = "<leader>sD";
        mode = "n";
        action = "function() require('fzf-lua').diagnostics_workspace() end";
        lua = true;
        silent = true;
        desc = "Workspace diagnostics";
      }
      {
        key = "<leader>sc";
        mode = "n";
        action = "function() require('fzf-lua').commands() end";
        lua = true;
        silent = true;
        desc = "Commands";
      }
      {
        key = "<leader>sR";
        mode = "n";
        action = "function() require('fzf-lua').resume() end";
        lua = true;
        silent = true;
        desc = "Resume last picker";
      }
      {
        key = "<leader>sr";
        mode = [
          "n"
          "x"
        ];
        action = "<cmd>GrugFar<cr>";
        silent = true;
        desc = "Search and replace in project";
      }

      # Git
      {
        key = "<leader>gs";
        mode = "n";
        action = "function() require('fzf-lua').git_status() end";
        lua = true;
        silent = true;
        desc = "Git status";
      }
      {
        key = "<leader>gb";
        mode = "n";
        action = "function() require('gitsigns').blame() end";
        lua = true;
        silent = true;
        desc = "Git blame (file)";
      }
      {
        key = "<leader>gB";
        mode = "n";
        action = "function() require('fzf-lua').git_branches() end";
        lua = true;
        silent = true;
        desc = "Git branches";
      }
      {
        key = "<leader>gc";
        mode = "n";
        action = "function() require('fzf-lua').git_commits() end";
        lua = true;
        silent = true;
        desc = "Git commits";
      }
      {
        key = "<leader>gd";
        mode = "n";
        action = "<cmd>DiffviewOpen<cr>";
        silent = true;
        desc = "Diff view";
      }

      # UI toggles
      {
        key = "<leader>tu";
        mode = "n";
        action = "<cmd>UndotreeToggle<cr>";
        silent = true;
        desc = "Toggle undo tree";
      }
    ];
  };
}
