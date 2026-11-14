# soapysdrserver_container
Docker container for the SoapySDR server, a remote control and stream server for any SDR device that is supported by the SoapySDR libraries.

It works with SoapySDR compatible devices including:
* RTL-SDR, SDRplay, HackRF, BladeRF, AirSpy, Pluto and others

### Notes
This server includes [LibMiriSDR-6](https://github.com/BertoldVdb/libmirisdr-6) that adds support for all original SDRPlay devices but also for any Mirics MSi2500 and MSi001 based devices with enhanced capabilities.

### Defaults
* Port 55132/tcp is the control channel of SoapySDR server and is exposed by default

### User Configured Environment Variables
* none

#### Example docker run

```
docker run -d \
--restart unless-stopped \
--name='soapysdrserver' \
--device=/dev/bus/usb \
ghcr.io/f4fhh/soapysdrserver_container
```

### Container package
GitHub Actions builds and publishes multi-architecture images for `linux/amd64` and `linux/arm64` to [GitHub Container Registry](https://ghcr.io/f4fhh/soapysdrserver_container). Pushes to `main` update the `latest` tag; version tags (for example, `v1.0.0`) are also published. Pull requests build both architectures without publishing.

### HISTORY
 - Version 0.1.0: Initial build

### Credits
 - [SoapySDR](https://github.com/pothosware/SoapySDR) the vendor and platform neutral SDR support library
 - [SoapyRemote](https://github.com/pothosware/SoapyRemote) use any Soapy SDR remotely
 - [LibMiriSDR-6](https://github.com/BertoldVdb/libmirisdr-6) the library and tools for receivers built on the Mirics MSi2500 and MSi001 chips
