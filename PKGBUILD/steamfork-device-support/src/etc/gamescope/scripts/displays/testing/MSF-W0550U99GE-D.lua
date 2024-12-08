-- Ayaneo Air
-- Ayaneo Air Pro

local panel_id = "ayaneo_air_oled"
local panel_name = "Ayaneo Air OLED Panel"

local panel_models = {
  { vendor = "MSF", model = "W0550U99GE-D" },
}

local panel_resolutions = {
  { width = 1080, height = 1920 },
  { width = 720, height = 1280 },
  { width = 600, height = 960 },
}

local panel_refresh_rates = {}
for hz = 31, 60 do
  table.insert(panel_refresh_rates, hz)
end


gamescope.config.known_displays[panel_id] = {
  pretty_name = panel_name,
  colorimetry = (panel_colorimetry ~= nil) and panel_colorimetry,
  dynamic_refresh_rates = (panel_refresh_rates ~= nil) and panel_refresh_rates,
  hdr = (panel_hdr ~= nil) and panel_hdr,

  dynamic_modegen = function(base_mode, refresh)
    local mode = base_mode
    local set_res = false
    debug("["..panel_id.."] Switching mode to "..mode.hdisplay.."x"..mode.vdisplay.."@"..refresh.."Hz")

    for i, res in ipairs(panel_resolutions) do
      if res.width == mode.hdisplay and res.height == mode.vdisplay then
        set_res = res
        break
      end
    end

    if not set_res then
      debug("["..panel_id.."] Mode not found.  Aborting.")
      return mode
    end

    if set_res.hfp ~= nil and set_res.hsync ~= nil and set_res.hbp ~= nil then
      gamescope.modegen.set_h_timings(mode, set_res.hfp, set_res.hsync, set_res.hbp)
    end
    if set_res.vfp ~= nil and set_res.vsync ~= nil and set_res.vbp ~= nil then
      gamescope.modegen.set_v_timings(mode, set_res.vfp, set_res.vsync, set_res.vbp)
    end

    mode.clock = gamescope.modegen.calc_max_clock(mode, refresh)
    mode.vrefresh = gamescope.modegen.calc_vrefresh(mode)

    return mode
  end,

  matches = function(display)
    for i, panel in ipairs(panel_models) do
      if panel.vendor == display.vendor and panel.model == display.model then
        debug("["..panel_id.."] Matched vendor: "..display.vendor.." model: "..display.model)
        return 4000
      end
    end

    return -1
  end
}
