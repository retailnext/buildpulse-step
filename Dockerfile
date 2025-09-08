FROM gcr.io/distroless/static-debian12:debug@sha256:c7f818f4678fe4ceb0412a370e8e41ca373d5dde25039b84f9cccb72ef558542

ARG TARGETARCH

# renovate: datasource=github-releases depName=buildpulse/test-reporter
ARG TEST_REPORTER_VERSION=v0.29.0

LABEL org.opencontainers.image.version="$TEST_REPORTER_VERSION"

ADD --chmod=0555 \
https://github.com/buildpulse/test-reporter/releases/download/${TEST_REPORTER_VERSION}/test_reporter_linux_${TARGETARCH} \
/usr/local/bin/buildpulse-test-reporter

COPY submit-reports.sh /usr/local/bin/submit-reports

ENTRYPOINT ["/usr/local/bin/submit-reports"]
