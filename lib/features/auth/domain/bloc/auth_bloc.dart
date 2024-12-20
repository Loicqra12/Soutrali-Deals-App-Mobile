import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_type.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../models/user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SharedPreferences _prefs;

  AuthBloc(this._prefs) : super(AuthState.initial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthUpdateProfileRequested>(_onAuthUpdateProfileRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final userJson = _prefs.getString('user');
      if (userJson != null) {
        final userData = jsonDecode(userJson);
        final user = User.fromJson(userData);
        emit(AuthState.authenticated(user));
      } else {
        emit(AuthState.unauthenticated());
      }
    } catch (e) {
      emit(AuthState.error('Échec de la vérification de l\'authentification: $e'));
    }
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthState.loading());
      
      // TODO: Implement actual API login
      // Simulating API call
      await Future.delayed(const Duration(seconds: 2));
      
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: event.email,
        fullName: 'Utilisateur Test',
        userTypes: [UserType.particular],
        isEmailVerified: false,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );
      
      await _prefs.setString('user', jsonEncode(user.toJson()));
      emit(AuthState.authenticated(user));
    } catch (e) {
      emit(AuthState.error('Échec de la connexion: $e'));
    }
  }

  Future<void> _onAuthRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthState.loading());
      
      // TODO: Implement actual API registration
      // Simulating API call
      await Future.delayed(const Duration(seconds: 2));
      
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: event.email,
        fullName: event.fullName,
        phoneNumber: event.phoneNumber,
        userTypes: event.userTypes,
        isEmailVerified: false,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
        additionalInfo: event.additionalInfo,
      );
      
      await _prefs.setString('user', jsonEncode(user.toJson()));
      emit(AuthState.authenticated(user));
    } catch (e) {
      emit(AuthState.error('Échec de l\'inscription: $e'));
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthState.loading());
      await _prefs.remove('user');
      emit(AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.error('Échec de la déconnexion: $e'));
    }
  }

  Future<void> _onAuthUpdateProfileRequested(
    AuthUpdateProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      if (state.user == null) {
        throw Exception('Aucun utilisateur authentifié trouvé');
      }

      emit(AuthState.loading());
      
      final updatedUser = state.user!.copyWith(
        fullName: event.fullName,
        phoneNumber: event.phoneNumber,
        profilePicture: event.profilePicture,
        userTypes: event.userTypes,
        additionalInfo: event.additionalInfo,
      );

      // TODO: Implement actual API profile update
      await Future.delayed(const Duration(seconds: 1));
      
      await _prefs.setString('user', jsonEncode(updatedUser.toJson()));
      emit(AuthState.authenticated(updatedUser));
    } catch (e) {
      emit(AuthState.error('Échec de la mise à jour du profil: $e'));
    }
  }
}
