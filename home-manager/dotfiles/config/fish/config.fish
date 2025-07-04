if status is-interactive
    # Commands to run in interactive sessions can go here
end
alias k="kubectl"
alias nurse="sudo nixos-rebuild switch --flake /home/sindreo/home-manager#work-laptop"
alias ll="eza -l --icons --group-directories-first"
alias ls="eza --icons --group-directories-first"
alias tree="eza --tree --icons --group-directories-first"
zoxide init --cmd cd fish | source
starship init fish | source
