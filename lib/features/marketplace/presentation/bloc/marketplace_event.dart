import 'package:equatable/equatable.dart';

abstract class MarketplaceEvent extends Equatable {
  const MarketplaceEvent();

  @override
  List<Object?> get props => [];
}

class MarketplaceCategoriesFetchRequested extends MarketplaceEvent {}

class MarketplaceFeaturedProductsFetchRequested extends MarketplaceEvent {}

class MarketplaceProductsByCategoryRequested extends MarketplaceEvent {
  final String categoryId;

  const MarketplaceProductsByCategoryRequested(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class MarketplaceProductSearchRequested extends MarketplaceEvent {
  final String query;

  const MarketplaceProductSearchRequested(this.query);

  @override
  List<Object> get props => [query];
}

class MarketplaceProductViewRequested extends MarketplaceEvent {
  final String productId;

  const MarketplaceProductViewRequested(this.productId);

  @override
  List<Object> get props => [productId];
}
