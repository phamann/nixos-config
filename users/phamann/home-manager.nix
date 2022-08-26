{ config, pkgs, lib, ... }:
let sources = import ../../nix/sources.nix; in {

  home.username = "phamann";
  home.homeDirectory = "/home/phamann";

  # https://nix-community.github.io/home-manager/options.html

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
    PAGER = "less -FirSwX";
    MANPAGER = "sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
    GPG_TTY = "$(tty)";
  };

    home.packages = with pkgs; [
    	bat
        fd
        fzf
        git-crypt
        htop
        jq
        ripgrep
        pinentry-curses
        subnetcalc
        tmux
        tree
        watch
        niv
        zsh-vi-mode
        zsh-fzf-tab
        zsh-z

        go
        gopls

        kitty
        docker
        google-cloud-sdk
        nodePackages.dockerfile-language-server-nodejs
        nodePackages.lua-fmt
        nodePackages.yaml-language-server
    ];

    programs = {
        # https://nixos.wiki/wiki/Home_Manager#Installation_as_a_user
        # home-manager needs your shell to source hm-session-vars.sh
        # https://nix-community.github.io/home-manager/options.html#opt-programs.zsh.enable
        zsh = {
            enable = true;
            defaultKeymap = "viins"; # or "vicmd"
                enableCompletion = true;
            enableAutosuggestions = true;
            enableSyntaxHighlighting = true;
            shellAliases = {
                diff = "diff -u";
                tree = "tree --dirsfirst --noreport -ACF";
                grep = "grep --color=auto --exclude=tags --exclude-dir=.git";
                tl = "tmux list-sessions";
                ta = "tmux attach -t ";
                gitc = "nvim -c Neogit";
            };
            history = {
                size = 10000;
                save = 10000;
                ignoreDups = true;
                ignoreSpace = true;
                ignorePatterns = [
                    "rm *"
                        "pkill *"
                ];
            };
            # https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout
            # https://wiki.archlinux.org/title/Zsh#Configuration_files
            profileExtra = ""; # TODO
                envExtra = ''
                # For commit signing on the iPad
                export GPG_TTY=$(tty)
                export EDITOR="$(which nvim)"
                export TERMINAL="$(which kitty)"
                export BROWSER="$(which firefox)"
                '';
            sessionVariables = {
            }; # TODO
            loginExtra = ""; # TODO
            initExtraFirst = ""; # TODO
            initExtraBeforeCompInit = ''
            zstyle ':completion:*' menu select
            ''; # TODO
            initExtra  = ''
            setopt HIST_IGNORE_ALL_DUPS
            setopt HIST_FIND_NO_DUPS
            setopt HIST_IGNORE_SPACE
            setopt clobber
            setopt extendedglob
            setopt inc_append_history
            setopt share_history
            setopt interactive_comments
            setopt nobeep
            '';
        };

        ssh = {
            enable = true;
            controlMaster = "no";
            controlPath = "~/.ssh/master-%r@%n:%p";
            controlPersist = "30m";
            forwardAgent = true;

            matchBlocks = {
                "*" = {
                };

                "github.com" = {
                    hostname = "ssh.github.com";
                    user = "git";
                    port = 443;
                };
            };
        };

        git = {
            enable = true;
            userName  = "Patrick Hamann";
            userEmail = "patrickhamann@gmail.com";
            #signing = {
            # key = "9CD9D30EBB7B1EEC";
            # signByDefault = true;
            #};
        };

        kitty = {
            enable = true;
            extraConfig = builtins.readFile ./kitty.conf;
        };

        # TODO
        # tmux = {};

        # TODO
        # neovim = {};
    };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSshSupport = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
