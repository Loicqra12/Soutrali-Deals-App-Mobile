import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../../domain/models/user_type.dart';
import '../models/user_model.dart';

class AuthRepository implements IAuthRepository {
  final SharedPreferences _prefs;
  static const String _userKey = 'user';
  static const String _tokenKey = 'token';
  static const String _baseUrl = 'http://localhost:3000/api';

  AuthRepository(this._prefs);

  @override
  Future<String?> getToken() async {
    return _prefs.getString(_tokenKey);
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final token = await getToken();
      if (token == null) return null;

      final response = await http.get(
        Uri.parse('$_baseUrl/users/me'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        final user = UserModel.fromJson(userData);
        await _saveUserData(user, token);
        return user;
      }
      return null;
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/users/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = UserModel.fromJson(data['user']);
        final token = data['token'];
        await _saveUserData(user, token);
        return user;
      } else {
        throw Exception(json.decode(response.body)['message'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      final token = await getToken();
      if (token != null) {
        await http.post(
          Uri.parse('$_baseUrl/users/logout'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
      }
    } catch (e) {
      print('Error during logout: $e');
    } finally {
      await _prefs.remove(_userKey);
      await _prefs.remove(_tokenKey);
    }
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String firstname,
    required String surname,
    required UserType userType,
    String? phoneNumber,
    Map<String, dynamic>? additionalInfo,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
          'firstname': firstname,
          'surname': surname,
          'telephone': phoneNumber,
          'userType': userType.name,
          'additionalInfo': additionalInfo,
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        final user = UserModel.fromJson(data['user']);
        final token = data['token'];
        await _saveUserData(user, token);
        return user;
      } else {
        throw Exception(json.decode(response.body)['message'] ?? 'Registration failed');
      }
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<UserModel> updateProfile(UserModel user) async {
    // TODO: Implement actual API call
    await _saveUserData(user, await getToken() ?? '');
    return user;
  }

  @override
  Future<bool> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    // TODO: Implement actual API call
    return true;
  }

  @override
  Future<bool> resetPassword(String email) async {
    // TODO: Implement actual API call
    return true;
  }

  @override
  Future<bool> verifyEmail(String code) async {
    // TODO: Implement actual API call
    return true;
  }

  @override
  Future<String?> refreshToken() async {
    // TODO: Implement actual API call
    return null;
  }

  Future<void> _saveUserData(UserModel user, String token) async {
    await _prefs.setString(_userKey, json.encode(user.toJson()));
    await _prefs.setString(_tokenKey, token);
  }
}
