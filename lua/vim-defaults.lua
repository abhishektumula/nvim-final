vim.opt.number = true
vim.opt.relativenumber = true
vim.g.mapleader = " "
vim.opt.numberwidth = 6
-- color set to black 

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "#000000" })
        vim.api.nvim_set_hl(0, "LineNr", { bg = "#000000" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#000000" })
    end,
})

