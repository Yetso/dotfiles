function update --wraps='open /Applications/Latest.app;brew update;brew upgrade;brew upgrade --cask wezterm@nightly --no-quarantine --greedy-latest' --description 'alias update=open /Applications/Latest.app;brew update;brew upgrade;brew upgrade --cask wezterm@nightly --no-quarantine --greedy-latest'
  open /Applications/Latest.app;brew update;brew upgrade;brew upgrade --cask wezterm@nightly --no-quarantine --greedy-latest $argv
        
end
