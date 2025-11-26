# dotfiles
This repository automates the setup of a developer machine using a combination of Ansible playbooks and shell scripts.
It provisions commonly used tools like Docker, VSCode, Zsh, and other utilities.
This is a practice project for learning Ansible automation and Linux environment setup.

# Tools Installed / Managed
- System Tools: curl, git, zsh, nano, bat, fd-find, zoxide
- Editors & IDEs: VSCode (via apt)
- Java Stack: JDK 21, Maven
- Databases: PostgreSQL client, DBeaver (via snap)
- Containerization: Docker CE + Compose plugin
- Automation: Ansible + ansible-lint
- SSH: OpenSSH server for Ansible connectivity

# System setup
1. Install Ansible (if not already installed)
   
     `sudo ./install_ansible.sh`
   
3. Run main playbook
   
     `ansible-playbook main_playbook.yml`
     
   
### Linting

Run the script `./linter.zsh`
   
   This interactive script lets you select and lint playbooks:
    - docker_playbook.yml
    - java_playbook.yml
    - misc_playbook.yml
    - vscode_playbook.yml
    - zsh_playbook.yml
    - flutter_playbook.yml
