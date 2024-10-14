function ls --wraps=eza\ --all\ --header\ --binary\ --color=always\ --group-directories-first\ --icons=always\ --ignore-glob=\'.DS_Store\'\ --no-quotes --description alias\ ls=eza\ --all\ --header\ --binary\ --color=always\ --group-directories-first\ --icons=always\ --ignore-glob=\'.DS_Store\'\ --no-quotes
  eza --all --header --binary --color=always --group-directories-first --icons=always --ignore-glob='.DS_Store' --no-quotes $argv
        
end
