mkdir ~/.cache/carapace
# carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
carapace _carapace nushell
# Carapace v1.3.2 / nushell v0.105 compat patch. Waiting for new carapace release
# See carapace-sh/carapace-bin#2830
| str replace 'default $carapace_completer completer' 'default { $carapace_completer } completer'
| save --force ~/.cache/carapace/init.nu

zoxide init nushell --cmd cd | save -f ~/.zoxide.nu

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
