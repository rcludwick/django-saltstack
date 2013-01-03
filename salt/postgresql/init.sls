#https://raw.github.com/brutasse/states/master/postgresql/init.sls
#include:
#  - sysctl

postgresql:
  pkg:
    - installed
  file.managed:
    - name: /etc/postgresql/9.1/main/postgresql.conf
    - source: salt://postgresql/postgresql.conf
    - template: jinja
    - user: postgres
    - group: postgres
    - mode: 644
    - defaults:
      wal_e: False
      shared_buffers: 128MB
      work_mem: 16MB
      maintenance_work_mem: 16MB
      effective_cache_size: 256MB
    - require:
      - pkg: postgresql
  service.running:
    - enable: True
    - watch:
      - file: postgresql
      - file: postgresql-hba

postgresql-hba:
  file.managed:
    - name: /etc/postgresql/9.1/main/pg_hba.conf
    - source: salt://postgresql/pg_hba.conf
    - user: postgres
    - group: postgres
    - mode: 644
    - require:
      - pkg: postgresql

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

