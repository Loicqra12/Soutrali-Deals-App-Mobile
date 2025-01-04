import 'api_service.dart';

class AuthService {
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await ApiService.post('/users/login', {
        'email': email,
        'password': password,
      });

      if (response['token'] != null) {
        await ApiService.setToken(response['token']);
      }

      return response;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final response = await ApiService.post('/users/register', {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      });

      if (response['token'] != null) {
        await ApiService.setToken(response['token']);
      }

      return response;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  static Future<void> logout() async {
    try {
      await ApiService.post('/users/logout', {});
      await ApiService.setToken('');
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  static Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      return await ApiService.get('/users/me');
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  static Future<bool> verifyPhone({
    required String phone,
    required String code,
  }) async {
    try {
      final response = await ApiService.post('/users/verify-phone', {
        'phone': phone,
        'code': code,
      });
      return response['verified'] ?? false;
    } catch (e) {
      throw Exception('Phone verification failed: $e');
    }
  }

  static Future<void> resetPassword({
    required String email,
  }) async {
    try {
      await ApiService.post('/users/reset-password', {
        'email': email,
      });
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }
}
