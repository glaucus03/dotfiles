local key_bindings = require "modules.key_bindings"
local window_management = require "modules.window_manager"

-- keyBindigsを有効化する
key_bindings.start()

hs.reload = function()
  key_bindings.stop()
  hs.reload()
end
--
-- window_managementのキーバインディングを有効化する
hs.hotkey.bind({"option"}, "Left", window_management.moveWindowLeft)
hs.hotkey.bind({"option"}, "Right", window_management.moveWindowRight)
hs.hotkey.bind({"option"}, "Up", window_management.maximizeWindow)
hs.hotkey.bind({"optionn"}, "Down", window_management.minimizeWindow)
hs.hotkey.bind({"option", "shift"}, "Left", window_management.moveWindowNextScreen)
hs.hotkey.bind({"option", "shift"}, "Right", window_management.moveWindowPrevScreen)
