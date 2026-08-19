#!/usr/bin/env bash
# 빌드가 꼬였을 때의 전체 리셋: clean → pub get → codegen.
# (Android 네이티브의 clean + gradle sync + rebuild 에 해당)
# 이후 flutter run 하면 된다.
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
  echo "▶ clean: $p"
  (cd "$p" && flutter clean > /dev/null)
done

echo "▶ pub get (workspace)"
flutter pub get

echo "▶ codegen"
./scripts/gen.sh

echo "✅ reset 완료 — flutter run --flavor dev -t lib/main_dev.dart"
