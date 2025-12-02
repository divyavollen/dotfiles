# dotfiles
This repository automates the setup of a developer machine using a combination of Ansible playbooks and shell scripts.
It provisions commonly used tools like Docker, VSCode, Zsh, and other utilities.
This is a practice project for learning Ansible automation and Linux environment setup.

# System setup
1. Install Ansible (if not already installed)
   
     `sudo ./install_ansible.sh`
   
3. Run main playbook

   Change the `username` in `main_playbook` then run:
     
     `sudo ansible-playbook main_playbook.yml`
   
## Linting

To lint a playbook, use: `ansible-lint <playbook>.yml`