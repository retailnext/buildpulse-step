# `buildpulse-step`

This docker image packages the
[BuildPulse test reporter](https://github.com/buildpulse/test-reporter) for
convenient use as a step in Google Cloud Build or similar Docker-centric
CI/CD systems.

It additionally includes an entrypoint that will glob for xml report files
in a specified directory and pass them as arguments in the right spot. Any
arguments passed to the container will be passed along to the test reporter
_after_ the report file paths.

This shell script (or an injected script doing something similar) is needed
because the test reporter itself doesn't have any option to submit test
reports without including every file as an argument.

## Usage

In addition to the environment variables
[required by the test reporter](https://github.com/buildpulse/test-reporter?tab=readme-ov-file#other-ci-providers--standalone-usage),
you also must set `REPORTS_DIRECTORY` to the location where the files that
should be submitted will be found.

If `REPORTS_DIRECTORY` is unset or does not exist, the entrypoint will exit 1.
If `REPORTS_DIRECTORY` is empty, it will print a warning, then exit 0.

Sample Google Cloud Build step:

```yaml
  - id: "Submit test reports to BuildPulse"
    name: "ghcr.io/retailnext/buildpulse-step"
    env:
      - "BUILD_URL=https://console.cloud.google.com/cloud-build/builds;region=${LOCATION}/${BUILD_ID}?project=${PROJECT_ID}"
      - "GIT_BRANCH=$_PR_NUMBER"
      - "GIT_COMMIT=$COMMIT_SHA"
      - "ORGANIZATION_NAME=...yourgithubusername..."
      - "REPORTS_DIRECTORY=/results/reports"
      - "REPOSITORY_NAME=$REPO_NAME"
    secretEnv:
      - "BUILDPULSE_ACCESS_KEY_ID"
      - "BUILDPULSE_SECRET_ACCESS_KEY"
    args:
      - "--account-id=1234"
      - "--repository-id=567890"
    volumes:
      - name: 'reports'
        path: '/results/reports'
```

## License

The [LICENSE file in this repository](./LICENSE) applies only to the contents
of this repository. The base image and the test reporter itself are under
other licenses.

For the license of the test reporter itself, see:
https://github.com/buildpulse/test-reporter/blob/main/LICENSE
