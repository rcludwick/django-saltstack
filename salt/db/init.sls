db:
    postgres_user.present:
        - name: {{ pillar['postgres.user'] }}
        - password: {{ pillar['postgres.pass'] }}
        - createdb: True
    postgres_database.present:
        - require:
            - postgres_user.present: 
                - name: {{ pillar['postgres.user'] }}
            - pkg: postgresql
            - service: postgresql 

        - name: {{ pillar['postgres.db'] }}
        - owner: {{ pillar['postgres.user'] }}
     
