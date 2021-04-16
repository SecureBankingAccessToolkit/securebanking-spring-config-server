name := securebanking-spring-config-server
repo := sbat-gcr-develop
tag  := $(shell mvn help:evaluate -Dexpression=project.version -q -DforceStdout)

.PHONY: all
all: clean verify dev

clean:
	mvn clean

verify: clean
	mvn verify -Ddockerfile.skip

docker: clean
	mvn package dockerfile:push -DskipTests=true -Dtag=${tag} \
	  -DgcrRepo=${repo} --file pom.xml

helm: clean
ifndef version
	$(error A version must be supplied, Eg. make helm version=1.0.0)
endif
	helm dep up _infra/helm/${name}
	helm template _infra/helm/${name}
	helm package _infra/helm/${name}
	mv ./${name}-*.tgz ./${name}-${version}.tgz

dev: clean
	mvn package -DskipTests=true -Dtag=latest -DgcrRepo=${repo} \
	  --file pom.xml

version:
	@echo $(tag)
