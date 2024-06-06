#' create hex sticker
#'
#'
#

imgurl <- here::here("data-raw/hex/buoy.png")
hexSticker::sticker(imgurl,
                    package = "buoydata",
                    p_size=19,
                    p_x = 1,
                    p_y = 1.55,
                    p_color = "#004395",

                    s_x=1,
                    s_y=.8,
                    s_width=.77,


                    h_size = 1,
                    h_fill="#FFFFFF",
                    h_color="#004395",
                    #angle = 30,
                    spotlight=F,
                    l_x = .8,
                    l_y = 1,
                    l_width = 3,
                    l_height = 3,
                    l_alpha = 0.5,
                    u_x = .99,
                    u_y=.05,
                    url = "noaa-edab.github.io/buoydata",
                    u_size = 5.2,
                    white_around_sticker = F,
                    filename = here::here("man/figures", "logoWhiteBack.png"))

}
