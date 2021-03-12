# Secure Banking Spring Cloud Config server

A configuration server app using Spring Cloud Config Server. By default, it runs on port 8888. Example endpoint call:

```
http://localhost:8888/securebanking-openbanking-uk-rcs/docker
```

## Running from the command line
From the command line (after building), run with the following command (replace `[VERSION]` (e.g. with `1.0.0-SNAPSHOT`) 
and `[GIT_REPO_URL]` (e.g. with `git@github.com:SecureBankingAcceleratorToolkit/securebanking-openbanking-spring-config.git`) as appropriate):

```shell script
java -jar target/securebanking-spring-config-server-[VERSION].jar \
  --spring.cloud.config.server.git.uri=[GIT_REPO_URL]
``` 

For example:
```shell script
java -jar target/securebanking-spring-config-server-1.0.0-SNAPSHOT.jar \
  --spring.cloud.config.server.git.uri=git@github.com:SecureBankingAcceleratorToolkit/securebanking-openbanking-spring-config.git
```

N.B. To target a different branch to master, provide the parameter 
`--spring.cloud.config.server.git.default-label=[BRANCH_NAME]`.

## Running using Docker
Example command line usage:
```shell script
docker run -e SSH_KEY="`cat ~/.ssh/id_rsa`" -d \
  eu.gcr.io/openbanking-214714/securebanking/securebanking-config-server:1.0.0-SNAPSHOT \
  --spring.cloud.config.server.git.uri=git@github.com:SecureBankingAcceleratorToolkit/securebanking-openbanking-spring-config.git
```

Example command line usage with a local file system repository:
```shell script
docker run -v ~/code/securebanking-configs:/home/dockeruser/config -d \
  eu.gcr.io/openbanking-214714/securebanking/securebanking-config-server:1.0.0-SNAPSHOT \
  --spring.cloud.config.server.native.searchLocations=file:./config/{profile} \
  --spring.profiles.active=native \
  --spring.cloud.config.server.native.addLabelLocations=false
```