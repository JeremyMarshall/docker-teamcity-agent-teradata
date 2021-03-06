FROM ariya/centos7-teamcity-agent
  MAINTAINER Jeremy Marshall
  RUN yum -y install ksh tar java-1.7.0-openjdk git cpanm gcc perl perl-App-cpanminus perl-Config-Tiny &&  yum clean all

  ADD setup-agent.sh /setup-agent.sh

  ONBUILD ADD  tdodbc__linux_indep.*.tar.gz tmp/
  ONBUILD RUN pushd tmp && find . -name '*.tar.gz' -exec tar zxvf {} --strip=1 \; && popd
  ONBUILD RUN rpm -ivh --nodeps tmp/TeraGSS_linux_x64-15.*.noarch.rpm  tmp/tdicu-15.*.noarch.rpm  tmp/tdodbc-15.*.noarch.rpm; yum clean all;

  ENV ODBCHOME=/opt/teradata/client/ODBC_64/ ODBCINI=/opt/teradata/client/ODBC_64/odbc.ini

  ONBUILD RUN cpanm install DBD::ODBC; rm -fr root/.cpanm; exit 0

  ADD td-odbc-add bin/td-odbc-add

  #add add a dsn into the image
  #RUN bin/td-odbc-add --dsn=<dsn> --DBCName=<ip|host>  --Username=<user> --Password=<pwd> 

