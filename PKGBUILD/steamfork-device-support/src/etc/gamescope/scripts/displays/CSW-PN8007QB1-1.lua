gamescope.config.known_displays.legiongos_lcd = {
    pretty_name = "Lenovo Legion Go S LCD",
    hdr = {
        -- Setup some fallbacks for undocking with HDR, meant
        -- for the internal panel. It does not support HDR.
        supported = false,
        force_enabled = false,
        eotf = gamescope.eotf.gamma22,
        max_content_light_level = 500,
        max_frame_average_luminance = 500,
        min_content_light_level = 0.5
    },
    
    dynamic_refresh_rates = {
        48, 49, 50, 51, 52, 53, 54, 55, 56, 57,
        58, 59, 60, 61, 62, 63, 64, 65, 66, 67,
        68, 69, 70, 71, 72, 73, 74, 75, 76, 77,
        78, 79, 80, 81, 82, 83, 84, 85, 86, 87,
        88, 89, 90, 91, 92, 93, 94, 95, 96, 97,
        98, 99, 100, 101, 102, 103, 104, 105, 106, 107,
        108, 109, 110, 111, 112, 113, 114, 115, 116, 117,
        118, 119, 120
    },
    
    -- Detailed Timing Descriptors:
    -- DTD 1:  1920x1200  120.002 Hz   8:5   151.683 kHz 315.500 MHz (172 mm x 107 mm)
    --   Modeline "1920x1200_120.00" 315.500  1920 1968 2000 2080  1200 1254 1260 1264  -HSync -VSync
    -- DTD 2:  1920x1200   60.001 Hz   8:5    75.841 kHz 157.750 MHz (172 mm x 107 mm)
    --   Modeline "1920x1200_60.00" 157.750  1920 1968 2000 2080  1200 1254 1260 1264  -HSync -VSync
    dynamic_modegen = function(base_mode, refresh)
        debug("Generating mode "..refresh.."Hz with fixed pixel clock")
        local vfps = {
            1950, 1885, 1824, 1764, 1707, 1652, 1599, 1548, 1499, 1451, 1405,
            1361, 1318, 1277, 1237, 1198, 1160, 1124, 1088, 1054, 1021, 988,
            957, 927, 897, 868, 840, 813, 786, 760, 735, 710, 686, 663, 640,
            618, 596, 575, 554, 534, 514, 495, 476, 457, 439, 421, 404, 387,
            370, 354, 338, 322, 307, 292, 277, 263, 249, 235, 221, 208, 195,
            182, 169, 157, 145, 133, 121, 109, 98, 87, 76, 65, 54
        }
        local vfp = vfps[zero_index(refresh - 48)]
        if vfp == nil then
            warn("Couldn't do refresh "..refresh.." on ROG Ally")
            return base_mode
        end

        local mode = base_mode

        gamescope.modegen.adjust_front_porch(mode, vfp)
        mode.vrefresh = gamescope.modegen.calc_vrefresh(mode)

        --debug(inspect(mode))
        return mode
    end,

    
    matches = function(display)
        if display.vendor == "CSW" and display.model == "PN8007QB1-1" then
            debug("[legos_lcd] Matched vendor: "..display.vendor.." model: "..display.model.." product:"..display.product)
            return 5000
        end
        return -1
    end
}
debug("Registered Lenovo Legion Go S LCD as a known display")