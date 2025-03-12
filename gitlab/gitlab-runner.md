# Install gitlab-runner docker composer
```
version: "3.5"

services:
  dind:
    image: docker:28.0.1-dind
    restart: always
    privileged: true
    environment:
      DOCKER_TLS_CERTDIR: ""
    command:
      - --storage-driver=overlay2

  runner:
    restart: always
    image: registry.gitlab.com/gitlab-org/gitlab-runner:alpine
    depends_on:
      - dind
    environment:
      - DOCKER_HOST=tcp://dind:2375
    volumes:
      - ./config:/etc/gitlab-runner:z

  register-runner:
    restart: 'no'
    image: registry.gitlab.com/gitlab-org/gitlab-runner:alpine
    depends_on:
      - dind
    environment:
      - CI_SERVER_URL=${CI_SERVER_URL}
      - REGISTRATION_TOKEN=${REGISTRATION_TOKEN}
    command:
      - register
      - --non-interactive
      - --locked=false
      - --name=${RUNNER_NAME}
      - --tag-list=${TAG}
      - --executor=docker
      - --docker-image=docker:28.0.1-dind
      - --docker-volumes=/var/run/docker.sock:/var/run/docker.sock
    volumes:
      - ./config:/etc/gitlab-runner:z
```
