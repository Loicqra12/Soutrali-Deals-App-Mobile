import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/i_user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final IUserRepository _userRepository;

  UserBloc({
    required IUserRepository userRepository,
  })  : _userRepository = userRepository,
        super(UserInitial()) {
    on<UsersFetchRequested>(_onUsersFetchRequested);
    on<ProvidersFetchRequested>(_onProvidersFetchRequested);
    on<UserProfileFetchRequested>(_onUserProfileFetchRequested);
    on<UserProfileUpdateRequested>(_onUserProfileUpdateRequested);
    on<UserProfileImageUpdateRequested>(_onUserProfileImageUpdateRequested);
    on<ProviderDataUpdateRequested>(_onProviderDataUpdateRequested);
    on<ProviderVerificationRequested>(_onProviderVerificationRequested);
    on<ProvidersSearchRequested>(_onProvidersSearchRequested);
  }

  Future<void> _onUsersFetchRequested(
    UsersFetchRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final users = await _userRepository.getAll();
      emit(UsersLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onProvidersFetchRequested(
    ProvidersFetchRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final providers = await _userRepository.getProviders();
      emit(ProvidersLoaded(providers));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onUserProfileFetchRequested(
    UserProfileFetchRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final user = await _userRepository.getById(event.userId);
      if (user != null) {
        emit(UserProfileLoaded(user));
      } else {
        emit(const UserError('User not found'));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onUserProfileUpdateRequested(
    UserProfileUpdateRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final updatedUser = await _userRepository.update(event.user);
      emit(UserOperationSuccess(
        'Profile updated successfully',
        updatedUser,
      ));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onUserProfileImageUpdateRequested(
    UserProfileImageUpdateRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      await _userRepository.updateProfileImage(
        event.userId,
        event.imageUrl,
      );
      final user = await _userRepository.getById(event.userId);
      if (user != null) {
        emit(UserOperationSuccess(
          'Profile image updated successfully',
          user,
        ));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onProviderDataUpdateRequested(
    ProviderDataUpdateRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      await _userRepository.updateProviderData(
        event.userId,
        event.providerData,
      );
      final user = await _userRepository.getById(event.userId);
      if (user != null) {
        emit(UserOperationSuccess(
          'Provider data updated successfully',
          user,
        ));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onProviderVerificationRequested(
    ProviderVerificationRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      await _userRepository.verifyProvider(event.providerId);
      final provider = await _userRepository.getById(event.providerId);
      if (provider != null) {
        emit(UserOperationSuccess(
          'Provider verified successfully',
          provider,
        ));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onProvidersSearchRequested(
    ProvidersSearchRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final providers = await _userRepository.searchProviders(event.query);
      emit(ProvidersLoaded(providers));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
