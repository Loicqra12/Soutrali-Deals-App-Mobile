import 'package:equatable/equatable.dart';
import '../../../auth/data/models/user_model.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UsersFetchRequested extends UserEvent {}

class ProvidersFetchRequested extends UserEvent {}

class UserProfileFetchRequested extends UserEvent {
  final String userId;

  const UserProfileFetchRequested(this.userId);

  @override
  List<Object> get props => [userId];
}

class UserProfileUpdateRequested extends UserEvent {
  final UserModel user;

  const UserProfileUpdateRequested(this.user);

  @override
  List<Object> get props => [user];
}

class UserProfileImageUpdateRequested extends UserEvent {
  final String userId;
  final String imageUrl;

  const UserProfileImageUpdateRequested({
    required this.userId,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [userId, imageUrl];
}

class ProviderDataUpdateRequested extends UserEvent {
  final String userId;
  final Map<String, dynamic> providerData;

  const ProviderDataUpdateRequested({
    required this.userId,
    required this.providerData,
  });

  @override
  List<Object> get props => [userId, providerData];
}

class ProviderVerificationRequested extends UserEvent {
  final String providerId;

  const ProviderVerificationRequested(this.providerId);

  @override
  List<Object> get props => [providerId];
}

class ProvidersSearchRequested extends UserEvent {
  final String query;

  const ProvidersSearchRequested(this.query);

  @override
  List<Object> get props => [query];
}
