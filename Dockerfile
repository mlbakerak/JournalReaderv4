ARG IMAGE=store/intersystems/iris-community:2020.1.0.204.0
#ARG IMAGE=intersystemsdc/iris-community:2020.1.0.209.0-zpm
#ARG IMAGE=intersystemsdc/iris-community:2020.2.0.204.0-zpm
#ARG IMAGE=intersystemsdc/irishealth-community:2020.3.0.200.0-zpm
#ARG IMAGE=intersystemsdc/iris-community:2020.3.0.221.0-zpm
#ARG IMAGE=intersystemsdc/iris-community:2020.4.0.547.0-zpm
ARG IMAGE=store/intersystems/iris-community:2021.1.0.205.0
FROM $IMAGE

USER root   
## add git
RUN apt update && apt-get -y install git
        
WORKDIR /opt/irisbuild
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisbuild
USER ${ISC_PACKAGE_MGRUSER}

COPY  src src
COPY Installer.cls zstart.int iris.scr /opt/irisbuild/

RUN iris start IRIS \
	&& iris session IRIS < iris.scr \
    && iris stop IRIS quietly
