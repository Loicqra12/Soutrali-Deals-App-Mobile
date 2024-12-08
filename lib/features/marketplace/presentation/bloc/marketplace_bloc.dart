import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/i_marketplace_repository.dart';
import 'marketplace_event.dart';
import 'marketplace_state.dart';

class MarketplaceBloc extends Bloc<MarketplaceEvent, MarketplaceState> {
  final IMarketplaceRepository _marketplaceRepository;

  MarketplaceBloc({
    required IMarketplaceRepository marketplaceRepository,
  })  : _marketplaceRepository = marketplaceRepository,
        super(MarketplaceInitial()) {
    on<MarketplaceCategoriesFetchRequested>(_onCategoriesFetchRequested);
    on<MarketplaceFeaturedProductsFetchRequested>(_onFeaturedProductsFetchRequested);
    on<MarketplaceProductsByCategoryRequested>(_onProductsByCategoryRequested);
    on<MarketplaceProductSearchRequested>(_onProductSearchRequested);
    on<MarketplaceProductViewRequested>(_onProductViewRequested);
  }

  Future<void> _onCategoriesFetchRequested(
    MarketplaceCategoriesFetchRequested event,
    Emitter<MarketplaceState> emit,
  ) async {
    emit(MarketplaceLoading());
    try {
      final categories = await _marketplaceRepository.getCategories();
      emit(MarketplaceCategoriesLoaded(categories));
    } catch (e) {
      emit(MarketplaceError(e.toString()));
    }
  }

  Future<void> _onFeaturedProductsFetchRequested(
    MarketplaceFeaturedProductsFetchRequested event,
    Emitter<MarketplaceState> emit,
  ) async {
    emit(MarketplaceLoading());
    try {
      final products = await _marketplaceRepository.getFeaturedProducts();
      emit(MarketplaceFeaturedProductsLoaded(products));
    } catch (e) {
      emit(MarketplaceError(e.toString()));
    }
  }

  Future<void> _onProductsByCategoryRequested(
    MarketplaceProductsByCategoryRequested event,
    Emitter<MarketplaceState> emit,
  ) async {
    emit(MarketplaceLoading());
    try {
      final products = await _marketplaceRepository.getProductsByCategory(event.categoryId);
      emit(MarketplaceProductsLoaded(products, categoryId: event.categoryId));
    } catch (e) {
      emit(MarketplaceError(e.toString()));
    }
  }

  Future<void> _onProductSearchRequested(
    MarketplaceProductSearchRequested event,
    Emitter<MarketplaceState> emit,
  ) async {
    emit(MarketplaceLoading());
    try {
      final products = await _marketplaceRepository.searchProducts(event.query);
      emit(MarketplaceProductsLoaded(products));
    } catch (e) {
      emit(MarketplaceError(e.toString()));
    }
  }

  Future<void> _onProductViewRequested(
    MarketplaceProductViewRequested event,
    Emitter<MarketplaceState> emit,
  ) async {
    try {
      await _marketplaceRepository.incrementProductView(event.productId);
    } catch (e) {
      // Ignorer l'erreur car ce n'est pas critique
    }
  }
}
