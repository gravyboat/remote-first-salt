{% from "remotefirst/map.jinja" import remotefirst with context %}

{% set remotefirst_venv = salt['pillar.get']('remotefirst:site:venv') %}
{% set remotefirst_proj = salt['pillar.get']('remotefirst:site:proj') %}
{% set remotefirst_user = salt['pillar.get']('remotefirst:site:user') %}
{% set remotefirst_root = salt['pillar.get']('remotefirst:site:root') %}

include:
  - git
  - nginx
  - python.pip
  - python.virtualenv

{{ remotefirst_user }}:
  user.present:
    - name: {{ remotefirst_user }}
    - shell: /bin/bash
    - home: /home/{{ remotefirst_user }}
    - uid: 2150
    - gid: 2150
    - groups:
      - {{ remotefirst.group }}
      - wheel
    - require:
      - group: {{ remotefirst_user }}
  group.present:
    - gid: 2150

copy_ssh_key:
  cmd.run:
    - name: cp /root/.ssh/id_rsa /home/{{ remotefirst_user }}/.ssh/id_rsa
    - user: root
    - unless: test -e /home/{{ remotefirst_user }}/.ssh/id_rsa

remotefirst_venv:
  virtualenv.managed:
    - name: {{ remotefirst_venv }}
    - user: {{ remotefirst_user }}
    - require:
      - pkg: install_python_virtualenv
      - user: {{ remotefirst_user }}

remotefirst_git:
  git.latest:
    - name: git@bitbucket.org:gravyboat/remote-first.git
    - target: {{ remotefirst_proj }}
    - user: {{ remotefirst_user }}
    - require:
      - pkg: install_git
      - virtualenv: remotefirst_venv

remotefirst_settings:
  file.managed:
    - name: {{ remotefirst_root }}/remotefirst_settings.cfg
    - user: {{ remotefirst_user }}
    - group: {{ remotefirst_user }}
    - mode: 600
    - contents_pillar: remotefirst:env_vars


remotefirst_pkgs:
  pip.installed:
    - bin_env: {{ remotefirst_venv }}
    - requirements: {{ remotefirst_proj }}/requirements.txt
    - user: {{ remotefirst_user }}
    - require:
      - git: remotefirst_git
      - pkg: install_python_pip
      - virtualenv: remotefirst_venv

remotefirst_nginx_conf:
  file.managed:
    - name: /etc/nginx/conf.d/remotefirst.conf
    - source: salt://remotefirst/files/remotefirst.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - git: remotefirst_git
      - pkg: install_nginx
    - watch_in:
      - service: nginx_service

site_favicon:
  file.managed:
    - name: {{ salt['pillar.get']('remotefirst:root') }}/favicon.ico
    - source: salt://remotefirst/files/favicon.ico
    - template: jinja
    - user: {{ remotefirst_user }}
    - group: {{ remotefirst_user }}
    - mode: 644
    - require:
      - git: remotefirst_git
      - pkg: install_nginx
    - watch_in:
      - service: nginx_service

remove_default_sites_enabled:
  file.absent:
    - name: /etc/nginx/sites-enabled/default
    - watch_in:
      - service: nginx_service
