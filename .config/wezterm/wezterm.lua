local wezterm = require 'wezterm';

return {
  default_prog = { "/bin/bash", "-l" },
  font = wezterm.font("Cica"),
  use_ime = true,
  xim_im_name = 'fcitx5',
  font_size = 14.0,
  color_scheme = "nightfox", -- find your favorite theme, https://wezfurlong.org/wezterm/colorschemes/index.html
  hide_tab_bar_if_only_one_tab = false,
  adjust_window_size_when_changing_font_size = false,
  audible_bell = "Disabled",
  disable_default_key_bindings = true,
  enable_tab_bar = true,
  window_background_opacity = 0.6,
  -- defaultだとvimを開いたときなどに余白が生じる
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
  },
  check_for_updates = false,
  mouse_bindings = {
    -- 右クリックでクリップボードから貼り付け
    {
        event = { Down = { streak = 1, button = 'Right' } },
        mods = 'NONE',
        action = wezterm.action.PasteFrom 'Clipboard',
    },
  },
  -- keymap
  keys = {
    {
      key = 't',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SpawnCommandInNewTab {
        domain = 'CurrentPaneDomain'
      },
    },
    {
      key = 'w',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.CloseCurrentTab {
        confirm = false
      },
    },
    {
      key = 'q',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.CloseCurrentPane {
        confirm = false
      }
    },
    {
      key = '_',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitVertical {
        domain = 'CurrentPaneDomain'
      }
    },
    {
      key = '"',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitHorizontal {
        domain = 'CurrentPaneDomain'
      }
    },
    {
      key = 's',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.PaneSelect {
        mode = 'Activate'
      }
    },
    {
      key = '<',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivateTabRelative(-1)
    },
    {
      key = '>',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivateTabRelative(1)
    },
    {
      key = 'r',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.PromptInputLine {
        description = "Enter new name for tab",
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      }
    },
    -- TODO: Copy clipboard text, Google search, translate, etc.
    {
      key = 'c',
      mods = 'CTRL|SHIFT',
      action = wezterm.action_callback(function(window, pane)
        local word = window:get_selection_escapes_for_pane(pane)
        window:copy_to_clipboard(word)
      end)
    },
    {
      key = 'g',
      mods = 'CTRL|SHIFT',
      action = wezterm.action_callback(function(window, pane)
        local word = window:get_selection_escapes_for_pane(pane)
        local search_text, idx = string.gsub(word, ' ', '+')
        window:copy_to_clipboard(word)
        os.execute("open https://google.com/search?q=" .. search_text)
      end)
    }
  },
  colors = {
    tab_bar = {
      -- The color of the strip that goes along the top of the window
      --
      -- (does not apply when fancy tab bar is in use)
      inactive_tab_edge = '#575757',
      -- The active tab is the one that has focus in the window
      active_tab = {
        -- The color of the background area for the tab
        bg_color = '#3b7070',
        -- The color of the text for the tab
        fg_color = '#dcffff',

        -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
        -- label shown for this tab.
        -- The default is "Normal"
        intensity = 'Normal',

        -- Specify whether you want "None", "Single" or "Double" underline for
        -- label shown for this tab.
        -- The default is "None"
        underline = 'None',

        -- Specify whether you want the text to be italic (true) or not (false)
        -- for this tab.  The default is false.
        italic = false,

        -- Specify whether you want the text to be rendered with strikethrough (true)
        -- or not for this tab.  The default is false.
        strikethrough = false,
      },

      -- Inactive tabs are the tabs that do not have focus
      inactive_tab = {
        bg_color = '#5c5c5c',
        fg_color = '#3a3939',

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab`.
      },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over inactive tabs
      inactive_tab_hover = {
        bg_color = '#3b3052',
        fg_color = '#909090',
        italic = true,
        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab_hover`.
      },

      -- The new tab button that let you create new tabs
      new_tab = {
        bg_color = '#808080',
        fg_color = '#4d4d4d',

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `new_tab`.
      },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over the new tab button
      new_tab_hover = {
        bg_color = '#3b3052',
        fg_color = '#909090',
        italic = true,
        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `new_tab_hover`.
      },
    },
  },
}
