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

        codeAction = "<leader>ca";
        renameSymbol = "<leader>cr";
        format = "<leader>cf";
        toggleFormatOnSave = "<leader>uf";

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
        lsp.servers = ["nixd"];
        format.type = ["nixfmt"];
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
        format.type = ["stylua"];
        extensions.lazydev.enable = true;
      };
    };

    keymaps = [
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
