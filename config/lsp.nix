_: {
  vim = {
    lsp = {
      enable = true;
      formatOnSave = true;
      inlayHints.enable = true;
      lspkind.enable = true;
      trouble.enable = true;

      mappings = {
        goToDefinition = "gd";
        goToDeclaration = "gD";
        goToType = "gy";
        listImplementations = "gI";
        listReferences = "gr";
        listDocumentSymbols = "<leader>ss";
        listWorkspaceSymbols = "<leader>sS";

        hover = "K";
        signatureHelp = "gK";

        # Bound under `keymaps` below instead.
        codeAction = null;
        renameSymbol = "<leader>cr";

        format = null;
        toggleFormatOnSave = null;

        nextDiagnostic = "]d";
        previousDiagnostic = "[d";
        openDiagnosticFloat = "<leader>cd";
      };
    };

    diagnostics = {
      enable = true;
      config = {
        underline = true;
        update_in_insert = false;
        virtual_text = true;
        signs = true;
      };
    };

    formatter.conform-nvim.enable = true;

    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      nix = {
        enable = true;
        lsp.servers = [ "nixd" ];
        format.type = [ "nixfmt" ];
        extraDiagnostics = {
          enable = true;
          types = [
            "statix"
            "deadnix"
          ];
        };
      };

      lua = {
        enable = true;
        format.type = [ "stylua" ];
        extensions.lazydev.enable = true;
      };

      clang = {
        enable = true;
        # Parse .h as C rather than C++; without this the treesitter parser and
        # clangd disagree about headers in a pure C project.
        cHeader = true;
        lsp.servers = [ "clangd" ];
        format.type = [ "clang-format" ];
        extraDiagnostics = {
          enable = true;
          types = [ "clangtidy" ];
        };
      };

      markdown = {
        enable = true;
        lsp.enable = true;
        format.enable = true;
        extensions.render-markdown-nvim.enable = true;
      };

      python = {
        enable = true;
        # basedpyright for types and navigation, ruff as a second server for lints.
        lsp.servers = [
          "basedpyright"
          "ruff"
        ];
        # conform runs these in list order: lint autofixes, then formatting.
        format.type = [
          "ruff-fix"
          "ruff"
        ];
      };
    };

    keymaps = [
      {
        key = "<leader>ca";
        mode = [
          "n"
          "v"
        ];
        action = "function() require('fzf-lua').lsp_code_actions() end";
        lua = true;
        silent = true;
        desc = "Code action";
      }

      # --- Formatting ---------------------------------------------------------
      {
        key = "<leader>cf";
        mode = [
          "n"
          "v"
        ];
        action = ''
          function()
            local conform = require('conform')
            local formatters, lsp = conform.list_formatters_to_run(0)
            local names = vim.tbl_map(function(f) return f.name end, formatters)
            if lsp then
              table.insert(names, 'LSP')
            end
            local with = #names > 0 and table.concat(names, ', ') or 'no formatter'

            conform.format({ lsp_format = 'fallback', timeout_ms = 3000, quiet = true }, function(err, did_edit)
              if err then
                vim.notify(err, vim.log.levels.ERROR, { title = 'Format' })
              elseif did_edit then
                vim.notify('Formatted with ' .. with, vim.log.levels.INFO, { title = 'Format' })
              else
                vim.notify('Already formatted (' .. with .. ')', vim.log.levels.INFO, { title = 'Format' })
              end
            end)
          end
        '';
        lua = true;
        silent = true;
        desc = "Format buffer or selection";
      }
      {
        key = "<leader>tf";
        mode = "n";
        action = ''
          function()
            vim.b.disableFormatSave = not vim.b.disableFormatSave
            if vim.b.disableFormatSave then
              vim.notify('Format on save: off (buffer)', vim.log.levels.WARN, { title = 'Format' })
            elseif vim.g.formatsave then
              vim.notify('Format on save: on (buffer)', vim.log.levels.INFO, { title = 'Format' })
            else
              vim.notify('Format on save: on (buffer), but off globally', vim.log.levels.WARN, { title = 'Format' })
            end
          end
        '';
        lua = true;
        silent = true;
        desc = "Toggle format on save";
      }

      {
        key = "<leader>xx";
        mode = "n";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        silent = true;
        desc = "Diagnostics (Trouble)";
      }
      {
        key = "<leader>xX";
        mode = "n";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
        silent = true;
        desc = "Buffer diagnostics (Trouble)";
      }
      {
        key = "<leader>xs";
        mode = "n";
        action = "<cmd>Trouble symbols toggle<cr>";
        silent = true;
        desc = "Symbols (Trouble)";
      }
      {
        key = "<leader>xt";
        mode = "n";
        action = "<cmd>TodoTrouble<cr>";
        silent = true;
        desc = "Todo list (Trouble)";
      }
      {
        key = "<leader>xq";
        mode = "n";
        action = "<cmd>Trouble qflist toggle<cr>";
        silent = true;
        desc = "Quickfix list (Trouble)";
      }
    ];
  };
}
