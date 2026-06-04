---
- name: Opdracht 1 - Apache installeren zonder apt module
  hosts: webservers
  become: true
  gather_facts: true

  tasks:
    - name: Update apt cache zonder apt module
      ansible.builtin.command: apt-get update
      changed_when: false

    - name: Controleer of apache2 al is geinstalleerd
      ansible.builtin.command: dpkg -s apache2
      register: apache_check
      changed_when: false
      failed_when: false

    - name: Installeer apache2 zonder apt module
      ansible.builtin.command: apt-get install -y apache2
      register: apache_install
      when: apache_check.rc != 0
      changed_when: apache_install.rc == 0

    - name: Laat bewust een nette foutmelding zien
      ansible.builtin.command: /bin/false
      register: intentional_failure
      changed_when: false
      failed_when: intentional_failure.rc != 0
