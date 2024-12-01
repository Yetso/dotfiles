$env.PATH = (
	$env.PATH
	| split row (char esep)
	| append /opt/homebrew/bin
	| append /opt/homebrew/sbin
	| append /Users/yetso/.nix-profile/bin
	| append /etc/profiles/per-user/yetso/bin
	| append /run/current-system/sw/bin
	| append /nix/var/nix/profiles/default/bin
	| uniq
)
load-env { "HOMEBREW_NO_AUTO_UPDATE": 1, "HOMEBREW_NO_ANALYTICS": 1 }

let zoxide_cache = "/Users/yetso/.cache/zoxide"
if not ($zoxide_cache | path exists) {
	mkdir $zoxide_cache
}
/nix/store/w7gi2n4835xzhscngl5fvw1g81nfpmsi-zoxide-0.9.6/bin/zoxide init nushell --cmd cd |
	save --force /Users/yetso/.cache/zoxide/init.nu

let starship_cache = "/Users/yetso/.cache/starship"
if not ($starship_cache | path exists) {
	mkdir $starship_cache
}
/etc/profiles/per-user/yetso/bin/starship init nu | save --force /Users/yetso/.cache/starship/init.nu

load-env {}

