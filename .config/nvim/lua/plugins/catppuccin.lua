return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      flavour = 'auto',
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = false,
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { 'italic' },
        conditionals = { 'italic' },
        loops = {},
        functions = { 'bold' },
        keywords = { 'bold' },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        miscs = {},  -- Uncomment to turn off hard-coded styles
      },
      color_overrides = {
        all = {
          base = '#282828',
          mantle = '#282828',
          crust = '#282828',
        }
      },
      custom_highlights = {},
      default_integrations = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
      }
    })
    vim.cmd.colorscheme 'catppuccin'
  end,
}
