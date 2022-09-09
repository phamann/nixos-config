require("filetype").setup({
    overrides = {
        extensions = {
            vcl = "vcl",
        },
        complex = {
            [".*.vcl.tmpl"] = "vcl",
            ["api.tpl"] = "vcl",
            ["kitty.conf"] = "kitty",
        },
    }
})
