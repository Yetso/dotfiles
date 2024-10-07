export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=$(brew --prefix)/bin/nvim

#############################################################################
#                       brew configuration 
#############################################################################
if command -v brew &>/dev/null; then
	export HOMEBREW_NO_ENV_HINTS="true"
	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
	autoload -Uz compinit; compinit
	if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
		source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	fi
	if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
		source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	fi
fi


zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

#############################################################################
#                       starship 
#############################################################################
if command -v starship &>/dev/null; then
	export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
	eval "$(starship init zsh)" >/dev/null
fi

#############################################################################
#                       wezterm completion 
#############################################################################
if [ "$TERM" = 'wezterm' ]; then
	source $HOME/.wezterm-completion.sh
fi

#############################################################################
#                       replace cat to bat 
#############################################################################
if command -v bat &>/dev/null; then
	alias cat='bat --paging=never --theme="fly16"'
fi


#############################################################################
#                       replace ls to eza 
#############################################################################
if command -v eza &>/dev/null; then
	alias ls="eza --all --header --binary --color=always --group-directories-first --icons=always --ignore-glob='.DS_Store' --no-quotes"
	alias lt="eza --long --tree --level=2 --all --header --binary --color=always --group-directories-first --icons=always --ignore-glob='.DS_Store' --no-quotes"
fi

#############################################################################
#                       fastfetch 
#############################################################################
if command -v fastfetch &>/dev/null; then
	alias fastfetch='clear;fastfetch'
	fastfetch
fi


#############################################################################
#                       replace cd to zoxide 
#############################################################################
if command -v zoxide &>/dev/null; then
	eval "$(zoxide init zsh --cmd cd)"
fi

alias update='open /Applications/Latest.app;brew update;brew upgrade;brew upgrade --cask wezterm@nightly --no-quarantine --greedy-latest'
alias vim='nvim'
