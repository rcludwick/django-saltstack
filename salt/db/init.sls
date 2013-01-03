db:
    postgres_user.present:
        - name: {{ pillar['postgres.user'] }}
        - password: {{ pillar['postgres.pass'] }}

            
     
