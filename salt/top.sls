base:
  '*':
    - git
    - nginx
    - fail2ban
    - python
    - python.gunicorn
    - python.pip
    - python.virtualenv
    - ssh
    - supervisor
    - sqlite
    - remotefirst.app
    - letsencrypt.install
    - letsencrypt.config
    - letsencrypt.domains
    - remotefirst.gunicorn
    - remotefirst.supervisor
