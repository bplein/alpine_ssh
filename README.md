# bplein/alpine_ssh

Small ssh server for special use cases. Uses a directory called "saves" for the user home. I use port 30022 but you can change this yourself OR use docker runtime port mapping to adjust. 

User is sshuser, password is created on docker build. So this image is useless for you unless you rebuild it yourself. 

## Usage

	docker run -d -it -p 30022:30022/tcp -v <SOME LOCAL HOST DIRECTORY>:/saves --restart=always bplein/alpine_ssh:latest
