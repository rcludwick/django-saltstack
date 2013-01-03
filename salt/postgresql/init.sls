postgresql:
    pkg:
        - installed
    service:
        - require:
            - pkg: postgresql
        - running


