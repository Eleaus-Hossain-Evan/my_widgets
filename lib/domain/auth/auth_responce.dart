import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'model/user_model.dart';

class AuthResponse extends Equatable {
  final Data data;
  final bool success;
  final String message;
  const AuthResponse({
    required this.data,
    required this.success,
    required this.message,
  });

  AuthResponse copyWith({
    Data? data,
    bool? success,
    String? message,
  }) {
    return AuthResponse(
      data: data ?? this.data,
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.toMap(),
      'success': success,
      'message': message,
    };
  }

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      data: Data.fromMap(map['data']),
      success: map['success'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromJson(String source) =>
      AuthResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'AuthResponse(data: $data, success: $success, message: $message)';

  @override
  List<Object> get props => [data, success, message];
}

class Data extends Equatable {
  final UserModel user;
  final String token;
  final int exp;
  const Data({
    required this.user,
    required this.token,
    required this.exp,
  });

  Data copyWith({
    UserModel? user,
    String? token,
    int? exp,
  }) {
    return Data(
      user: user ?? this.user,
      token: token ?? this.token,
      exp: exp ?? this.exp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentData': user.toMap(),
      'token': token,
      'exp': exp,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      user: UserModel.fromMap(map['studentData']),
      token: map['token'] ?? '',
      exp: map['exp']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() => 'Data(studentData: $user, token: $token, exp: $exp)';

  @override
  List<Object> get props => [user, token, exp];
}
