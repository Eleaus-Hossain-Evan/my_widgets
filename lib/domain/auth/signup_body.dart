// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SignupBody extends Equatable {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String gender;
  final String dateOfBirth;
  final String password;

  const SignupBody({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.gender,
    required this.dateOfBirth,
    required this.password,
  });

  SignupBody copyWith({
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? gender,
    String? dateOfBirth,
    String? password,
  }) {
    return SignupBody(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'password': password,
    };
  }

  factory SignupBody.fromMap(Map<String, dynamic> map) {
    return SignupBody(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      password: map['password'] ?? '',
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      firstName,
      lastName,
      phone,
      email,
      gender,
      dateOfBirth,
      password,
    ];
  }

  String toJson() => json.encode(toMap());

  factory SignupBody.fromJson(String source) =>
      SignupBody.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SignupBody(firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, gender: $gender, dateOfBirth: $dateOfBirth, password: $password)';
  }
}
