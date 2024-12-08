import 'package:http/http.dart' as http;
import '../../../../core/repositories/base_repository.dart';
import '../../../auth/data/models/user_model.dart';
import '../../domain/repositories/i_user_repository.dart';

class UserRepository implements IUserRepository {
  final http.Client _client;
  static const String _baseUrl = 'API_BASE_URL'; // TODO: Replace with actual API URL

  UserRepository(this._client);

  @override
  Future<UserModel> create(UserModel user) async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }

  @override
  Future<bool> delete(String id) async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }

  @override
  Future<List<UserModel>> getAll() async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }

  @override
  Future<UserModel?> getById(String id) async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }

  @override
  Future<UserModel> update(UserModel user) async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }

  @override
  Future<List<UserModel>> getProviders() async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }

  @override
  Future<bool> updateProfileImage(String userId, String imageUrl) async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }

  @override
  Future<bool> updateProviderData(
    String userId,
    Map<String, dynamic> providerData,
  ) async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }

  @override
  Future<bool> verifyProvider(String providerId) async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }

  @override
  Future<List<UserModel>> searchProviders(String query) async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }
}
