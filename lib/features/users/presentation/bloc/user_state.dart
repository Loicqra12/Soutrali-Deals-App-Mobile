import 'package:equatable/equatable.dart';
import '../../../auth/data/models/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<UserModel> users;

  const UsersLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class ProvidersLoaded extends UserState {
  final List<UserModel> providers;

  const ProvidersLoaded(this.providers);

  @override
  List<Object> get props => [providers];
}

class UserProfileLoaded extends UserState {
  final UserModel user;

  const UserProfileLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserOperationSuccess extends UserState {
  final String message;
  final UserModel? user;

  const UserOperationSuccess(this.message, [this.user]);

  @override
  List<Object?> get props => [message, user];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}
