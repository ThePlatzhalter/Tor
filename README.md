# platzhalter/tor Dockerfile

This repository contains the Dockerfile of [Tor](https://www.torproject.org/) for running a TOR client in a docker container.

## Base Image

I based my image on the [Debian 8 Jessie](https://registry.hub.docker.com/_/debian/) image.

## Usage

1. Create a folder containing your [torrc](http://www.bsdnow.tv/tutorials/tor) file used by [Tor](https://www.torproject.org/). Make sure you're using absolute filepaths to make sure Tor will **always** be able to parse your configs.
2. Run it doing: `docker run -p 127.0.0.1:9050:9050 -v /path/to/your/configuration/directory:/tor -d platzhalter/tor

## Hidden Services

- Place your hidden service configuration in the same folder as your `torrc`
  - If you don't have those, nevermind, just let Tor generate them automatically.
- Create a new network by doing `docker network create --subnet=172.20.0.0/24`
  - *(Of course you can use any subnet you want to use. Just make sure it's not used by anything else to avoid collision.)* 
- From now on, you need to use the `--net tor --ip 172.20.0.100` flags when starting the Tor container.
- Also, you need to configure all of your hidden services to use the same net by using the `--net tor --ip 172.20.0.<somenumber>` flags when starting them.
  - You don't need to expose their ports if you want them to be accessible via Tor only!
- After that, configure your `torrc` as follows:

  ```
  HiddenServiceDir /tor/<servicename>
  HiddenServivePort <port> 172.20.0.<number>:<port>
  HiddenServicePort ........
  ```

## Notes

- You need at least Docker version 1.10.1 to assign static ip addresses to the machine.
