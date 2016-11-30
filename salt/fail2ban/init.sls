install_fail2ban:
  pkg.installed:
    - name: fail2ban

fail2ban_service:
  service.running:
    - name: fail2ban
    - enable: True
    - watch:
      - pkg: install_fail2ban
    - require:
      - pkg: install_fail2ban

fail2ban_jail:
  file.managed:
    - name: /etc/fail2ban/jail.local
    - source: salt://fail2ban/files/jail.local
    - user: root
    - group: root
    - mode: 644
    - watch_in:
        - service: fail2ban_service
