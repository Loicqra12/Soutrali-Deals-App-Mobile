import 'package:equatable/equatable.dart';
import '../../domain/models/user_type.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final UserType userType;
  final String? phoneNumber;
  final String? avatarUrl;
  final Map<String, dynamic>? additionalInfo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.userType,
    this.phoneNumber,
    this.avatarUrl,
    this.additionalInfo,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      userType: UserType.values.firstWhere(
        (type) => type.toString() == 'UserType.${json['userType']}',
        orElse: () => UserType.particular,
      ),
      phoneNumber: json['phoneNumber'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      additionalInfo: json['additionalInfo'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'userType': userType.toString().split('.').last,
      'phoneNumber': phoneNumber,
      'avatarUrl': avatarUrl,
      'additionalInfo': additionalInfo,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? fullName,
    UserType? userType,
    String? phoneNumber,
    String? avatarUrl,
    Map<String, dynamic>? additionalInfo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        fullName,
        userType,
        phoneNumber,
        avatarUrl,
        additionalInfo,
        createdAt,
        updatedAt,
      ];
}
