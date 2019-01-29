base: 
  '*':
    - ntp
  'proxy-vmx*':      # All minions with a minion_id that begins with 'proxy-vmx'
    - netconfig_interfaces  
