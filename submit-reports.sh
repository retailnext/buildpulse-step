#!/busybox/sh
set -euo pipefail

if [ ! -d "$REPORTS_DIRECTORY" ]; then
    echo "Reports directory ($REPORTS_DIRECTORY) is missing!"
    exit 1
fi

if [ -n "$(find "$REPORTS_DIRECTORY" -maxdepth 0 -type d -empty)" ]; then
    echo "Warning: Reports directory ($REPORTS_DIRECTORY) is empty!"
    exit 0
fi

exec buildpulse-test-reporter submit "$REPORTS_DIRECTORY"/*.xml "$@"
