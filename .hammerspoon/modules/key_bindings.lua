local key_bindings = {}
local logger = hs.logger.new("key_bindings.lua", "debug")

local console_apps = {
  ["Terminal"] = false,
  ["iTerm2"] = true,
  ["WezTerm"] = true,
}

local special_combos = {
  c = false,
  v = false,
  space = true,
}

-- コンソールアプリ以外でCtrl,Cmdキーの入れ替えを行う
local function swapCmdCtrl(event)
  local flags = event:getFlags()
  local key_code = event:getKeyCode()
  local key_char = hs.keycodes.map[key_code]
  
  local front_app = hs.application.frontmostApplication()

  if console_apps[front_app:name()] and flags["cmd"] then
    if special_combos[key_char] then
      return false
    end
    
    local modifier_keys = {"ctrl"}

    if flags["shift"] then
      modifier_keys[#modifier_keys + 1] = "shift"
    end
    if flags["alt"] then
      modifier_keys[#modifier_keys + 1] = "alt"
    end
    hs.eventtap.event.newKeyEvent(modifier_keys, key_char, true):post()
    hs.eventtap.event.newKeyEvent(modifier_keys, key_char, false):post()
    return true
  end

  return false
end

function key_bindings.start()
  key_bindings.eventtap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, swapCmdCtrl)
  key_bindings.eventtap:start()
end


function key_bindings.stop()
  if key_bindings.eventtap then
    key_bindings.eventtap:stop()
    key_bindings.eventtap = nil
  end
end

return key_bindings

