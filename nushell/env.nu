mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

zoxide init nushell --cmd cd | save -f ~/.zoxide.nu
