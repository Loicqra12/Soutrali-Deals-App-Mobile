import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/i_service_repository.dart';
import 'service_event.dart';
import 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final IServiceRepository _serviceRepository;

  ServiceBloc({
    required IServiceRepository serviceRepository,
  })  : _serviceRepository = serviceRepository,
        super(ServiceInitial()) {
    on<ServicesFetchRequested>(_onServicesFetchRequested);
    on<ServiceCategoryFetchRequested>(_onServiceCategoryFetchRequested);
    on<ServiceProviderFetchRequested>(_onServiceProviderFetchRequested);
    on<ServiceCreateRequested>(_onServiceCreateRequested);
    on<ServiceUpdateRequested>(_onServiceUpdateRequested);
    on<ServiceDeleteRequested>(_onServiceDeleteRequested);
    on<ServiceSearchRequested>(_onServiceSearchRequested);
    on<ServiceToggleAvailabilityRequested>(_onServiceToggleAvailabilityRequested);
  }

  Future<void> _onServicesFetchRequested(
    ServicesFetchRequested event,
    Emitter<ServiceState> emit,
  ) async {
    emit(ServiceLoading());
    try {
      final services = await _serviceRepository.getAll();
      emit(ServiceLoaded(services));
    } catch (e) {
      emit(ServiceError(e.toString()));
    }
  }

  Future<void> _onServiceCategoryFetchRequested(
    ServiceCategoryFetchRequested event,
    Emitter<ServiceState> emit,
  ) async {
    emit(ServiceLoading());
    try {
      final services = await _serviceRepository.getByCategory(event.categoryId);
      emit(ServiceLoaded(services));
    } catch (e) {
      emit(ServiceError(e.toString()));
    }
  }

  Future<void> _onServiceProviderFetchRequested(
    ServiceProviderFetchRequested event,
    Emitter<ServiceState> emit,
  ) async {
    emit(ServiceLoading());
    try {
      final services = await _serviceRepository.getByProvider(event.providerId);
      emit(ServiceLoaded(services));
    } catch (e) {
      emit(ServiceError(e.toString()));
    }
  }

  Future<void> _onServiceCreateRequested(
    ServiceCreateRequested event,
    Emitter<ServiceState> emit,
  ) async {
    emit(ServiceLoading());
    try {
      await _serviceRepository.create(event.service);
      final services = await _serviceRepository.getAll();
      emit(ServiceLoaded(services));
      emit(const ServiceOperationSuccess('Service created successfully'));
    } catch (e) {
      emit(ServiceError(e.toString()));
    }
  }

  Future<void> _onServiceUpdateRequested(
    ServiceUpdateRequested event,
    Emitter<ServiceState> emit,
  ) async {
    emit(ServiceLoading());
    try {
      await _serviceRepository.update(event.service);
      final services = await _serviceRepository.getAll();
      emit(ServiceLoaded(services));
      emit(const ServiceOperationSuccess('Service updated successfully'));
    } catch (e) {
      emit(ServiceError(e.toString()));
    }
  }

  Future<void> _onServiceDeleteRequested(
    ServiceDeleteRequested event,
    Emitter<ServiceState> emit,
  ) async {
    emit(ServiceLoading());
    try {
      await _serviceRepository.delete(event.serviceId);
      final services = await _serviceRepository.getAll();
      emit(ServiceLoaded(services));
      emit(const ServiceOperationSuccess('Service deleted successfully'));
    } catch (e) {
      emit(ServiceError(e.toString()));
    }
  }

  Future<void> _onServiceSearchRequested(
    ServiceSearchRequested event,
    Emitter<ServiceState> emit,
  ) async {
    emit(ServiceLoading());
    try {
      final services = await _serviceRepository.search(event.query);
      emit(ServiceLoaded(services));
    } catch (e) {
      emit(ServiceError(e.toString()));
    }
  }

  Future<void> _onServiceToggleAvailabilityRequested(
    ServiceToggleAvailabilityRequested event,
    Emitter<ServiceState> emit,
  ) async {
    emit(ServiceLoading());
    try {
      await _serviceRepository.toggleAvailability(event.serviceId);
      final services = await _serviceRepository.getAll();
      emit(ServiceLoaded(services));
      emit(const ServiceOperationSuccess('Service availability updated'));
    } catch (e) {
      emit(ServiceError(e.toString()));
    }
  }
}
