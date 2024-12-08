import '../../../../core/repositories/base_repository.dart';
import '../../../auth/data/models/user_model.dart';

abstract class IUserRepository extends BaseRepository<UserModel> {
  Future<List<UserModel>> getProviders();
  Future<bool> updateProfileImage(String userId, String imageUrl);
  Future<bool> updateProviderData(String userId, Map<String, dynamic> providerData);
  Future<bool> verifyProvider(String providerId);
  Future<List<UserModel>> searchProviders(String query);
}
