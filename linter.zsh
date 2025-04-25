#!/bin/zsh

PS3="Select playbook to lint: "

items=("Docker-Playbook" "Java-Playbook" "Misc-Playbook" "VSCode-Playbook" "ZSH-Playbook")

select item in "${items[@]}" Quit; do
    case $REPLY in
    1)
        echo "Linting Docker-Playbook"
        ansible-lint playbook/docker_playbook.yml
        ;;

    2)
        echo "Linting Java-Playbook"
        ansible-lint playbook/java_playbook.yml
        ;;

    3)
        echo "Linting Misc-Playbook"
        ansible-lint playbook/misc_playbook.yml
        ;;

    4)
        echo "Linting VSCode-Playbook"
        ansible-lint playbook/vscode_playbook.yml
        ;;

    5)
        echo "Linting ZSH-Playbook"
        ansible-lint playbook/zsh_playbook.yml
        ;;

    $((${#items[@]} + 1)))
        echo "We're done!"
        exit 0
        ;;

    *) echo "Invalid choice $REPLY" ;;
    esac
done
