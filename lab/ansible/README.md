# REQUIREMENTS

### Download, Install, Configure Ansible

- On your Ansible control node server, add your Ansible host remote server’s IP to your Ansible inventory file /etc/ansible/hosts
```
[lab_aws_servers]
aws_server1 ansible_host=your_remote_server_ip1 ansible_ssh_private_key_file=./sshkey/lab_sshkey
aws_server2 ansible_host=your_remote_server_ip2 ansible_ssh_private_key_file=./sshkey/lab_sshkey
...
```
- Now you’ll test and authenticate your SSH connection between this Ansible control node and your Ansible host remote server:
```
ssh -i ./sshkey/lab_sshkey ubuntu@your_remote_server_ip1
ssh -i ./sshkey/lab_sshkey ubuntu@your_remote_server_ip2
```
### Preparing your Playbook

- Create file "playbook.yml"
```
---
- hosts: lab_aws_servers
  become: true
  vars:
    new_user: labadmin

  tasks:
    - name: Setup passwordless sudo
      lineinfile:
        path: /etc/sudoers
        state: present
        regexp: '^%sudo'
        line: '%sudo ALL=(ALL) NOPASSWD: ALL'
        validate: '/usr/sbin/visudo -cf %s'

    - name: Create the new user named {{ new_user }} with sudo privileges
      user:
        name: "{{ new_user }}"
        state: present
        groups: sudo
        shell: /bin/bash
        append: true
        create_home: true
```
- Run your playbook:
```
ansible-playbook playbook.yml -u ubuntu
```
