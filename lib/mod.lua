local mod = require 'core/mods'
local cron_file = _path.data.."cron/crontab"

mod.hook.register("system_post_startup", "cron setup", function()
  local starter = [[# load this file into the system crontab every minute
  # deleting this will prevent changes from being executed
  * * * * * crontab "..file.."\n
  
  ]]
  
  if not util.file_exists(_path.data.."cron") then
    print('creating data folder')
    os.make_dir(_path.data.."cron")
  end
  
  if not util.file_exists(cron_file) then
    print('creating crontab')
    os.execute("touch "..cron_file)
    local f = io.open(cron_file, "a")
    io.output(f)
    io.write(starter)
    io.close(f)
  end
end)


-- set up mod menu
-- TODO: check if cron file includes self-update
-- TODO: show os time zone

local m = {}

m.key = function(n, z)
  if n == 2 and z == 1 then
    -- return to the mod selection menu
    mod.menu.exit()
  end
  if n==3 and z==1 then
    -- force crontab update
    os.execute("crontab "..cron_file)
  end
  mod.menu.redraw()
end

-- m.enc = function(n, d)
--   if n == 2 then state.x = state.x + d
--   elseif n == 3 then state.y = state.y + d end
--   -- tell the menu system to redraw, which in turn calls the mod's menu redraw
--   -- function
--   mod.menu.redraw()
-- end

m.redraw = function()
  tz = util.os_capture("ls -l /etc/localtime | cut -d '>' -f2 | cut -d '/' -f5,6")
  now = util.os_capture('date "+%Y-%m-%d %H:%M"')
  screen.clear()
  screen.move(64,18)
  screen.text_center('press k3 to reload crontab')
  screen.move(64,34)
  screen.text_center('now: '..now)
  screen.move(64,50)
  screen.text_center('tz: '..tz)
  screen.update()
end

m.init = function() end -- on menu entry, ie, if you wanted to start timers
m.deinit = function() end -- on menu exit

-- register the mod menu
mod.menu.register(mod.this_name, m)