import '../../data/models/user_model.dart';
import '../models/user_type.dart';

abstract class IAuthRepository {
  Future<UserModel?> getCurrentUser();
  Future<String?> getToken();
  Future<bool> isAuthenticated();
  Future<UserModel> login(String email, String password);
  Future<void> logout();
  Future<UserModel> register({
    required String email,
    required String password,
    required String firstname,
    required String surname,
    required UserType userType,
    String? phoneNumber,
    Map<String, dynamic>? additionalInfo,
  });
  Future<bool> resetPassword(String email);
  Future<bool> verifyEmail(String code);
  Future<UserModel> updateProfile(UserModel user);
  Future<bool> updatePassword({
    required String currentPassword,
    required String newPassword,
  });
  Future<String?> refreshToken();
}
