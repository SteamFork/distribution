-- MSI Claw A1M
-- Adapted from ROG Ally script
-- Work in progress.  Needs much more work and testing

local clawa1m_lcd_refresh_rates = {
    48, 49, 50, 51, 52, 53, 54, 55, 56, 57,
    58, 59, 60, 61, 62, 63, 64, 65, 66, 67,
    68, 69, 70, 71, 72, 73, 74, 75, 76, 77,
    78, 79, 80, 81, 82, 83, 84, 85, 86, 87,
    88, 89, 90, 91, 92, 93, 94, 95, 96, 97,
    98, 99, 100, 101, 102, 103, 104, 105, 106, 107,
    108, 109, 110, 111, 112, 113, 114, 115, 116, 117,
    118, 119, 120
}

gamescope.config.known_displays.clawa1m_lcd = {
    pretty_name = "MSI Claw A1M LCD",
    hdr = {
        supported = false,
        force_enabled = false,
        eotf = gamescope.eotf.gamma22,
        max_content_light_level = 500,
        max_frame_average_luminance = 500,
        min_content_light_level = 0.5
    },
    dynamic_refresh_rates = clawa1m_lcd_refresh_rates,
    dynamic_modegen = function(base_mode, refresh)
        debug("Generating mode "..refresh.."Hz for MSI Claw A1M with fixed pixel clock")
        local vfps = {
            1771, 1720, 1655, 1600, 1549,
            1499, 1455, 1405, 1361, 1320,
            1279, 1224, 1200, 1162, 1120,
            1088, 1055, 1022, 991,  958,
            930,  900,  871,  845,  817,
            794,  762,  740,  715,  690,
            668,  647,  626,  605,  585,
            566,  546,  526,  507,  488,
            470,  452,  435,  419,  402,
            387,  371,  355,  341,  326,
            310,  297,  284,  269,  255,
            244,  229,  217,  204,  194,
            181,  172,  158,  147,  136,
            123,  113,  104,  93,   83,
            74,   64,   54
        }
        local vfp = vfps[zero_index(refresh - 48)]
        if vfp == nil then
            warn("Couldn't do refresh "..refresh.." on MSI Claw A1M")
            return base_mode
        end

        local mode = base_mode

        gamescope.modegen.adjust_front_porch(mode, vfp)
        mode.vrefresh = gamescope.modegen.calc_vrefresh(mode)

        return mode
    end,
    matches = function(display)
        if display.vendor == "TMA" and display.model == "TL070FVXS02-0" then
            debug("[clawa1m_lcd] Matched vendor: "..display.vendor.." model: "..display.model.." product:"..display.product)
            return 4000
        end
        return -1
    end
}
debug("Registered MSI Claw A1M LCD as a known display")
