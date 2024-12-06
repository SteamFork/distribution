-- Ayaneo 2
-- Ayaneo 2S

local panel_id = "ayaneo_wuxga_lcd"
local panel_name = "Ayaneo WUXGA LCD Panel"

local panel_models = {
  { vendor = "AYA", model = "AYANEOWUXGA" },
}

local panel_colorimetry = {
  r = { x = 0.6503, y = 0.3388 },
  g = { x = 0.3242, y = 0.6132 },
  b = { x = 0.1572, y = 0.0488 },
  w = { x = 0.3134, y = 0.3291 }
}

local panel_resolutions = {
  { width = 1200, height = 1920,
    hfront = 64, hsync = 24, hback = 32,
    vfront = 60, vsync = 8, vback = 32 },
  { width = 1080, height = 1920,
    hfront = 40, hsync = 8, hback = 120,
    vfront = 8, vsync = 16, vback = 44 },
  { width = 720, height = 1152,
    hfront = 64, hsync = 8, hback = 88,
    vfront = 8, vsync = 20, vback = 12 },
  { width = 800, height = 1280,
    hfront = 32, hsync = 10, hback = 118,
    vfront = 10, vsync = 16, vback = 20 },
  { width = 720, height = 1280,
    hfront = 64, hsync = 8, hback = 68,
    vfront = 10, vsync = 16, vback = 14 },
  { width = 768, height = 1024,
    hfront = 48, hsync = 10, hback = 82,
    vfront = 10, vsync = 24, vback = 22 },
  { width = 600, height = 960,
    hfront = 68, hsync = 8, hback = 88,
    vfront = 12, vsync = 4, vback = 8 },
}

local panel_refresh_rates = {}
for hz = 46, 60 do
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
  colorimetry = panel_colorimetry,

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
