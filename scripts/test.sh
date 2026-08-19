#!/usr/bin/env bash
# 모든 패키지의 테스트를 실행한다.
set -euo pipefail
cd "$(dirname "$0")/.."

PACKAGES=(
  packages/app_core
  packages/app_mvi
  packages/app_network
  packages/app_storage
  packages/app_design_system
  packages/features/feature_auth
  packages/features/feature_example
  apps/app
)

for p in "${PACKAGES[@]}"; do
  echo "▶ test: $p"
  (cd "$p" && flutter test)
done
