{% from "ssh/map.jinja" import ssh with context %}

install_ssh:
  pkg.installed:
    - name: {{ ssh.client }}

ssh_service:
  service.running:
    - enable: True
    - name: {{ ssh.service }}
    - require:
      - pkg: install_ssh
    - watch:
      - file: sshd_config

sshd_config:
  file.managed:
    - name: /etc/ssh/sshd_config
    - source: salt://ssh/files/sshd_config
    - mode: '0644'
    - user: root
    - group: root
    - template: jinja
    - require:
      - pkg: install_ssh
    - watch_in:
      - service: ssh_service
