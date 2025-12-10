import 'user_model.dart';

class AuthResponse {
  final bool success;
  final UserModel? user;
  final String? errorMessage;

  AuthResponse({required this.success, this.user, this.errorMessage});

  factory AuthResponse.success(UserModel user) {
    return AuthResponse(success: true, user: user);
  }

  factory AuthResponse.failure(String errorMessage) {
    return AuthResponse(success: false, errorMessage: errorMessage);
  }
}
