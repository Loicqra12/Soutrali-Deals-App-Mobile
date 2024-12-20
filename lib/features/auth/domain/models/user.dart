import 'package:equatable/equatable.dart';
import 'user_type.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final String? phoneNumber;
  final List<UserType> userTypes;
  final String? profilePicture;
  final bool isEmailVerified;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final Map<String, dynamic>? additionalInfo;

  const User({
    required this.id,
    required this.email,
    required this.fullName,
    this.phoneNumber,
    required this.userTypes,
    this.profilePicture,
    required this.isEmailVerified,
    required this.createdAt,
    this.lastLoginAt,
    this.additionalInfo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      userTypes: (json['userTypes'] as List<dynamic>)
          .map((e) => UserType.values.firstWhere((type) => type.name == e))
          .toList(),
      profilePicture: json['profilePicture'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'] as String)
          : null,
      additionalInfo: json['additionalInfo'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'userTypes': userTypes.map((type) => type.name).toList(),
      'profilePicture': profilePicture,
      'isEmailVerified': isEmailVerified,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'additionalInfo': additionalInfo,
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phoneNumber,
    List<UserType>? userTypes,
    String? profilePicture,
    bool? isEmailVerified,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    Map<String, dynamic>? additionalInfo,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userTypes: userTypes ?? this.userTypes,
      profilePicture: profilePicture ?? this.profilePicture,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        fullName,
        phoneNumber,
        userTypes,
        profilePicture,
        isEmailVerified,
        createdAt,
        lastLoginAt,
        additionalInfo,
      ];
}
