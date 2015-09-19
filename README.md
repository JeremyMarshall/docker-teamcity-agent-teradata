# docker-teamcity-agent-teradata

This repo is to build a Docker Teamcity agent with a Teradata client

Its not quite as simple as that, you will also need to:-

* Download 

<http://downloads.teradata.com/download/connectivity/odbc-driver/linux>

* Create another Docker image from this one with a Dockerfile like this

```
FROM jeremymarshall/docker-teamcity-agent-teradata

  #add in DSNs for your Teradata servers
  RUN bin/td-odbc-add --dsn=<dsn> --DBCName=<ip|host>  --Username=<user> --Password=<pwd>

```

Supported parameters for td-odbc-add are:
* dsn
* Database
* Password
* Username
* DBCName
* Description
* DefaultDatabase

* Copy the downloaded tar.gz file above directly into the folder with the Dockerfile

* Build yourself your own container

```
docker build -t my-own-container \
    --force-rm=true --no-cache=true .
```

* You will also need a Teamcity Server

* Run your new container with 
```
docker run -e TEAMCITY_SERVER=http://builldserver7:8111 -dt \
    -p 9090:9090 my-own-container
```

* Builds on the fine work of https://hub.docker.com/r/ariya/centos7-teamcity-agent



