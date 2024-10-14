export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=$(brew --prefix)/bin/nvim
export _ZO_RESOLVE_SYMLINKS='1'
export HOMEBREW_NO_ENV_HINTS="true"

alias cat='bat --paging=never --theme="fly16"'
alias fastfetch="clear;fastfetch"
alias lg="lazygit"
alias ls="eza --all --header --binary --color=always --group-directories-first --icons=always --ignore-glob='.DS_Store' --no-quotes"
alias lt="eza --long --tree --level=2 --all --header --binary --color=always --group-directories-first --icons=always --ignore-glob='.DS_Store' --no-quotes"
alias update='open /Applications/Latest.app;brew update;brew upgrade;brew upgrade --cask wezterm@nightly --no-quarantine --greedy-latest'
alias v='nvim'

eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)"

fastfetch
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# bindkey -e
#
# #############################################################################
# #                       brew configuration 
# #############################################################################
# if command -v brew &>/dev/null; then
# 	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
# 	autoload -Uz compinit; compinit
# 	if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
# 		source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# 	fi
# 	if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
# 		source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# 	fi
# fi

# #############################################################################
# #                       wezterm completion 
# #############################################################################
# if [ "$TERM" = 'wezterm' ]; then
# 	source $HOME/.wezterm-completion.sh
# fi
