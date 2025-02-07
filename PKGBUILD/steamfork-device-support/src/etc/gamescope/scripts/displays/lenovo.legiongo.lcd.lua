-- Lenovo Legion Go display, derived from work by Matthew Schwarz.

local panel_id = "lenovo_legiongo_lcd"
local panel_name = "Lenovo Legion Go LCD"
local panel_refresh_rates = { 60, 144 }

gamescope.config.known_displays[panel_id] = {
  pretty_name = panel_name,
 
  -- These tables are optional
  colorimetry = (panel_colorimetry ~= nil) and panel_colorimetry,
  dynamic_refresh_rates = (panel_refresh_rates ~= nil) and panel_refresh_rates,
  hdr = (panel_hdr ~= nil) and panel_hdr,

  dynamic_modegen = function(base_mode, refresh)
    debug("Generating mode "..refresh.."Hz for Lenovo Legion Go LCD")
    local mode = base_mode

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
    -- There is only a single panel in use on the Lenovo Legion Go.
    if display.vendor == "LEN" and display.model == "Go Display" and display.product == 0x0001 then
      debug("[lenovo_legiongo_lcd] Matched vendor: "..display.vendor.." model: "..display.model.." product: "..display.product)
      return 5000
    end
    return -1
  end
}
debug("Registered Lenovo Legion Go LCD as a known display")
