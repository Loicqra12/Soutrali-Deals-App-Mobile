import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user_type.dart';

// États
class SignupState {
  final UserType? selectedType;
  final String? name;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final String? profileImagePath;
  final String? identityDocPath;
  final int currentStep;

  SignupState({
    this.selectedType,
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.profileImagePath,
    this.identityDocPath,
    this.currentStep = 0,
  });

  SignupState copyWith({
    UserType? selectedType,
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    String? profileImagePath,
    String? identityDocPath,
    int? currentStep,
  }) {
    return SignupState(
      selectedType: selectedType ?? this.selectedType,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      identityDocPath: identityDocPath ?? this.identityDocPath,
      currentStep: currentStep ?? this.currentStep,
    );
  }
}

// Événements
abstract class SignupEvent {}

class UserTypeSelected extends SignupEvent {
  final UserType type;
  UserTypeSelected(this.type);
}

class ProfileImageSelected extends SignupEvent {
  final String imagePath;
  ProfileImageSelected(this.imagePath);
}

class IdentityDocumentUploaded extends SignupEvent {
  final String documentPath;
  IdentityDocumentUploaded(this.documentPath);
}

// BLoC
class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState()) {
    on<UserTypeSelected>((event, emit) {
      emit(state.copyWith(
        selectedType: event.type,
        currentStep: state.currentStep + 1,
      ));
    });

    on<ProfileImageSelected>((event, emit) {
      emit(state.copyWith(profileImagePath: event.imagePath));
    });

    on<IdentityDocumentUploaded>((event, emit) {
      emit(state.copyWith(identityDocPath: event.documentPath));
    });
  }
}
