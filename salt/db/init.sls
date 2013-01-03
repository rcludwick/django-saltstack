db:
    postgres_user.present:
        - name: {{ pillar['postgres.user'] }}
        - password: {{ pillar['postgres.pass'] }}
        - createdb: True
    postgres_database.present:
        - name: {{ pillar['postgres.db'] }}
        - owner: {{ pillar['postgres.user'] }}
     
