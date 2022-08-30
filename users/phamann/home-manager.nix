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
        tree
        watch
        niv
	grc
	z-lua

        zsh-vi-mode
        zsh-fzf-tab
        zsh-z
	zsh-autosuggestions
	zsh-history-substring-search
	zsh-syntax-highlighting

        go
        gopls

	starship
        kitty
        docker
        google-cloud-sdk
        nodePackages.dockerfile-language-server-nodejs
        nodePackages.lua-fmt
        nodePackages.yaml-language-server
    ];

    programs = {
    	z-lua = {
		enable = true;
		enableZshIntegration = true;
		options = [ "enhanced" "fzf" ];
	};
	fzf = {
		enable = true;
		enableZshIntegration = true;
		defaultOptions = ["--height 40%" "--reverse" "--border"];
	};
        # https://nixos.wiki/wiki/Home_Manager#Installation_as_a_user
        # home-manager needs your shell to source hm-session-vars.sh
        # https://nix-community.github.io/home-manager/options.html#opt-programs.zsh.enable
        zsh = {
            enable = true;
            enableCompletion = true;
            enableAutosuggestions = true;
            shellAliases = {
                diff = "diff -u";
                tree = "tree --dirsfirst --noreport -ACF";
                grep = "grep --color=auto --exclude=tags --exclude-dir=.git";
		g = "nocorrect git";
		k = "nocorrect kubectl";
		r = "source ~/.zshrc";
		tmux = "tmux -2";
		l = "ls -l \${colorflag}";
		la = "ls -la \${colorflag}";
		".." = "cd ..";
		"..." = "cd ../..";
		"...." = "cd ../../..";
		"....." = "cd ../../../..";
		cat = "bat --color=always --theme=ansi";
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
                export GPG_TTY=$(tty)
                export EDITOR="$(which nvim)"
		export GIT_EDITOR="nvim"
                export TERMINAL="$(which kitty)"
                export BROWSER="$(which firefox)"
		export FASTLY_CHEF_USERNAME="phamann"
		export GITHUB_USER="phamann"
		export GREP_COLOR='1;32'
		export CLICOLOR=1
		export GOPATH=$HOME/Projects
		export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
		export LSCOLORS=Gxfxcxdxbxegedabagacad
                '';
            sessionVariables = {
            }; # TODO
            loginExtra = ""; # TODO
            initExtraFirst = ""; # TODO
            initExtraBeforeCompInit = ''
		# man zshcontrib
		zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
		zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
		zstyle ':vcs_info:*' enable git #svn cvs

		# Enable completion caching, use rehash to clear
		zstyle ':completion::complete:*' use-cache on
		zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

		# Fallback to built in ls colors
		zstyle ':completion:*' list-colors ' '

		# Make the list prompt friendly
		zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'

		# Make the selection prompt friendly when there are a lot of choices
		zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

		# Add simple colors to kill
		zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

		# list of completers to use
		zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
		zstyle ':completion:*' menu select=1 _complete _ignored _approximate

		# match uppercase from lowercase
		zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

		# offer indexes before parameters in subscripts
		zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

		# formatting and messages
		zstyle ':completion:*' verbose yes
		zstyle ':completion:*:descriptions' format '%B%d%b'
		zstyle ':completion:*:messages' format '%d'
		zstyle ':completion:*:warnings' format 'No matches for: %d'
		zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
		zstyle ':completion:*' group-name ' '

		# ignore completion functions (until the _ignored completer)
		zstyle ':completion:*:functions' ignored-patterns '_*'
		zstyle ':completion:*:scp:*' tag-order files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
		zstyle ':completion:*:scp:*' group-order files all-files users hosts-domain hosts-host hosts-ipaddr
		zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
		zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
		zstyle '*' single-ignored show

		# pasting with tabs doesn't perform completion
		zstyle ':completion:*' insert-tab pending
            '';
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
		    setopt prompt_subst
		    source ${pkgs.grc}/etc/grc.zsh
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

	starship = {
            enable = true;
	    settings = {
	    	format = lib.concatStrings [
		    "$username"
		    "$hostname"
		    "$nix_shell"
		    "$localip"
		    "$shlvl"
		    "$directory"
		    "$git_branch"
		    "$git_commit"
		    "$git_state"
		    "$git_metrics"
		    "$git_status"
		    "$hg_branch"
		    "$docker_context"
		    "$container"
		    "$terraform"
		    "$env_var"
		    "$sudo"
		    "$cmd_duration"
		    "$line_break"
		    "$status"
		    "$shell"
		    "$character"
		];
		username = {
			show_always = true;
			style_user = "bold_purple";
		};
		character = {
			success_symbol = "[±](bold green)";
			error_symbol = "[±](bold red)";
			vicmd_symbol = "[±](bold green)";
		};
		git_commit = {
			tag_symbol = " tag ";
		};
		git_status = {
			format = ''([\[](bold green)[$conflicted$renamed]($style)$modified$untracked$staged$deleted$ahead_behind[\]](bold green)) '';
			ahead = "[>$count](bold red)";
			behind = "[<$count](bold cyan)";
			diverged = "<>";
			renamed = "r";
			deleted = "[-](bold red)";
			stashed = "s";
			staged = "[+](bold green)";
			modified = "[m](bold yellow)";
			untracked = "[u](bold red)";
		};
		directory = {
			read_only = " ro";
			truncation_length = 8;
			truncation_symbol = "…/";
			truncate_to_repo = false;
			style = "bold yellow";
		};
		docker_context = {
			symbol = "docker ";
		};
		git_branch = {
			style = "bold cyan";
			symbol = " ";
		};
		nix_shell = {
			symbol = "nix ";
		};
	    };
	};

        # TODO
        # tmux = {};

        neovim = {
		enable = true;
		plugins = with pkgs.vimPlugins; [ 
		    {
         		plugin = material-nvim;
          		config = ''
            			lua << EOF
            			${builtins.readFile ./nvim/plugin/material.lua}
            			EOF
          		'';
        	    }
		    {
         		plugin = nvim-treesitter;
          		config = ''
            			lua << EOF
            			${builtins.readFile ./nvim/plugin/treesitter.lua}
            			EOF
          		'';
        	    }
		];
	};
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
