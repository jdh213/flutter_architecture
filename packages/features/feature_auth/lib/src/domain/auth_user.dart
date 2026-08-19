/// 인증된 사용자 도메인 엔티티.
class AuthUser {
  const AuthUser({
    required this.id,
    required this.name,
    required this.email,
  });

  final String id;
  final String name;
  final String email;
}
