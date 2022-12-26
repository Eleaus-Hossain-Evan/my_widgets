import 'dart:convert';

import 'package:equatable/equatable.dart';

class SimpleResponseBody extends Equatable {
  final String message;
  final bool success;

  const SimpleResponseBody({
    required this.message,
    required this.success,
  });

  SimpleResponseBody copyWith({
    String? message,
    bool? success,
  }) {
    return SimpleResponseBody(
      message: message ?? this.message,
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'success': success,
    };
  }

  factory SimpleResponseBody.fromMap(Map<String, dynamic> map) {
    return SimpleResponseBody(
      message: map['message'] ?? '',
      success: map['success'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SimpleResponseBody.fromJson(String source) =>
      SimpleResponseBody.fromMap(json.decode(source));

  @override
  String toString() =>
      'SimpleResponseBody(message: $message, success: $success)';

  @override
  List<Object> get props => [message, success];
}
