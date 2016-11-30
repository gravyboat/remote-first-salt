remotefirst:
  site:
    user: remotefirstuser
    venv: /home/remotefirstuser/remote-first/env
    proj: /home/remotefirstuser/remote-first/
    url: remote-first.com
    root: /home/remotefirstuser/remote-first/remote-first
  env_vars: |
    #Remote First Config
    DATABASE = './db_remotefirst.db'
    DEBUG = True
    SECRET_KEY = 'develop'
    USERNAME = 'admin'
    PASSWORD = 'default'
    #Strip Config
    SECRET_KEY = 'sk_test_********************'
    PUBLISHABLE_KEY = 'pk_test_***************'
    #Twitter Config
    CONSUMER_KEY = '***********************'
    CONSUMER_SECRET = '*******************'
    ACCESS_KEY = '****************'
    ACCESS_SECRET = '************************'
    DATABASE = './db_remotefirst.db'
    DEBUG = True
