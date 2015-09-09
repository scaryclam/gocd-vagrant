oracle_java_repo:
  pkgrepo.managed:
    - humanname: OracleJava
    - name: deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
    - dist: trusty
    - file: /etc/apt/sources.list.d/oraclejava.list
    - keyid: EEA14886
    - keyserver: keyserver.ubuntu.com

oracle-license-select:
  cmd.run:
    - unless: which java
    - name: '/bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections'
    - require_in:
      - pkg: core
      - cmd: oracle-license-seen-lie

oracle-license-seen-lie:
  cmd.run:
    - name: '/bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections'
    - require_in:
      - pkg: core

core:
  pkg.installed:
    - pkgs:
      - vim
      - supervisor
      - memcached
      - oracle-java8-installer
      - unzip
      - git
      - python-pip
    - refresh: True
    - require_in:
      - cmd: go_server_install

/tmp/go-server-15.2.0-2248.deb:
  file.managed:
    - name: /tmp/go-server-15.2.0-2248.deb
    - source: http://download.go.cd/gocd-deb/go-server-15.2.0-2248.deb
    - source_hash: sha1=63847ce16d559e9cb4d2204ead64b9bccc72fe6e
    - require_in:
      - cmd: go_server_install

/tmp/go-agent-15.2.0-2248.deb:
  file.managed:
    - name: /tmp/go-agent-15.2.0-2248.deb
    - source: http://download.go.cd/gocd-deb/go-agent-15.2.0-2248.deb
    - source_hash: sha1=2a970a5f7e83dd89813c48b261fa6ca11c2d4dcf
    - require_in:
      - cmd: go_agent_install

go_server_install:
  cmd.run:
    - name: dpkg -i /tmp/go-server-15.2.0-2248.deb

go_agent_install:
  cmd.run:
    - name: dpkg -i /tmp/go-agent-15.2.0-2248.deb

fabric:
  pip.installed:
    - name: fabric

jinja2:
  pip.installed:
    - name: jinja2

