import 'dart:convert';
import 'package:shared_preferences.dart';
import '../../domain/models/user.dart';

class AuthLocalStorage {
  static const String _keyUser = 'user';
  static const String _keyToken = 'token';
  
  final SharedPreferences _prefs;

  AuthLocalStorage(this._prefs);

  Future<void> saveUser(User user) async {
    await _prefs.setString(_keyUser, jsonEncode(user.toJson()));
  }

  Future<void> saveToken(String token) async {
    await _prefs.setString(_keyToken, token);
  }

  Future<User?> getUser() async {
    final userStr = _prefs.getString(_keyUser);
    if (userStr == null) return null;
    try {
      return User.fromJson(jsonDecode(userStr));
    } catch (e) {
      return null;
    }
  }

  Future<String?> getToken() async {
    return _prefs.getString(_keyToken);
  }

  Future<void> clearSession() async {
    await _prefs.remove(_keyUser);
    await _prefs.remove(_keyToken);
  }

  Future<bool> hasActiveSession() async {
    final token = await getToken();
    final user = await getUser();
    return token != null && user != null;
  }
}
