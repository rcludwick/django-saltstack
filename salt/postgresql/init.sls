#https://raw.github.com/brutasse/states/master/postgresql/init.sls
#include:
#  - sysctl

postgresql:
  pkg:
    - installed
  service.running:
    - enable: True

postgres-user:
    postgres_user.present:
        - require:
            - pkg: postgresql
            - service: postgresql
        - name: {{ pillar['postgres.user'] }}
        - password: {{ pillar['postgres.pass'] }}
        - createdb: True

{% for name in pillar['postgresql']['databases'] %}
postgresql-database-{{ name }}:
  cmd.run:
    - require:
      - pkg: postgresql
      - service: postgresql
    - name: createdb -E UTF8 -T template0 -U postgres -O {{ pillar['postgres.user'] }} {{ name }}
    - unless: psql -U postgres -ltA | grep '^{{ name }}|'
{% endfor %}

