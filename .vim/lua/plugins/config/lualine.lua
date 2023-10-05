require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    colored = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {
      {
        'filename',
        path = 1,
        file_status = true,
        shorting_target = 40,
        symbols = {
          modified = ' [+]',
          readonly = ' [RO]',
          unnamed = 'Untitled',
        }
      }
    },
    lualine_x = {'filetype', 'encoding'},
    lualine_y = {
      {
        'diagnostics',
        source = {'nvim_lsp', 'nvim_diagnostic'},
      }
    },
    lualine_z = {
      'location',
      'progress'
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {
      {
        'buffers',
        mode=4,
        icons_enabled=true,
        show_filename_only=true,
        hide_filename_extensions=false
      }
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'tabs'}
  },
  extensions = {}
}
