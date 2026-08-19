#!/usr/bin/env bash
# 코드 생성이 필요한 모든 패키지에서 build_runner를 실행한다.
# 사용: ./scripts/gen.sh [--watch 대신 clean 빌드가 기본]
set -euo pipefail
cd "$(dirname "$0")/.."

PACKAGES=(
  packages/app_core
  packages/app_network
  packages/app_storage
  packages/features/feature_auth
  packages/features/feature_example
  apps/app
)

echo "▶ gen-l10n: packages/app_l10n"
(cd packages/app_l10n && flutter gen-l10n)

for p in "${PACKAGES[@]}"; do
  echo "▶ codegen: $p"
  (cd "$p" && dart run build_runner build --delete-conflicting-outputs)
done
