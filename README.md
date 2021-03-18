# Experiment running Java UI in containers.

Able to run the application locally, on Kubernetes Desktop, but not with hosted Kubernetes!

## Pre-requisites:

Create a sample Java UI application image

```bash
docker build -t swing-chachkies .
```

Install xterm dependencies

```bash
brew install socat
brew cask reinstall xquartz
```

I needed to restart after installing `xquartz`

## Run instructions

Make sure that port 6000 is available

```bash
lsof -i TCP:6000
```

Open socket on this port

```bash
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
```

Verify that it is open

```bash
lsof -i TCP:6000
COMMAND  PID      USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
socat   2793 ashumilov    5u  IPv4 0xfd46e891304e6ec5      0t0  TCP *:6000 (LISTEN)
```

Run the application

```bash
docker run -e DISPLAY=docker.for.mac.host.internal:0 swing-chachkies
```

Resources:

[This post helped a lot](https://stackoverflow.com/questions/37826094/xt-error-cant-open-display-if-using-default-display)
