_: {
  vim = {
    viAlias = true;
    vimAlias = true;

    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    lineNumberMode = "relNumber";
    preventJunkFiles = true;
    undoFile.enable = true;
    searchCase = "smart";
    hideSearchHighlight = true;

    clipboard = {
      enable = true;
      registers = "unnamedplus";
    };

    options = {
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;
      shiftround = true;

      scrolloff = 4;
      sidescrolloff = 8;
      wrap = true;
      cursorline = true;
      # Necessary for #ffc777 line number (fights nvf's defaults)
      cursorlineopt = "both";
      splitbelow = true;
      splitright = true;
      splitkeep = "screen";

      laststatus = 3;
      cmdheight = 0;
      showmode = false;
      signcolumn = "yes";
      pumheight = 10;
      pumblend = 10;
      winblend = 0;
      conceallevel = 2;

      confirm = true;
      updatetime = 200;
      timeoutlen = 300;
      virtualedit = "block";
      termguicolors = true;

      # foldlevel defaults to 0, which opens every file fully collapsed.
      foldenable = true;
      foldlevel = 99;
      foldlevelstart = 99;
      foldcolumn = "0";
    };

    keymaps = [
      # --- Files and buffers ---
      {
        key = "<S-h>";
        mode = "n";
        action = "<cmd>BufferLineCyclePrev<cr>";
        silent = true;
        desc = "Previous buffer";
      }
      {
        key = "<S-l>";
        mode = "n";
        action = "<cmd>BufferLineCycleNext<cr>";
        silent = true;
        desc = "Next buffer";
      }
      {
        key = "<leader>bb";
        mode = "n";
        action = "<cmd>e #<cr>";
        silent = true;
        desc = "Switch to other buffer";
      }
      {
        key = "<leader>bd";
        mode = "n";
        action = "function() require('mini.bufremove').delete(0, false) end";
        lua = true;
        silent = true;
        desc = "Delete buffer";
      }
      {
        key = "<leader>bD";
        mode = "n";
        action = "function() require('mini.bufremove').delete(0, true) end";
        lua = true;
        silent = true;
        desc = "Delete buffer (force)";
      }
      {
        key = "<leader>bo";
        mode = "n";
        # delete() is non-force, so a modified buffer is kept and reported
        # rather than silently discarded.
        action = ''
          function()
            local current = vim.api.nvim_get_current_buf()
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if buf ~= current and vim.bo[buf].buflisted then
                require('mini.bufremove').delete(buf, false)
              end
            end
          end
        '';
        lua = true;
        silent = true;
        desc = "Delete other buffers";
      }
      {
        key = "<leader>qq";
        mode = "n";
        action = "<cmd>qa<cr>";
        silent = true;
        desc = "Quit all";
      }

      # --- Window navigation and splits ---
      {
        key = "<C-h>";
        mode = "n";
        action = "<C-w>h";
        silent = true;
        desc = "Go to left window";
      }
      {
        key = "<C-j>";
        mode = "n";
        action = "<C-w>j";
        silent = true;
        desc = "Go to lower window";
      }
      {
        key = "<C-k>";
        mode = "n";
        action = "<C-w>k";
        silent = true;
        desc = "Go to upper window";
      }
      {
        key = "<C-l>";
        mode = "n";
        action = "<C-w>l";
        silent = true;
        desc = "Go to right window";
      }
      {
        key = "<leader>-";
        mode = "n";
        action = "<C-w>s";
        silent = true;
        desc = "Split window below";
      }
      {
        key = "<leader>|";
        mode = "n";
        action = "<C-w>v";
        silent = true;
        desc = "Split window right";
      }
      {
        key = "<leader>wd";
        mode = "n";
        action = "<C-w>c";
        silent = true;
        desc = "Delete window";
      }

      # --- Resize with arrows ---
      {
        key = "<C-Up>";
        mode = "n";
        action = "<cmd>resize +2<cr>";
        silent = true;
        desc = "Increase window height";
      }
      {
        key = "<C-Down>";
        mode = "n";
        action = "<cmd>resize -2<cr>";
        silent = true;
        desc = "Decrease window height";
      }
      {
        key = "<C-Left>";
        mode = "n";
        action = "<cmd>vertical resize -2<cr>";
        silent = true;
        desc = "Decrease window width";
      }
      {
        key = "<C-Right>";
        mode = "n";
        action = "<cmd>vertical resize +2<cr>";
        silent = true;
        desc = "Increase window width";
      }

      # --- Move lines ---
      {
        key = "<A-j>";
        mode = "n";
        action = "<cmd>m .+1<cr>==";
        silent = true;
        desc = "Move line down";
      }
      {
        key = "<A-k>";
        mode = "n";
        action = "<cmd>m .-2<cr>==";
        silent = true;
        desc = "Move line up";
      }
      {
        key = "<A-j>";
        mode = "v";
        action = ":m '>+1<cr>gv=gv";
        silent = true;
        desc = "Move selection down";
      }
      {
        key = "<A-k>";
        mode = "v";
        action = ":m '<-2<cr>gv=gv";
        silent = true;
        desc = "Move selection up";
      }

      # --- Quality of life ---
      {
        key = "<esc>";
        mode = [
          "i"
          "n"
        ];
        action = "<cmd>noh<cr><esc>";
        silent = true;
        desc = "Clear search highlight";
      }
      {
        key = "<";
        mode = "v";
        action = "<gv";
        silent = true;
        desc = "Dedent and keep selection";
      }
      {
        key = ">";
        mode = "v";
        action = ">gv";
        silent = true;
        desc = "Indent and keep selection";
      }
      {
        key = "j";
        mode = [
          "n"
          "x"
        ];
        action = "v:count == 0 ? 'gj' : 'j'";
        expr = true;
        silent = true;
        desc = "Down";
      }
      {
        key = "k";
        mode = [
          "n"
          "x"
        ];
        action = "v:count == 0 ? 'gk' : 'k'";
        expr = true;
        silent = true;
        desc = "Up";
      }
      {
        key = "n";
        mode = "n";
        action = "nzzzv";
        silent = true;
        desc = "Next search result";
      }
      {
        key = "N";
        mode = "n";
        action = "Nzzzv";
        silent = true;
        desc = "Previous search result";
      }
    ];
  };
}
