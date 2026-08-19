/// 예제 feature — 살아있는 매뉴얼.
///
/// 새 feature를 만들 때 이 패키지 구조를 그대로 복제한다:
///
/// ```text
/// src/
/// ├── domain/          # 엔티티(freezed) + Repository 인터페이스. 외부 의존 없음.
/// ├── data/            # DTO(json) + API(dio) + Repository 구현(캐시 폴백)
/// └── presentation/    # 화면별 MVI 5파일 (screen/view_model/state/intent/effect)
/// ```
///
/// 시연하는 패턴:
/// - 네트워크 우선 + 오프라인 캐시 폴백 (posts_repository_impl.dart)
/// - MVI 초기 로드 / pull-to-refresh / 재시도 (post_list_view_model.dart)
/// - Effect 기반 네비게이션 (post_list_effect.dart → screen의 onEffect)
/// - 파라미터를 받는 ViewModel — provider family (post_detail_view_model.dart)
library;

export 'src/presentation/post_detail/post_detail_screen.dart';
export 'src/presentation/post_list/post_list_screen.dart';
