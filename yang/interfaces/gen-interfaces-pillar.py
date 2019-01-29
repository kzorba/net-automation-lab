#!/usr/bin/env python

# Copyright 2019 Kostas Zorbadelos

"""
Generate YAML file for salt pillar containing router interfaces configuration.
Configuration adheres to Openconfig interfaces model.

Usage:
  gen-interfaces-pillar.py (--version|--help)
  gen-interfaces-pillar.py [-i <indent>] [--ietf] [<interfaces_file>] [<pillar_file>] 

Arguments:
  -i, --indent=INDENT  Number of spaces to indent [default: 2].
  --ietf               Produce YAML output according to IETF conventions 
                       (default is Openconfig conventions).
  <interfaces_file>    The input file containing a network device's interfaces in YAML 
                       format. This information should come from a network inventory 
                       system in a real setup. If not specified, reads from stdin.
  <pillar_file>        The output file to be used in Salt pillar. YAML format, conforms to 
                       openconfig interfaces YANG model.
                       See https://github.com/openconfig/public (openconfig-interfaces.yang, 
                       openconfig-if-ip.yang).
                       This should be pushed as configuration to the target device via Salt.  
                       If not specified, writes to stdout.
"""

import sys
import collections
import json
import yaml
import docopt
from binding import openconfig_interfaces
import pyangbind.lib.pybindJSON as pybindJSON

__version__ = "0.1"
    
if __name__ == "__main__":
    args = docopt.docopt(
        __doc__,
        version="version "+__version__
    )
    interfaces_file = sys.stdin
    if args.get('<interfaces_file>'):
        interfaces_file = open(args.get('<interfaces_file>'), 'r')
    pillar_file = sys.stdout
    if args.get('<pillar_file>'):    
        pillar_file = open(args.get('<pillar_file>'), 'w')
    indent_arg = int(args.get('--indent'))
        
    loaded_yaml = yaml.load(interfaces_file)        
    # create an openconfig_interfaces instance
    ocif = openconfig_interfaces()
    for interface in loaded_yaml['interfaces']:
        ri = ocif.interfaces.interface.add(interface['name'])
        ri.config.name = interface['name']
        if 'description' in interface:
            ri.config.description = interface['description']
        if 'mtu' in interface:
            ri.config.mtu = interface['mtu']
        for subinterface in interface['subinterfaces']:
            rs = ri.subinterfaces.subinterface.add(subinterface['index'])
            rs.config.index = subinterface['index']
            if 'description' in subinterface:
                rs.config.description = subinterface['description']
            for ipv4 in subinterface['ipv4']:
                if '/' in ipv4:
                    ip, ip_prefix = ipv4.split('/')
                else:
                    ip = ipv4
                    ip_prefix = 32                    
                rip4 = rs.ipv4.addresses.address.add(ip)
                rip4.config.ip = ip
                rip4.config.prefix_length = ip_prefix

            for ipv6 in subinterface['ipv6']:
                if '/' in ipv6:
                    ip, ip_prefix = ipv6.split('/')
                else:
                    ip = ipv6
                    ip_prefix = 128
                rip6 = rs.ipv6.addresses.address.add(ip)
                rip6.config.ip = ip
                rip6.config.prefix_length = ip_prefix
            
    if args.get('--ietf'):
        js = pybindJSON.dumps(ocif, mode='ietf')
    else:
        js = pybindJSON.dumps(ocif)
        
    loaded_json = json.loads(js, object_pairs_hook=collections.OrderedDict)
    pillar_json = {}
    pillar_json['openconfig-interfaces'] = loaded_json
    loaded_json = json.loads(json.dumps(pillar_json))
    yaml.safe_dump(loaded_json, pillar_file, default_flow_style=False, indent=indent_arg)
