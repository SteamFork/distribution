-- AYN Loki
-- AYN Loki Max
-- AYN Loki Zero

local panel_id = "ayn_loki_lcd"
local panel_name = "AYN Loki LCD Panel"

local panel_models = {
  { vendor = "AYN", model = "LK-GOLDSPV58" },
}

local panel_colorimetry = {
  r = { x = 0.0000, y = 0.0000 },
  g = { x = 0.0000, y = 0.0000 },
  b = { x = 0.0000, y = 0.0000 },
  w = { x = 0.0000, y = 0.0000 }
}

local panel_resolutions = {
  { width = 1080, height = 1920,
    hfront = 25, hsync = 10, hback = 15,
    vfront = 3, vsync = 16, vback = 20 },
  { width = 810, height = 1440,
    hfront = 144, hsync = 80, hback = 64,
    vfront = 40, vsync = 10, vback = 3 },
  { width = 768, height = 1024,
    hfront = 48, hsync = 10, hback = 82,
    vfront = 10, vsync = 24, vback = 22 },
  { width = 720, height = 1280,
    hfront = 128, hsync = 72, hback = 56,
    vfront = 34, vsync = 10, vback = 3 },
  { width = 648, height = 1152,
    hfront = 112, hsync = 64, hback = 48,
    vfront = 30, vsync = 10, vback = 3 },
  { width = 600, height = 800,
    hfront = 88, hsync = 56, hback = 31,
    vfront = 18, vsync = 10, vback = 3 },
  { width = 768, height = 1366,
    hfront = 136, hsync = 80, hback = 56,
    vfront = 37, vsync = 10, vback = 3 },
}


local panel_refresh_rates = {}
for hz = 31, 60 do
  table.insert(panel_refresh_rates, hz)
end

local panel_hdr = {
  supported = false,
  force_enabled = false,
  eotf = gamescope.eotf.gamma22,
  max_content_light_level = 500,
  max_frame_average_luminance = 500,
  min_content_light_level = 0.5
}


gamescope.config.known_displays[panel_id] = {
  pretty_name = panel_name,
  dynamic_refresh_rates = panel_refresh_rates,
  hdr = panel_hdr,
  --colorimetry = panel_colorimetry,

  dynamic_modegen = function(base_mode, refresh)
    local mode = base_mode
    local found_res = false
    local set_res = panel_resolutions[1]
    debug("["..panel_id.."] Generating mode "..mode.hdisplay.."x"..mode.vdisplay.."@"..refresh.."Hz")

    for i, res in ipairs(panel_resolutions) do
      if res.width == mode.hdisplay and res.height == mode.vdisplay then
        found_res = true
        set_res = res
        break
      end
    end

    if not found_res then
      debug("["..panel_id.."] Generating mode failed.  Setting default resolution of "..set_res.width.."x"..set_res.height)
      gamescope.modegen.set_resolution(mode, set_res.width, set_res.height)
    end

    gamescope.modegen.set_h_timings(mode, set_res.hfront, set_res.hsync, set_res.hback)
    gamescope.modegen.set_v_timings(mode, set_res.vfront, set_res.vsync, set_res.vback)

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
