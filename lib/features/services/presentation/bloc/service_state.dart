import 'package:equatable/equatable.dart';
import '../../data/models/service_model.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object?> get props => [];
}

class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {}

class ServiceLoaded extends ServiceState {
  final List<ServiceModel> services;

  const ServiceLoaded(this.services);

  @override
  List<Object> get props => [services];
}

class ServiceError extends ServiceState {
  final String message;

  const ServiceError(this.message);

  @override
  List<Object> get props => [message];
}

class ServiceOperationSuccess extends ServiceState {
  final String message;

  const ServiceOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}
