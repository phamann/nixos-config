self: super:

let sources = import ../../nix/sources.nix; in rec {
    customNvim = with self; {
        filetype-nvim = vimUtils.buildVimPlugin {
            name = "filetype-nvim";
            src = sources.filetype-nvim;
        };
        spellsitter-nvim = vimUtils.buildVimPlugin {
            name = "spellsitter-nvim";
            src = sources.spellsitter-nvim;
        };
    };
}
