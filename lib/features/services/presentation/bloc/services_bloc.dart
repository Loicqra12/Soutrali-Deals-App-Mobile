import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class ServicesEvent extends Equatable {
  const ServicesEvent();

  @override
  List<Object> get props => [];
}

class LoadServices extends ServicesEvent {}

class SearchServices extends ServicesEvent {
  final String query;

  const SearchServices(this.query);

  @override
  List<Object> get props => [query];
}

// States
abstract class ServicesState extends Equatable {
  const ServicesState();

  @override
  List<Object> get props => [];
}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesLoaded extends ServicesState {
  final List<ServiceCategory> categories;
  final List<ServiceProvider> providers;

  const ServicesLoaded({
    required this.categories,
    required this.providers,
  });

  @override
  List<Object> get props => [categories, providers];
}

class ServicesError extends ServicesState {
  final String message;

  const ServicesError(this.message);

  @override
  List<Object> get props => [message];
}

// Models
class ServiceCategory {
  final String id;
  final String name;
  final String imageUrl;
  final String type;

  ServiceCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.type,
  });
}

class ServiceProvider {
  final String id;
  final String name;
  final String imageUrl;
  final double price;

  ServiceProvider({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });
}

// BLoC
class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesInitial()) {
    on<LoadServices>(_onLoadServices);
    on<SearchServices>(_onSearchServices);
  }

  Future<void> _onLoadServices(
    LoadServices event,
    Emitter<ServicesState> emit,
  ) async {
    emit(ServicesLoading());
    try {
      // Simuler le chargement des données
      await Future.delayed(const Duration(seconds: 1));
      
      final categories = [
        ServiceCategory(
          id: '1',
          name: 'Maçonnerie',
          imageUrl: 'assets/images/masonry.jpg',
          type: 'Catégorie',
        ),
        ServiceCategory(
          id: '2',
          name: 'Menuisier',
          imageUrl: 'assets/images/carpenter.jpg',
          type: 'Catégorie',
        ),
        ServiceCategory(
          id: '3',
          name: 'Mécanique',
          imageUrl: 'assets/images/mechanic.jpg',
          type: 'Catégorie',
        ),
        ServiceCategory(
          id: '4',
          name: 'Plomberie',
          imageUrl: 'assets/images/plumber.jpg',
          type: 'Catégorie',
        ),
      ];

      final providers = [
        ServiceProvider(
          id: '1',
          name: 'Marc',
          imageUrl: 'assets/images/provider1.jpg',
          price: 1000,
        ),
        ServiceProvider(
          id: '2',
          name: 'Elie',
          imageUrl: 'assets/images/provider2.jpg',
          price: 1000,
        ),
        ServiceProvider(
          id: '3',
          name: 'Tratra',
          imageUrl: 'assets/images/provider3.jpg',
          price: 1000,
        ),
        ServiceProvider(
          id: '4',
          name: 'OLI',
          imageUrl: 'assets/images/provider4.jpg',
          price: 1000,
        ),
      ];

      emit(ServicesLoaded(categories: categories, providers: providers));
    } catch (e) {
      emit(ServicesError(e.toString()));
    }
  }

  Future<void> _onSearchServices(
    SearchServices event,
    Emitter<ServicesState> emit,
  ) async {
    if (state is ServicesLoaded) {
      final currentState = state as ServicesLoaded;
      final query = event.query.toLowerCase();

      final filteredCategories = currentState.categories
          .where((category) => 
              category.name.toLowerCase().contains(query))
          .toList();

      final filteredProviders = currentState.providers
          .where((provider) => 
              provider.name.toLowerCase().contains(query))
          .toList();

      emit(ServicesLoaded(
        categories: filteredCategories,
        providers: filteredProviders,
      ));
    }
  }
}
