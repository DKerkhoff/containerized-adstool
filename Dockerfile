FROM debian:stable-slim as build-env

RUN apt update && apt install -y \
	git \
	build-essential \
	meson

RUN git clone https://github.com/beckhoff/ADS.git ADS \
	&& cd ADS \
	&& meson setup build \
	&& ninja -C build

FROM debian:stable-slim as final

COPY --from=build-env /ADS /ADS

RUN cd /ADS \
    && install --mode=755 -D build/adstool "/usr/bin/adstool" \
	&& install --mode=755 -D build/libAdsLib.a "/usr/lib/libAdsLib.a" \
	&& find AdsLib -type f -name "*.h" -exec install --mode=644 -D {} "/usr/include/{}" \;

RUN cd / && rm -rf /ADS

ENTRYPOINT ["adstool"]
