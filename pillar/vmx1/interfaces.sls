openconfig-interfaces:
  interfaces:
    interface:
      fxp0:
        config:
          description: vmx1 mgmt interface
          name: fxp0
        name: fxp0
        subinterfaces:
          subinterface:
            '0':
              config:
                description: vmx1 fxp0.0
                index: 0
              index: '0'
              ipv4:
                addresses:
                  address:
                    172.16.0.10:
                      config:
                        ip: 172.16.0.10
                        prefix-length: 24
                      ip: 172.16.0.10
              ipv6:
                addresses:
                  address:
                    fd00::10:
                      config:
                        ip: fd00::10
                        prefix-length: 64
                      ip: fd00::10
      ge-0/0/0:
        config:
          description: net1_p2p
          mtu: 9000
          name: ge-0/0/0
        name: ge-0/0/0
        subinterfaces:
          subinterface:
            '0':
              config:
                description: p2p vmx1 - vmx2
                index: 0
              index: '0'
              ipv4:
                addresses:
                  address:
                    10.1.0.9:
                      config:
                        ip: 10.1.0.9
                        prefix-length: 30
                      ip: 10.1.0.9
              ipv6:
                addresses:
                  address:
                    fd00:1::9:
                      config:
                        ip: fd00:1::9
                        prefix-length: 127
                      ip: fd00:1::9
      lo0:
        config:
          description: vmx1 loopback interface
          name: lo0
        name: lo0
        subinterfaces:
          subinterface:
            '0':
              config:
                description: vmx1 lo0.0
                index: 0
              index: '0'
              ipv4:
                addresses:
                  address:
                    127.0.0.1:
                      config:
                        ip: 127.0.0.1
                        prefix-length: 32
                      ip: 127.0.0.1
                    13.13.13.1:
                      config:
                        ip: 13.13.13.1
                        prefix-length: 32
                      ip: 13.13.13.1
              ipv6:
                addresses:
                  address:
                    ::1:
                      config:
                        ip: ::1
                        prefix-length: 128
                      ip: ::1
                    fd00:13::1:
                      config:
                        ip: fd00:13::1
                        prefix-length: 128
                      ip: fd00:13::1
