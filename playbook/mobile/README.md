# Mobile Ansible Playbooks

This directory contains Ansible playbooks for automating the setup of mobile development environments.

# Flutter Playbook

## 1. Run the Playbook
To set up Flutter, run the following command. Note: This command requires sudo privileges.

`ansible-playbook flutter_playbook.yml`

## 2. Manual Configuration Step

After running the Ansible playbook, you may need to manually configure your shell to recognize the Flutter SDK's flutter/bin directory. This is necessary for the Flutter command to be available in your terminal sessions.

If you're using zsh, follow these steps:

1. Open your ~/.zshrc (or ~/.zprofile for login shells) in a text editor:

    `nano ~/.zshrc`

2. Add the following line to source the Flutter environment variables:
    ```
    if [ -f /etc/profile.d/flutter.sh ]; then
    source /etc/profile.d/flutter.sh
    fi
    ```
3. Save the file and apply the changes by sourcing the configuration:

    `source ~/.zshrc`
    
    If you modified ~/.zprofile, you can source it with:

    `source ~/.zprofile`

## 3. Verify Installation
Once the manual step is complete, you can verify that Flutter is correctly set up by running:

`flutter doctor`

This will check your installation and ensure that all necessary dependencies are installed.