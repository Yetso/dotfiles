if status is-interactive
    # Commands to run in interactive sessions can go here
	abbr --add lg lazygit
	abbr --add v nvim

	starship init fish | source
	zoxide init fish --cmd cd | source
end


