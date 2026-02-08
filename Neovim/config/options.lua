-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- -- Point this to where your python.exe actually is
-- You can find the path by typing 'where python' in cmd
vim.g.python3_host_prog = "C:Users/xrp1q/AppData/Local/Pograms/Python/Python313/python.exe"

-- This removes the dark backdrop from Snacks/Dashboard popups
vim.g.snacks_animate = false
if vim.fn.has("win32") == 1 then
  vim.opt.shell = "powershell.exe"
  vim.opt.shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end

-- In lua/config/options.lua
vim.g.colorscheme = "tokyonight-night"
