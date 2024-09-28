-- notifications.lua (Dunst version)
local awful = require('awful')
local gears = require('gears')

-- Dunst notification function
local function dunst_notify(title, message, urgency)
  awful.spawn.with_shell(
    string.format(
      "dunstify -t '%s' -m '%s' -u %s",
      title,
      message,
      urgency or "normal"
    )
  )
end

-- Error handling
if _G.awesome.startup_errors then
  dunst_notify(
    'Oops, there were errors during startup!',
    _G.awesome.startup_errors,
    'critical'
  )
end

do
  local in_error = false
  _G.awesome.connect_signal(
    'debug::error',
    function(err)
      if in_error then
        return
      end
      in_error = true

      dunst_notify(
        'Oops, an error happened!',
        tostring(err),
        'critical'
      )
      in_error = false
    end
  )
end

-- Custom logging function
function log_this(title, txt)
  dunst_notify(title, txt)
end