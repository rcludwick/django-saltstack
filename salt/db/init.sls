db:
    postgres_user.present:
        - require:
            - service: postgresql
        - name: {{ pillar['postgres.user'] }}
        - password: {{ pillar['postgres.pass'] }}
        - createdb: True
    postgres_database.present:
        - require:
            - service: postgresql
        - name: {{ pillar['postgres.db'] }}
        - owner: {{ pillar['postgres.user'] }}
     
