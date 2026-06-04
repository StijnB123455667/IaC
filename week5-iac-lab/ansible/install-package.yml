---
- name: Opdracht 2 - Package installeren via CI/CD
  hosts: webservers
  become: true

  vars:
    package_name: nginx

  tasks:
    - name: Installeer package via apt module
      ansible.builtin.apt:
        name: "{{ package_name }}"
        state: present
        update_cache: true
