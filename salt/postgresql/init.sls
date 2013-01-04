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


postgres-table:
    postgres_table.present:
        - require:
            - pkg: postgresql
            - service: postgresql
            - postgres_user.present: {{ pillar['postgres.user'] }}
        name: 
            - {{ pillar['postgres.table'] }}
        owner: 
            - {{ pillar['postgres.user'] }}
    runas: 
        - postgres
