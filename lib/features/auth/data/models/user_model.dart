import 'package:expense_flow/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.token,
  });

  /// Factory constructor to parse incoming JSON maps from your API
  factory UserModel.fromJson(Map<String, dynamic> json) {
    // 1. Extract the user data object (might be under 'data' or 'user' key)
    final userData = json['data'] ?? json['user'] ?? {};

    return UserModel(
      // Support both '_id' (MongoDB) and 'id'
      id: userData['_id']?.toString() ?? userData['id']?.toString() ?? '',
      name: userData['name']?.toString() ?? '',
      email: userData['email']?.toString() ?? '',
      // Token is usually at the top level of the response
      token: json['token']?.toString(),
    );
  }

  /// Converts model structure back into map formatting
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      if (token != null) 'token': token,
    };
  }
}
