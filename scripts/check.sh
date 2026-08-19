#!/usr/bin/env bash
# CI와 동일한 검증을 로컬에서 실행한다: 포맷 검사 → 정적 분석 → 전체 테스트.
set -euo pipefail
cd "$(dirname "$0")/.."

echo "▶ format check (생성 파일 제외)"
find apps packages -name '*.dart' \
  ! -name '*.g.dart' ! -name '*.freezed.dart' \
  ! -name 'app_localizations*.dart' ! -path '*/.dart_tool/*' \
  -print0 | xargs -0 dart format --output=none --set-exit-if-changed

echo "▶ analyze"
flutter analyze

echo "▶ test"
./scripts/test.sh

echo "✅ 모든 검사 통과"
