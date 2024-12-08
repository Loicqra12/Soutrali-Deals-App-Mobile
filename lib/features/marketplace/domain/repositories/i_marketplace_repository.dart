import '../../data/models/product_model.dart';
import '../../data/models/product_category_model.dart';

abstract class IMarketplaceRepository {
  Future<List<ProductCategory>> getCategories();
  
  Future<List<ProductModel>> getFeaturedProducts();
  
  Future<List<ProductModel>> getProductsByCategory(String categoryId);
  
  Future<List<ProductModel>> searchProducts(String query);
  
  Future<ProductModel?> getProductById(String id);
  
  Future<List<ProductModel>> getSellerProducts(String sellerId);
  
  Future<ProductModel> createProduct(ProductModel product);
  
  Future<ProductModel> updateProduct(ProductModel product);
  
  Future<void> deleteProduct(String id);
  
  Future<void> incrementProductView(String id);
  
  Future<List<ProductModel>> getRecommendedProducts(String productId);
}
