FROM gcr.io/distroless/static-debian12:debug@sha256:ecbc4ac563b95a132fd370065553857dcc38943066cb0662d09999011f3d3597

ARG TARGETARCH

# renovate: datasource=github-releases depName=buildpulse/test-reporter
ARG TEST_REPORTER_VERSION=v0.29.0

LABEL org.opencontainers.image.version="$TEST_REPORTER_VERSION"

ADD --chmod=0555 \
https://github.com/buildpulse/test-reporter/releases/download/${TEST_REPORTER_VERSION}/test_reporter_linux_${TARGETARCH} \
/usr/local/bin/buildpulse-test-reporter

COPY submit-reports.sh /usr/local/bin/submit-reports

ENTRYPOINT ["/usr/local/bin/submit-reports"]
