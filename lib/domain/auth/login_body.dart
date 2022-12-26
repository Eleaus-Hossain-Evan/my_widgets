// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginBody extends Equatable {
  final String value;
  final String password;

  const LoginBody({
    required this.value,
    required this.password,
  });

  LoginBody copyWith({
    String? value,
    String? password,
  }) {
    return LoginBody(
      value: value ?? this.value,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'password': password,
    };
  }

  factory LoginBody.fromMap(Map<String, dynamic> map) {
    return LoginBody(
      value: (map['value'] ?? '') as String,
      password: (map['password'] ?? '') as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [value, password];

  String toJson() => json.encode(toMap());

  factory LoginBody.fromJson(String source) =>
      LoginBody.fromMap(json.decode(source) as Map<String, dynamic>);
}
