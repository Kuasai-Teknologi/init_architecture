#!/bin/bash

set -e

PROJECT_PATH="${1:-.}"
COVERAGE_DIR="./coverage"
PROJECT_COVERAGE="${COVERAGE_DIR}/lcov.info"
FILTERED_COVERAGE="${COVERAGE_DIR}/filtered.info"
INITIAL_PATH="$(pwd)"

cd "${PROJECT_PATH}"

rm -rf "${COVERAGE_DIR}"

# Jalankan pengujian dan hasilkan laporan coverage
dart test --coverage="${COVERAGE_DIR}"

# Konversi laporan ke format LCOV
dart pub global activate coverage
dart pub global run coverage:format_coverage \
  --lcov \
  --in="${COVERAGE_DIR}" \
  --out="${PROJECT_COVERAGE}" \
  --packages=".dart_tool/package_config.json" \
  --report-on="lib"

# Filter file tertentu dari laporan coverage
lcov --remove "${PROJECT_COVERAGE}" -o "${FILTERED_COVERAGE}" \
  '**/*.g.dart' \
  '**/l10n/*.dart' \
  '**/app/bootstrap.dart' \
  '**/*.gen.dart' \
  --ignore-errors unused

# Generate laporan HTML dari file LCOV
genhtml "${FILTERED_COVERAGE}" -o "${COVERAGE_DIR}"

# Buka laporan coverage di browser (opsional)
open "${COVERAGE_DIR}/index.html"

cd "${INITIAL_PATH}"

# exit 0