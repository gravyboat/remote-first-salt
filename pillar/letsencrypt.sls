letsencrypt:
  config: |
    server = https://acme-v01.api.letsencrypt.org/directory
    email = support@remote-first.com
    authenticator = webroot
    webroot-path = {{ salt['pillar.get']('remotefirst:site:root') }}
    agree-tos = True
    renew-by-default = True
  domainsets:
    www:
      - {{ salt['pillar.get']('remotefirst:site:url') }}
      - www.{{ salt['pillar.get']('remotefirst:site:url') }}
