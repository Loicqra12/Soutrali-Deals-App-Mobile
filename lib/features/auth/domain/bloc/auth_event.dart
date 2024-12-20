import 'package:equatable/equatable.dart';
import '../models/user_type.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class AuthRegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String? phoneNumber;
  final List<UserType> userTypes;
  final Map<String, dynamic>? additionalInfo;

  const AuthRegisterRequested({
    required this.email,
    required this.password,
    required this.fullName,
    this.phoneNumber,
    required this.userTypes,
    this.additionalInfo,
  });

  @override
  List<Object?> get props => [email, password, fullName, phoneNumber, userTypes, additionalInfo];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthUpdateProfileRequested extends AuthEvent {
  final String? fullName;
  final String? phoneNumber;
  final String? profilePicture;
  final List<UserType>? userTypes;
  final Map<String, dynamic>? additionalInfo;

  const AuthUpdateProfileRequested({
    this.fullName,
    this.phoneNumber,
    this.profilePicture,
    this.userTypes,
    this.additionalInfo,
  });

  @override
  List<Object?> get props => [fullName, phoneNumber, profilePicture, userTypes, additionalInfo];
}

class AuthResetPasswordRequested extends AuthEvent {
  final String email;

  const AuthResetPasswordRequested({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}
