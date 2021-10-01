local historyModifier = "fn"
local tabModifier = 'shift'
doKeyStroke = function(modifiers, character)
    local event = require("hs.eventtap").event
    event.newKeyEvent(modifiers, string.lower(character), true):post()
    event.newKeyEvent(modifiers, string.lower(character), false):post()
end

hs.eventtap.new({hs.eventtap.event.types.scrollWheel}, function(e)
    local modifiers = e:getFlags()
    scrollWheelClick = e:getProperty(hs.eventtap.event.properties.scrollWheelEventDeltaAxis1)
    if scrollWheelClick > 0 and ( modifiers[ historyModifier ] ) then
        doKeyStroke({'cmd'}, ']')
    elseif scrollWheelClick < 0 and ( modifiers[ historyModifier ] ) then
        doKeyStroke({'cmd'}, '[')
    elseif scrollWheelClick < 0 and ( modifiers[ tabModifier ] ) then
        doKeyStroke({'ctrl-shift'}, 'tab')
    elseif scrollWheelClick > 0 and ( modifiers[ tabModifier ] ) then
        doKeyStroke({'ctrl'}, 'tab')
    end
end):start()