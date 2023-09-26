vim.cmd [[source $HOME/.vimrc]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd [[colorscheme tokyonight-storm]]
        end,
        opts = {},
    },
    "wakatime/vim-wakatime",
    { 
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        opts = {},
    },
    { 
        "nvim-telescope/telescope.nvim",
        tag = "0.1.3",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
    },
})

