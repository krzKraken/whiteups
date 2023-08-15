-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
  return
end

-- get lualine nightfly theme
local lualine_nightfly = require("lualine.themes.nightfly")

-- new colors for theme
local new_colors = {
  white = "#FFFFFF",
  blue = "#0000FF",
  green = "#00FF00",
  red = "#FF0000",
  yellow = "#FFFF00",
  black = "#000000",
}

-- change nightlfy theme colors
lualine_nightfly.normal.a.bg = new_colors.green
lualine_nightfly.insert = {
  a = {
    gui = "bold",
    bg = new_colors.red,
    fg = new_colors.white,
  },
}
lualine_nightfly.visual = {
  a = {
    gui = "bold",
    bg = new_colors.blue,
    fg = new_colors.white,
  },
}
lualine_nightfly.command = {
  a = {
    gui = "bold",
    bg = new_colors.yellow,
    fg = new_colors.black, -- black
  },
}

-- configure lualine with modified theme
lualine.setup({
  options = {
    theme = lualine_nightfly,
  },
})
