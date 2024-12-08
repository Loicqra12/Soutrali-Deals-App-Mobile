import 'package:equatable/equatable.dart';
import '../../data/models/service_model.dart';

abstract class ServiceEvent extends Equatable {
  const ServiceEvent();

  @override
  List<Object?> get props => [];
}

class ServicesFetchRequested extends ServiceEvent {}

class ServiceCategoryFetchRequested extends ServiceEvent {
  final String categoryId;

  const ServiceCategoryFetchRequested(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class ServiceProviderFetchRequested extends ServiceEvent {
  final String providerId;

  const ServiceProviderFetchRequested(this.providerId);

  @override
  List<Object> get props => [providerId];
}

class ServiceCreateRequested extends ServiceEvent {
  final ServiceModel service;

  const ServiceCreateRequested(this.service);

  @override
  List<Object> get props => [service];
}

class ServiceUpdateRequested extends ServiceEvent {
  final ServiceModel service;

  const ServiceUpdateRequested(this.service);

  @override
  List<Object> get props => [service];
}

class ServiceDeleteRequested extends ServiceEvent {
  final String serviceId;

  const ServiceDeleteRequested(this.serviceId);

  @override
  List<Object> get props => [serviceId];
}

class ServiceSearchRequested extends ServiceEvent {
  final String query;

  const ServiceSearchRequested(this.query);

  @override
  List<Object> get props => [query];
}

class ServiceToggleAvailabilityRequested extends ServiceEvent {
  final String serviceId;

  const ServiceToggleAvailabilityRequested(this.serviceId);

  @override
  List<Object> get props => [serviceId];
}
