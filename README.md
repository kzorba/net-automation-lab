# net-automation-lab
A network automation lab using docker containers

The idea is to demonstrate network devices' orchestration and configuration using salt. The initial intent is to create a simple topology of 2 interconnected routers and configure a BGP peering between them via salt. Salt setup will contain a master plus 2 minion proxy containers (each minion will control one network device). In this very initial version of the project we just create the salt containers and we use dummy states in proxy minions. 

We base our docker images on `phusion/baseimage:0.11` (utilizing Ubuntu 18.04). We can build container images using salt `2017.7` branch and/or `2018.3` (uncomment/comment the relevant stuff in the Dockerfiles and docker-compose.yml). The setup is controlled via a Makefile and docker-compose.

Build images with:
```
docker-compose build salt-master
docker-compose build proxy_1
```

**Note:** There seems to be a small issue with `2018.3` salt branch, an ERROR is logged in the master console:
```
salt-master    | [ERROR   ] Failed to load function {'cmd': '_file_envs'}.envs because its module ({'cmd': '_file_envs'}) is not in the whitelist: [u'roots']
salt-master    | [ERROR   ] Failed to load function {'cmd': '_file_envs.envs because its module ({'cmd': '_file_envs) is not in the whitelist: [u'roots']
```
nothing seems to be affected in the example commands below. See relevant issue [saltstack/salt#50781](https://github.com/saltstack/salt/issues/50781)

## Example Usage
```
kzorba@machine:~/WorkingArea$ git clone https://github.com/kzorba/net-automation-lab.git
...
kzorba@machine:~/WorkingArea$ cd net-automation-lab
kzorba@machine:~/WorkingArea/net-automation-lab$ make 
Usage: make (start|stop|master-cli)

kzorba@machine:~/WorkingArea/net-automation-lab$ make start
Using docker compose file: docker-compose.yml
docker-compose -f docker-compose.yml up 
Creating network "net-automation-lab_default" with the default driver
Creating salt-master ... done
Creating proxy-vmx1  ... done
Creating proxy-vmx2  ... done
Attaching to salt-master, proxy-vmx2, proxy-vmx1
proxy-vmx2     | *** Running /etc/my_init.d/00_regen_ssh_host_keys.sh...
salt-master    | *** Running /etc/my_init.d/00_regen_ssh_host_keys.sh...
salt-master    | *** Running /etc/my_init.d/10_syslog-ng.init...
proxy-vmx2     | *** Running /etc/my_init.d/10_syslog-ng.init...
salt-master    | Dec 11 09:46:22 salt-master syslog-ng[15]: syslog-ng starting up; version='3.13.2'
salt-master    | *** Booting runit daemon...
proxy-vmx2     | Dec 11 09:46:23 proxy-vmx2 syslog-ng[15]: syslog-ng starting up; version='3.13.2'
salt-master    | *** Runit started as PID 22
salt-master    | Dec 11 09:46:22 salt-master cron[27]: (CRON) INFO (pidfile fd = 3)
salt-master    | Dec 11 09:46:22 salt-master cron[27]: (CRON) INFO (Running @reboot jobs)
proxy-vmx1     | *** Running /etc/my_init.d/00_regen_ssh_host_keys.sh...
proxy-vmx1     | *** Running /etc/my_init.d/10_syslog-ng.init...
proxy-vmx1     | Dec 11 09:46:23 proxy-vmx1 syslog-ng[15]: syslog-ng starting up; version='3.13.2'
proxy-vmx1     | *** Booting runit daemon...
proxy-vmx1     | *** Runit started as PID 22
proxy-vmx1     | Dec 11 09:46:23 proxy-vmx1 cron[26]: (CRON) INFO (pidfile fd = 3)
proxy-vmx1     | Dec 11 09:46:23 proxy-vmx1 cron[26]: (CRON) INFO (Running @reboot jobs)
proxy-vmx2     | *** Booting runit daemon...
proxy-vmx2     | *** Runit started as PID 24
proxy-vmx2     | Dec 11 09:46:24 proxy-vmx2 cron[28]: (CRON) INFO (pidfile fd = 3)
proxy-vmx2     | Dec 11 09:46:24 proxy-vmx2 cron[28]: (CRON) INFO (Running @reboot jobs)
...
```

Running the above in a terminal will keep the output of all docker container consoles (logging verbosity for master and proxies can be affected in `net-lab.params` file). From another terminal we can get a shell in the salt master and give a few commands:
```
kzorba@machine:~/WorkingArea/net-automation-lab$ make master-cli
docker exec -ti salt-master bash
root@salt-master:/#
root@salt-master:/# salt '*' test.ping
proxy-vmx2:
    True
proxy-vmx1:
    True
root@salt-master:/# 
root@salt-master:/# salt '*' state.apply test
proxy-vmx1:
----------
          ID: Yay it works
    Function: test.succeed_without_changes
      Result: True
     Comment: Success!
     Started: 10:06:49.001523
    Duration: 0.461 ms
     Changes:   

Summary for proxy-vmx1
------------
Succeeded: 1
Failed:    0
------------
Total states run:     1
Total run time:   0.461 ms
proxy-vmx2:
----------
          ID: Yay it works
    Function: test.succeed_without_changes
      Result: True
     Comment: Success!
     Started: 10:06:49.022716
    Duration: 0.444 ms
     Changes:   

Summary for proxy-vmx2
------------
Succeeded: 1
Failed:    0
------------
Total states run:     1
Total run time:   0.444 ms
```
For a clean shutdown:
```
root@salt-master:/# exit
kzorba@machine:~/WorkingArea/net-automation-lab$ make stop
Using docker compose file: docker-compose.yml
docker-compose -f docker-compose.yml down
Stopping proxy-vmx1  ... done
Stopping proxy-vmx2  ... done
Stopping salt-master ... done
Removing proxy-vmx1  ... done
Removing proxy-vmx2  ... done
Removing salt-master ... done
Removing network net-automation-lab_default
```

Many thanks to @mirceaulinic and @phusion for all their work. My repo is just a playground to familiarize myself with the relevant technologies, so (for now at least) nothing here is new or original.


