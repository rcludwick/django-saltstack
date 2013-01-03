db:
    postgres_user.present:
        - name: {{ pillar['postgres.user'] }}
        - password: {{ pillar['postgres.pass'] }}
        - createdb: True
        - runas: {{ pillar['postgres.runas'] }}
    postgres_database.present:
        - name: {{ pillar['postgres.db'] }}
        - owner: {{ pillar['postgres.user'] }}
        - runas: {{ pillar['postgres.runas'] }}
     
