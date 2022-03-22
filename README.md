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
  --spring.cloud.config.server.git.ignoreLocalSshSettings=false \
  --spring.cloud.config.server.git.uri=[GIT_REPO_URL]
``` 

For example:
```shell script
java -jar target/securebanking-spring-config-server-1.0.0-SNAPSHOT.jar \
  --spring.cloud.config.server.git.ignoreLocalSshSettings=false \
  --spring.cloud.config.server.git.uri=git@github.com:SecureBankingAcceleratorToolkit/securebanking-openbanking-spring-config.git
```

N.B. To target a different branch to master, provide the parameter 
`--spring.cloud.config.server.git.default-label=[BRANCH_NAME]`.

## Running using Docker
Example command line usage:
```shell script
docker run -e GIT_CONFIG_SSH_KEY="`cat ~/.ssh/id_rsa`" \
  eu.gcr.io/openbanking-214714/securebanking/securebanking-config-server:1.0.0-SNAPSHOT \
  --spring.cloud.config.server.git.uri=git@github.com:SecureBankingAcceleratorToolkit/securebanking-openbanking-spring-config.git
```

These assume the host machine has the appropriate SSH configuration.

## SSH Troubleshooting

### Auth fail
This can be caused by the private key not being found. It can be fixed by creating a file called `~/.ssh/config` with 
the following contents (where `~/.ssh/id_rsa` is the path to your private key):
```
Host github.com
  IdentityFile ~/.ssh/id_rsa
``` 
If you still get the same error, then you may need to prefix the repository URL with `ssh://` 
(e.g. `ssh://git@github.com:SecureBankingAcceleratorToolkit/securebanking-openbanking-spring-config.git`).

### Invalid privatekey
One cause of this is that the private key is in the new OpenSSH format. If it is, the header will be:
```
-----BEGIN OPENSSH PRIVATE KEY-----
```
instead of
```
-----BEGIN RSA PRIVATE KEY-----
```

To create a private key in the old format, run the following:
```shell script
ssh-keygen -t rsa -m PEM
```

Don't forget to update the `~/.ssh/config` file if you have one, and have used a different key path.
