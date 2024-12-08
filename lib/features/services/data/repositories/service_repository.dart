import 'package:http/http.dart' as http;
import '../../../../core/repositories/base_repository.dart';
import '../models/service_model.dart';
import '../../domain/repositories/i_service_repository.dart';

class ServiceRepository implements IServiceRepository {
  final http.Client _client;
  static const String _baseUrl = 'API_BASE_URL'; // TODO: Replace with actual API URL

  ServiceRepository(this._client);

  @override
  Future<ServiceModel> create(ServiceModel service) async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }

  @override
  Future<bool> delete(String id) async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }

  @override
  Future<List<ServiceModel>> getAll() async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }

  @override
  Future<ServiceModel?> getById(String id) async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }

  @override
  Future<ServiceModel> update(ServiceModel service) async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }

  @override
  Future<List<ServiceModel>> getByCategory(String categoryId) async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }

  @override
  Future<List<ServiceModel>> getByProvider(String providerId) async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }

  @override
  Future<List<ServiceModel>> search(String query) async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }

  @override
  Future<bool> toggleAvailability(String serviceId) async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }

  @override
  Future<bool> updateGallery(String serviceId, List<String> gallery) async {
    // TODO: Implement actual API call
    throw UnimplementedError('API implementation pending');
  }
}
