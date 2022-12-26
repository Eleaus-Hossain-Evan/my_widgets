// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

class PasswordChangeBody extends Equatable {
  final String oldPassword;
  final String newPassword;

  const PasswordChangeBody({
    required this.oldPassword,
    required this.newPassword,
  });

  PasswordChangeBody copyWith({
    String? oldPassword,
    String? newPassword,
  }) {
    return PasswordChangeBody(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }

  factory PasswordChangeBody.fromMap(Map<String, dynamic> map) {
    return PasswordChangeBody(
      oldPassword: map['oldPassword'] ?? '',
      newPassword: map['newPassword'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PasswordChangeBody.fromJson(String source) =>
      PasswordChangeBody.fromMap(json.decode(source));

  @override
  String toString() =>
      'PasswordChangeBody(oldPassword: $oldPassword, newPassword: $newPassword)';

  @override
  List<Object> get props => [oldPassword, newPassword];
}
