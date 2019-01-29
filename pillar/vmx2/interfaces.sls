openconfig-interfaces:
  interfaces:
    interface:
      fxp0:
        config:
          description: vmx2 mgmt interface
          name: fxp0
        name: fxp0
        subinterfaces:
          subinterface:
            '0':
              config:
                description: vmx2 fxp0.0
                index: 0
              index: '0'
              ipv4:
                addresses:
                  address:
                    172.16.0.11:
                      config:
                        ip: 172.16.0.11
                        prefix-length: 24
                      ip: 172.16.0.11
              ipv6:
                addresses:
                  address:
                    fd00::11:
                      config:
                        ip: fd00::11
                        prefix-length: 64
                      ip: fd00::11
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
                description: p2p vmx2 - vmx1
                index: 0
              index: '0'
              ipv4:
                addresses:
                  address:
                    10.1.0.10:
                      config:
                        ip: 10.1.0.10
                        prefix-length: 30
                      ip: 10.1.0.10
              ipv6:
                addresses:
                  address:
                    fd00:1::10:
                      config:
                        ip: fd00:1::10
                        prefix-length: 127
                      ip: fd00:1::10
      lo0:
        config:
          description: vmx2 loopback interface
          name: lo0
        name: lo0
        subinterfaces:
          subinterface:
            '0':
              config:
                description: vmx2 lo0.0
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
                    13.13.13.2:
                      config:
                        ip: 13.13.13.2
                        prefix-length: 32
                      ip: 13.13.13.2
              ipv6:
                addresses:
                  address:
                    ::1:
                      config:
                        ip: ::1
                        prefix-length: 128
                      ip: ::1
                    fd00:13::2:
                      config:
                        ip: fd00:13::2
                        prefix-length: 128
                      ip: fd00:13::2
