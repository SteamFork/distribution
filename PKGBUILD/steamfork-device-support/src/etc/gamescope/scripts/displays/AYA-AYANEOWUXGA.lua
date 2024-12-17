-- Ayaneo 2
-- Ayaneo 2S

local panel_id = "ayaneo_wuxga_lcd"
local panel_name = "Ayaneo WUXGA LCD Panel"

local panel_models = {
  { vendor = "AYA", model = "AYANEOWUXGA" },
}

local panel_refresh_rates = {}
for hz = 46, 60 do
  table.insert(panel_refresh_rates, hz)
end


gamescope.config.known_displays[panel_id] = {
  pretty_name = panel_name,

  -- These tables are optional
  colorimetry = (panel_colorimetry ~= nil) and panel_colorimetry,
  dynamic_refresh_rates = (panel_refresh_rates ~= nil) and panel_refresh_rates,
  hdr = (panel_hdr ~= nil) and panel_hdr,

  dynamic_modegen = function(base_mode, refresh)
    local mode = base_mode
    debug("["..panel_id.."] Switching mode to "..mode.hdisplay.."x"..mode.vdisplay.."@"..refresh.."Hz")

    -- Override blanking intervals if defined
    if panel_resolutions ~= nil then
      for i, res in ipairs(panel_resolutions) do
        if res.width == mode.hdisplay and res.height == mode.vdisplay then

          if res.hfp ~= nil and res.hsync ~= nil and res.hbp ~= nil then
            gamescope.modegen.set_h_timings(mode, set_res.hfp, set_res.hsync, set_res.hbp)
            debug("["..panel_id.."] Overriding horizontal blanking interval")
          end

          if res.vfp ~= nil and res.vsync ~= nil and res.vbp ~= nil then
            gamescope.modegen.set_v_timings(mode, set_res.vfp, set_res.vsync, set_res.vbp)
            debug("["..panel_id.."] Overriding vertical blanking interval")
          end

          -- No need to iterate anymore
          break
        end
      end
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
