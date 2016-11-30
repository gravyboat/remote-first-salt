gunicorn_log_dir:
  file.directory:
    - name: /var/log/gunicorn
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
