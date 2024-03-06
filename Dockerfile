FROM gcr.io/distroless/static-debian12:debug@sha256:3bf402f046eb78387fd0d6489ae1dcaaa95a21339c16657cc47e5cbd6353b642

ARG TARGETARCH

# renovate: datasource=github-releases depName=buildpulse/test-reporter
ARG TEST_REPORTER_VERSION=v0.28.0

LABEL org.opencontainers.image.version="$TEST_REPORTER_VERSION"

ADD --chmod=0555 \
https://github.com/buildpulse/test-reporter/releases/download/${TEST_REPORTER_VERSION}/test_reporter_linux_${TARGETARCH} \
/usr/local/bin/buildpulse-test-reporter

COPY submit-reports.sh /usr/local/bin/submit-reports

ENTRYPOINT ["/usr/local/bin/submit-reports"]
