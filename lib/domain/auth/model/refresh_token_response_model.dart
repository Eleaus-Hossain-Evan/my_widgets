import 'dart:convert';

import 'package:equatable/equatable.dart';

class RefreshTokenResponseModel extends Equatable {
  final String data;
  final bool success;
  final String message;
  const RefreshTokenResponseModel({
    required this.data,
    required this.success,
    required this.message,
  });

  RefreshTokenResponseModel copyWith({
    String? data,
    bool? success,
    String? message,
  }) {
    return RefreshTokenResponseModel(
      data: data ?? this.data,
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'success': success,
      'message': message,
    };
  }

  factory RefreshTokenResponseModel.fromMap(Map<String, dynamic> map) {
    return RefreshTokenResponseModel(
      data: map['data'] ?? '',
      success: map['success'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RefreshTokenResponseModel.fromJson(String source) =>
      RefreshTokenResponseModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'RefreshTokenResponseModel(data: $data, success: $success, message: $message)';

  @override
  List<Object> get props => [data, success, message];
}
