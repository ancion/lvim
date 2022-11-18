local M = {}

local banner = {
  "                ⢀⣀⣤⣤⣤⣶⣶⣶⣶⣶⣶⣤⣤⣤⣀⡀                ",
  "             ⣀⣤⣶⣿⠿⠟⠛⠉⠉⠉⠁⠈⠉⠉⠉⠛⠛⠿⣿⣷⣦⣀             ",
  "          ⢀⣤⣾⡿⠛⠉                ⠉⠛⢿⣷⣤⡀          ",
  "         ⣴⣿⡿⠃                      ⠙⠻⣿⣦         ",
  " ⢀⣠⣤⣤⣤⣤⣤⣾⣿⣉⣀⡀                        ⠙⢻⣷⡄       ",
  "⣼⠋⠁   ⢠⣿⡟ ⠉⠉⠉⠛⠛⠶⠶⣤⣄⣀    ⣀⣀      ⢠⣤⣤⡄   ⢻⣿⣆      ",
  "⢻⡄   ⢰⣿⡟        ⢠⣿⣿⣿⠉⠛⠲⣾⣿⣿⣷    ⢀⣾⣿⣿⠁    ⢻⣿⡆     ",
  " ⠹⣦⡀ ⣿⣿⠁        ⢸⣿⣿⡇   ⠻⣿⣿⠟⠳⠶⣤⣀⣸⣿⣿⠇      ⣿⣷     ",
  "   ⠙⢷⣿⡇         ⣸⣿⣿⠃          ⢸⣿⣿⢷⣤⡀     ⢸⣿⡆    ",
  "    ⢸⣿⠇         ⣿⣿⣿     ⣿⣿⣷  ⢠⣿⣿⡏ ⠈⠙⠳⢦⣄  ⠈⣿⡇    ",
  "    ⢸⣿⡆        ⢸⣿⣿⡇     ⣿⣿⣿ ⢀⣿⣿⡟      ⠈⠙⠷⣤⣿⡇    ",
  "    ⠘⣿⡇        ⣼⣿⣿⠁     ⣿⣿⣿ ⣼⣿⣿⠃         ⢸⣿⠷⣄⡀  ",
  "     ⣿⣿        ⣿⣿⡿      ⣿⣿⣿⢸⣿⣿⠃          ⣾⡿ ⠈⠻⣆ ",
  "     ⠸⣿⣧      ⢸⣿⣿⣇⣀⣀⣀⣀⣀⣀⣸⣿⣿⣿⣿⠇          ⣼⣿⠇   ⠘⣧",
  "      ⠹⣿⣧     ⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏          ⣼⣿⠏    ⣠⡿",
  "       ⠘⢿⣷⣄   ⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉         ⢠⣼⡿⠛⠛⠛⠛⠛⠛⠉ ",
  "         ⠻⣿⣦⣄                      ⣀⣴⣿⠟         ",
  "          ⠈⠛⢿⣶⣤⣀                ⣀⣤⣶⡿⠛⠁          ",
  "             ⠉⠻⢿⣿⣶⣤⣤⣀⣀⡀  ⢀⣀⣀⣠⣤⣶⣿⡿⠟⠋             ",
  "                ⠈⠉⠙⠛⠻⠿⠿⠿⠿⠿⠿⠟⠛⠋⠉⠁                ",
}

M.banner_alt_1 = {
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣤⣶⣶⣶⣶⣶⣶⣶⣦⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣾⣿⠿⠛⠛⠉⠉⠉⠉⠉⠉⠉⠙⠛⠻⢿⣿⣶⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⠿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⢿⣷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠒⠈⠉⠉⠉⠉⠉⣹⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡀⠀⠀⠀⠀⠀⠀⣰⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⢄⠀⠀⠀⠀⢰⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⢄⡀⠀⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢺⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠉⠑⠢⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⡇⠀⠀⠀⠈⠑⠢⠄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⠢⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠉⠐⠢⠄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⡟⠀⠈⠑⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⢀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠒⠠⠤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⠁⠀⠀⢀⣼⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠁⠒⠂⠤⠤⠀⣀⡀⠀⠀⠀⣼⣿⠇⠀⠀⢀⣸⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⣿⡟⠀⠀⠀⠀⠀⠀⣤⡄⠀⠀⠀⣠⣤⠀⠀⢠⣭⣀⣤⣤⣤⡀⠀⠀⠀⢀⣤⣤⣤⣤⡀⠀⠀⠀⢠⣤⢀⣤⣤⣄⠀⠀⣿⣿⠀⠉⣹⣿⠏⠉⠉⢱⣶⣶⣶⡦⠀⠀⠀⢠⣶⣦⣴⣦⣠⣴⣦⡀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⢠⣿⡇⠀⠀⠀⠀⠀⢠⣿⠇⠀⠀⠀⣿⡇⠀⠀⣿⡿⠉⠀⠈⣿⣧⠀⠀⠰⠿⠋⠀⠀⢹⣿⠀⠀⠀⣿⡿⠋⠀⠹⠿⠀⠀⢻⣿⡇⢠⣿⡟⠀⠀⠀⠈⠉⢹⣿⡇⠀⠀⠀⢸⣿⡏⢹⣿⡏⢹⣿⡇⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⢰⣿⠃⠀⢠⣿⡇⠀⠀⠀⣿⡇⠀⠀⣠⣴⡶⠶⠶⣿⣿⠀⠀⢠⣿⡇⠀⠀⠀⠀⠀⠀⢸⣿⣇⣿⡿⠀⠀⠀⠀⠀⠀⣿⣿⠁⠀⠀⠀⣿⣿⠀⣾⣿⠀⣾⣿⠁⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⣿⣟⠀⠀⠀⠀⠀⠀⢻⣿⡀⠀⢀⣼⣿⠀⠀⢸⣿⠀⠀⠀⢰⣿⠇⠀⢰⣿⣇⠀⠀⣠⣿⡏⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⠁⠀⠀⠀⣀⣀⣠⣿⣿⣀⡀⠀⢠⣿⡟⢠⣿⡟⢀⣿⡿⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠛⠛⠛⠛⠛⠛⠁⠀⠈⠛⠿⠟⠋⠛⠃⠀⠀⠛⠛⠀⠀⠀⠘⠛⠀⠀⠀⠙⠿⠿⠛⠙⠛⠃⠀⠀⠚⠛⠀⠀⠀⠀⠀⠀⠀⠘⠿⠿⠃⠀⠀⠀⠀⠿⠿⠿⠿⠿⠿⠿⠀⠸⠿⠇⠸⠿⠇⠸⠿⠇⠀⠀⠀⠀⠀",
  "                                                                                ",
}

M.banner_alt_2 = {
  "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠛⠛⠉⠉⠉⠉⠉⠉⠛⠛⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠀⣀⣤⣴⣶⣶⣾⣿⣿⣷⣶⣶⣦⣤⣀⠀⠉⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠁⢀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⡀⠈⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  "⣿⣿⠿⠟⠛⠛⠛⠛⠛⠁⠀⠾⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿",
  "⣿⠁⣴⣾⣿⣿⣿⡟⠀⣰⣿⣶⣶⣶⣤⣤⣉⣉⠛⠛⠿⠿⣿⣿⡿⠿⠿⣿⣿⣿⣿⣿⣿⡟⠛⠛⢛⣿⣿⣿⣆⠀⢻⣿⣿⣿⣿⣿⣿⣿",
  "⣿⡄⠻⣿⣿⣿⡟⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⣦⣤⡈⠀⠀⠀⠈⣿⣿⣿⣿⡿⠁⠀⠀⣾⣿⣿⣿⣿⡄⠀⢻⣿⣿⣿⣿⣿⣿",
  "⣿⣿⣄⠙⠿⣿⠁⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⢸⣿⣿⣿⣄⠀⠀⣠⣄⣉⠛⠻⠃⠀⠀⣼⣿⣿⣿⣿⣿⣿⡀⠈⣿⣿⣿⣿⣿⣿",
  "⣿⣿⣿⣷⣦⡈⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠆⠀⠀⡀⠛⠿⣿⣿⣿⣿⣿⡇⠀⢻⣿⣿⣿⣿⣿",
  "⣿⣿⣿⣿⣿⡇⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⢀⣿⣿⣿⣿⡇⠀⠀⠘⣿⣿⡟⠀⠀⢰⣿⣷⣦⣌⡙⠻⢿⣿⣷⠀⢸⣿⣿⣿⣿⣿",
  "⣿⣿⣿⣿⣿⡇⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⢸⣿⣿⣿⣿⣿⠀⠀⠀⣿⡿⠀⠀⢀⣿⣿⣿⣿⣿⣿⣷⣤⣈⠛⠀⢸⣿⣿⣿⣿⣿",
  "⣿⣿⣿⣿⣿⣧⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀⠀⣾⣿⣿⣿⣿⣿⠀⠀⠀⣿⠁⠀⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⡈⠻⢿⣿⣿⣿",
  "⣿⣿⣿⣿⣿⣿⡀⠈⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⢀⣿⣿⣿⣿⣿⣿⠀⠀⠀⠃⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⢀⣿⣶⣄⠙⣿⣿",
  "⣿⣿⣿⣿⣿⣿⣧⠀⠘⣿⣿⣿⣿⣿⣿⡇⠀⠀⠸⠿⠿⠿⠿⠿⠿⠇⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⣼⣿⣿⣿⣦⠘⣿",
  "⣿⣿⣿⣿⣿⣿⣿⣧⠀⠹⣿⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⣼⣿⣿⣿⡿⠟⢀⣿",
  "⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠈⢿⣿⣿⣿⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⢀⣤⣤⣤⣤⣤⣴⣶⣿⣿",
  "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⡀⠈⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠁⢀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣀⠀⠉⠛⠻⠿⠿⢿⣿⣿⡿⠿⠿⠟⠛⠉⠀⣀⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⣤⣤⣀⣀⣀⣀⣀⣀⣤⣤⣴⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
}

if vim.o.lines < 36 then
  banner = vim.list_slice(banner, 16, 22)
end

function M.get_sections()
  local header = {
    type = "text",
    val = banner,
    opts = {
      position = "center",
      hl = "Label",
    },
  }

  local text = require "lvim.interface.text"
  local git_utils = require "lvim.utils.git"

  local current_branch = git_utils.get_lvim_branch()
  local num_plugins_loaded = #vim.fn.globpath(get_runtime_dir() .. "/site/pack/packer/start", "*", 0, 1)

  -- local lvim_version
  -- if current_branch ~= "HEAD" or "" then
  --   lvim_version = current_branch .. "-" .. git_utils.get_lvim_current_sha()
  -- else
  --   lvim_version = "v" .. git_utils.get_lvim_tag()
  -- end
  local lvim_version = require("lvim.utils.git").get_lvim_version()

  local footer = {
    type = "text",
    val = text.align_center({ width = 0 }, {
      "",
      "    :: Lunarvim loaded [ " .. num_plugins_loaded .. " ] plugins ",
      "---------------------------------------------------------------------",
      "     :: Version :  [ " .. lvim_version .. " ]   ",
      "",
      [[#####################################################################]],
      [[ |######## \\ 🪶:: Talking is cheap, show me you code !! // #########|]],
      [[#####################################################################]],
    }, 0.5),
    opts = {
      position = "center",
      hl = "Number",
    },
  }
  local buttons = {}

  local status_ok, dashboard = pcall(require, "alpha.themes.dashboard")
  if status_ok then
    local function button(sc, txt, keybind, keybind_opts)
      local b = dashboard.button(sc, txt, keybind, keybind_opts)
      b.opts.hl_shortcut = "Include"
      return b
    end

    buttons = {
      val = {
        button("f", lvim.icons.ui.FindFile .. " Find File", "<CMD>Telescope find_files<CR>"),
        button("t", lvim.icons.ui.FindText .. "  Find Text", "<CMD>Telescope live_grep<CR>"),
        button("n", lvim.icons.ui.NewFile .. "  New File", "<CMD>ene!<CR>"),
        button("p", lvim.icons.ui.Aliens .. "  Recent Projects ", "<CMD>Telescope projects<CR>"),
        button("r", lvim.icons.ui.FolderOpen .. "  Recent files", ":Telescope oldfiles <CR>"),
        button(
          "c",
          lvim.icons.ui.Gear .. "  Configuration",
          "<CMD>edit " .. require("lvim.config"):get_user_config_path() .. " <CR>"
        ),
        button("<Space> c", lvim.icons.ui.ColorPanel .. " Choose Colorschema ", "<CMD>Telescope colorscheme<CR>"),
      },
    }
  end

  return {
    header = header,
    buttons = buttons,
    footer = footer,
  }
end

return M
