_: {
  vim = {
    theme = {
      enable = true;
      name = "tokyonight";
      style = "moon";
      transparent = true;
    };

    # Increase visibility of line numbers
    highlight = {
      LineNr = {
        fg = "#737aa2";
        bg = "NONE";
      };
      LineNrAbove.link = "LineNr";
      LineNrBelow.link = "LineNr";
      CursorLineNr = {
        fg = "#ffc777";
        bg = "NONE";
        bold = true;
      };
    };

    statusline.lualine = {
      enable = true;
      globalStatus = true;

      # Drops the '▎' separator nvf puts before the mode.
      activeSection.a = [
        ''
          {
            "mode",
            icons_enabled = true,
            separator = {left = ''', right = '''},
          }
        ''
      ];
    };

    tabline.nvimBufferline = {
      enable = true;
      setupOpts.options = {
        always_show_bufferline = false;
        diagnostics = "nvim_lsp";
        numbers = "none";
        offsets = [
          {
            filetype = "neo-tree";
            text = "Neo-tree";
            highlight = "Directory";
            text_align = "left";
          }
        ];
      };
    };

    dashboard.dashboard-nvim.enable = true;

    ui = {
      borders = {
        enable = true;
        globalStyle = "rounded";
      };

      # fidget already renders LSP progress; enabling noice's too double-popups
      # every notification.
      noice = {
        enable = true;
        setupOpts.lsp.progress.enabled = false;
      };

      illuminate.enable = true;

      colorizer.enable = true;
    };

    notify.nvim-notify.enable = true;

    visuals = {
      nvim-web-devicons.enable = true;
      indent-blankline.enable = true;
      fidget-nvim.enable = true;
      rainbow-delimiters.enable = true;
      highlight-undo.enable = true;
    };

    binds.whichKey.enable = true;
  };
}
