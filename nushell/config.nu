$env.config = {
	show_banner: false,
}
def upgrade [] {
	^open /Applications/Latest.app
	brew update --quiet
	brew upgrade --quiet
	brew upgrade --quiet --cask wezterm@nightly --no-quarantine --greedy-latest
	# echo ([ansi blue] '==>' [ansi reset] ' ' [ansi bold] 'updating flake lock...' [ansi reset])
	(cd ~/dotfiles ; nix flake update --commit-lock-file)
	# echo ([ansi blue] '==>' [ansi reset] ' ' [ansi bold] 'rebuilding nix-darwin...' [ansi reset])
	darwin-rebuild switch --flake ~/dotfiles
}
def fastfetch [] {
	clear;^fastfetch
}

source /Users/yetso/.cache/zoxide/init.nu

use /Users/yetso/.cache/starship/init.nu

alias docker = podman
alias eza = eza --icons always --binary --total-size --group-directories-first --header --no-quotes --all '--color=always' '--ignore-glob=.DS_Store'
alias lg = lazygit
alias v = nvim

