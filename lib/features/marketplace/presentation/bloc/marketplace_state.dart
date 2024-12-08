import 'package:equatable/equatable.dart';
import '../../data/models/product_model.dart';
import '../../data/models/product_category_model.dart';

abstract class MarketplaceState extends Equatable {
  const MarketplaceState();

  @override
  List<Object?> get props => [];
}

class MarketplaceInitial extends MarketplaceState {}

class MarketplaceLoading extends MarketplaceState {}

class MarketplaceCategoriesLoaded extends MarketplaceState {
  final List<ProductCategory> categories;

  const MarketplaceCategoriesLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class MarketplaceFeaturedProductsLoaded extends MarketplaceState {
  final List<ProductModel> products;

  const MarketplaceFeaturedProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class MarketplaceProductsLoaded extends MarketplaceState {
  final List<ProductModel> products;
  final String? categoryId;

  const MarketplaceProductsLoaded(this.products, {this.categoryId});

  @override
  List<Object?> get props => [products, categoryId];
}

class MarketplaceError extends MarketplaceState {
  final String message;

  const MarketplaceError(this.message);

  @override
  List<Object> get props => [message];
}
