include:
  - supervisor

supervisor_file:
  file.managed:
    - name: /etc/supervisord.d/remotefirst.ini
    - source: salt://remotefirst/files/remotefirst_supervisor.ini
    - mode: 644
    - user: root
    - template: jinja

remotefirst_server:
  supervisord.running:
    - name: remotefirst
    - require:
      - sls: supervisor
    - watch:
      - file: supervisor_file
      - git: remotefirst_git
      
