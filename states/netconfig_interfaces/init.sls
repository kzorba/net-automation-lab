netconfig_interfaces_recipe:
  netconfig.managed:
    - template_name: salt://netconfig_interfaces/templates/interfaces.jinja
    - data: {{ salt.pillar.get('openconfig-interfaces') | json }}
    - debug: True
