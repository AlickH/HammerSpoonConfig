-- Rescue Windows
-- Move any windows that are off-screen onto the main screen
function rescueWindows()
    local screen = hs.screen.mainScreen()
    local screenFrame = screen:fullFrame()
    local wins = hs.window.visibleWindows("Safari 浏览器")
    for i,win in ipairs(wins) do
        local frame = win:frame()
        if not frame:inside(screenFrame) then
            win:moveToScreen(screen, true, true)
        end
    end
end

hs.hotkey.bind({"Shift"}, "tab", rescueWindows)