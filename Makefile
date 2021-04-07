name := securebanking-spring-config-server
repo := sbat-gcr-develop

.PHONY: all
all: clean test package

clean:
	rm -f ${name}.jar
	mvn clean

test:
	mvn verify

package:
	mvn package -DskipTests=true

docker: clean package
ifndef tag
	$(error "You must supply a docker tag")
endif
	cp target/${name}-*.jar ./${name}.jar
	docker build -t eu.gcr.io/${repo}/securebanking/spring-config-server:${tag} .
	docker push eu.gcr.io/${repo}/securebanking/spring-config-server:${tag}