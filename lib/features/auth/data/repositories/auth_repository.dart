import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../../domain/models/user_type.dart';
import '../models/user_model.dart';

class AuthRepository implements IAuthRepository {
  final SharedPreferences _prefs;
  static const String _userKey = 'user';
  static const String _tokenKey = 'token';

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
    final userJson = _prefs.getString(_userKey);
    if (userJson != null) {
      return UserModel.fromJson(json.decode(userJson));
    }
    return null;
  }

  @override
  Future<UserModel> login(String email, String password) async {
    // TODO: Implement actual API call
    final user = UserModel(
      id: '1',
      email: email,
      fullName: 'Test User',
      userType: UserType.particular,
      phoneNumber: null,
    );
    await _saveUserData(user, 'test_token'); // Simulating token
    return user;
  }

  @override
  Future<void> logout() async {
    await _prefs.remove(_userKey);
    await _prefs.remove(_tokenKey);
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String fullName,
    required UserType userType,
    String? phoneNumber,
    Map<String, dynamic>? additionalInfo,
  }) async {
    // TODO: Implement actual API call
    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      fullName: fullName,
      userType: userType,
      phoneNumber: phoneNumber,
      additionalInfo: additionalInfo,
      createdAt: DateTime.now(),
    );
    await _saveUserData(user, 'test_token'); // Simulating token
    return user;
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
