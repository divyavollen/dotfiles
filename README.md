# dotfiles
This repository automates the setup of a developer machine using a combination of Ansible playbooks and Bash/Zsh scripts.
It provisions commonly used tools like Java, Maven, Docker, PostgreSQL client, VSCode, Zsh, and other utilities.
This is a practice project for learning Ansible automation and Linux environment setup.
Code and development by me. Occasional reviews by others.

# Tools Installed / Managed
- System Tools: curl, git, zsh, nano, bat, fd-find, zoxide
- Editors & IDEs: VSCode (via apt)
- Java Stack: JDK 21, Maven
- Databases: PostgreSQL client, DBeaver (via snap)
- Containerization: Docker CE + Compose plugin
- Automation: Ansible + ansible-lint
- SSH: OpenSSH server for Ansible connectivity

# Usage
1. Install Ansible (if not already installed)
   
     `sudo ./install_ansible.sh`
   
3. Run Setup Scripts
   
     `sudo ./setup_dev_tools.sh`
   
5. Lint playbook
   
     `./lint_playbooks.sh`
   
   This interactive script lets you select and lint playbooks:
    - docker_playbook.yml
    - java_playbook.yml
    - misc_playbook.yml
    - vscode_playbook.yml
    - zsh_playbook.yml
