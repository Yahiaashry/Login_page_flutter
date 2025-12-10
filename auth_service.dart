import 'package:dio/dio.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

class AuthService {
  late final Dio _dio;
  static const String _baseUrl = 'https://dummyjson.com';

  AuthService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  Future<AuthResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'username': username, 'password': password, 'expiresInMins': 30},
      );

      if (response.statusCode == 200) {
        final userData = response.data as Map<String, dynamic>;
        final user = UserModel.fromJson(userData);
        return AuthResponse.success(user);
      } else {
        return AuthResponse.failure('Login failed. Please try again.');
      }
    } on DioException catch (e) {
      return AuthResponse.failure(_handleDioError(e));
    } catch (e) {
      return AuthResponse.failure(
        'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection.';

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 400 || statusCode == 401) {
          return 'Invalid username or password. Please try again.';
        } else if (statusCode == 500) {
          return 'Server error. Please try again later.';
        }
        return 'Request failed with status code: $statusCode';

      case DioExceptionType.cancel:
        return 'Request was cancelled.';

      case DioExceptionType.connectionError:
        return 'Network error. Please check your internet connection.';

      case DioExceptionType.badCertificate:
        return 'Security certificate error.';

      case DioExceptionType.unknown:
      default:
        return 'Network error. Please check your connection and try again.';
    }
  }
}
