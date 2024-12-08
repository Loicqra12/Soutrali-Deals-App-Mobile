import 'package:equatable/equatable.dart';
import '../../data/models/user_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  const LoginSubmitted({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class RegisterSubmitted extends AuthEvent {
  final UserModel user;

  const RegisterSubmitted({required this.user});

  @override
  List<Object> get props => [user];
}

class LogoutRequested extends AuthEvent {}

class UpdateProfileRequested extends AuthEvent {
  final UserModel user;

  const UpdateProfileRequested({required this.user});

  @override
  List<Object> get props => [user];
}

class UpdatePasswordRequested extends AuthEvent {
  final String currentPassword;
  final String newPassword;

  const UpdatePasswordRequested({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [currentPassword, newPassword];
}

class ResetPasswordRequested extends AuthEvent {
  final String email;

  const ResetPasswordRequested({required this.email});

  @override
  List<Object> get props => [email];
}

class VerifyEmailRequested extends AuthEvent {
  final String code;

  const VerifyEmailRequested({required this.code});

  @override
  List<Object> get props => [code];
}