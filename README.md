# Containerized adstool

Build and run [adstool](https://github.com/Beckhoff/ADS/tree/master/AdsTool) from within a container.

## Usage

```sh
docker build --tag="adstool" .
docker run -it --rm adstool
```

Have a look in the [Dockerfile](Dockerfile) for the details.