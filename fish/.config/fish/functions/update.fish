function update --wraps='open /Applications/Latest.app;brew update;brew upgrade;brew upgrade --cask wezterm@nightly --no-quarantine --greedy-latest' --description 'alias update=open /Applications/Latest.app;brew update;brew upgrade;brew upgrade --cask wezterm@nightly --no-quarantine --greedy-latest; nix flake update'
  open /Applications/Latest.app
  brew update
  brew upgrade
  brew upgrade --cask wezterm@nightly --no-quarantine --greedy-latest
  cd ~/dotfiles/nix/.config/nix-darwin/
  nix flake update --commit-lock-file
  darwin-rebuild switch --flake . --impure
end
