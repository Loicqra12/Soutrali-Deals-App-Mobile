import '../../../../core/repositories/base_repository.dart';
import '../../data/models/service_model.dart';

abstract class IServiceRepository extends BaseRepository<ServiceModel> {
  Future<List<ServiceModel>> getByCategory(String categoryId);
  Future<List<ServiceModel>> getByProvider(String providerId);
  Future<List<ServiceModel>> search(String query);
  Future<bool> toggleAvailability(String serviceId);
  Future<bool> updateGallery(String serviceId, List<String> gallery);
}
