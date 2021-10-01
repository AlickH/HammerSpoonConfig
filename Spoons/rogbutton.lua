local historyModifier = "fn"
local tabModifier = 'shift'

doKeyStroke = function(modifiers, character)
  local event = require("hs.eventtap").event
  event.newKeyEvent(modifiers, string.lower(character), true):post()
  event.newKeyEvent(modifiers, string.lower(character), false):post()
end

detectMouseDown = hs.eventtap.new({
  hs.eventtap.event.types.otherMouseDown,
  hs.eventtap.event.types.leftMouseDown,
  hs.eventtap.event.types.rightMouseDown
}, function(e)
  local button = e:getProperty(
      hs.eventtap.event.properties['mouseEventButtonNumber']
  )
  local modifiers = e:getFlags()
  --print(string.format("Clicked Mouse Button: %i", button))
  if button == 3 and ( modifiers[ historyModifier ] ) then
    doKeyStroke({'cmd'}, ']')
  elseif button == 4 and ( modifiers[ historyModifier ] ) then
    doKeyStroke({'cmd'}, '[')
  elseif button == 4 and ( modifiers[ tabModifier ] ) then
    doKeyStroke({'ctrl-shift'}, 'tab')
  elseif button == 3 and ( modifiers[ tabModifier ] ) then
    doKeyStroke({'ctrl'}, 'tab')
  elseif button == 3 then
    hs.osascript.applescript('tell application "System Events" to key code 124 using {option down}')
  elseif button == 4 then
    hs.osascript.applescript('tell application "System Events" to key code 123 using {option down}')
  end
end)

detectMouseDown:start()