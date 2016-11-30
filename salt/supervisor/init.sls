install_supervisor:
  pkg.installed:
    - name: supervisor

start_supervisor:
  service.running:
    - name: supervisord
    - enable: True
