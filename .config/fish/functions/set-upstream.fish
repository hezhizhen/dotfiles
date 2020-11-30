function set-upstream
    git remote rename origin upstream
    git remote add origin https://github.com/hezhizhen/(basename (pwd))
    git remote -v
    echo "Ready to contribute to" (basename (pwd)) "?" | lolcat
end
