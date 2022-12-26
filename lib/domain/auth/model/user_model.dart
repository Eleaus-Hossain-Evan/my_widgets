import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String phone;
  final String email;
  final String gender;
  final String image;
  final bool isApproved;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String institutionName;
  final String institutionLevel;

  const UserModel({
    required this.id,
    required this.phone,
    required this.email,
    required this.gender,
    required this.image,
    required this.isApproved,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.institutionName,
    required this.institutionLevel,
  });

  factory UserModel.init() => UserModel(
        id: "",
        phone: "",
        gender: '',
        email: "",
        image: "",
        isApproved: false,
        firstName: "Guest",
        lastName: "User",
        dateOfBirth: DateTime.now(),
        institutionLevel: '',
        institutionName: '',
      );

  UserModel copyWith({
    String? id,
    String? phone,
    String? email,
    String? gender,
    String? image,
    bool? isApproved,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? institutionName,
    String? institutionLevel,
  }) {
    return UserModel(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      isApproved: isApproved ?? this.isApproved,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      institutionName: institutionName ?? this.institutionName,
      institutionLevel: institutionLevel ?? this.institutionLevel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'phone': phone,
      'email': email,
      'gender': gender,
      'image': image,
      'isApproved': isApproved,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'institutionName': institutionName,
      'institutionLevel': institutionLevel,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
      image: map['image'] ?? '',
      isApproved: map['isApproved'] ?? false,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      dateOfBirth: map['dateOfBirth'] == null
          ? DateTime.now()
          : DateTime.tryParse(map['dateOfBirth']) ?? DateTime.now(),
      institutionName: map['institutionName'] ?? '',
      institutionLevel: map['institutionLevel'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, phone: $phone, email: $email, gender: $gender, image: $image, isApproved: $isApproved, firstName: $firstName, lastName: $lastName, dateOfBirth: $dateOfBirth, institutionName: $institutionName, institutionLevel: $institutionLevel)';
  }

  @override
  List<Object> get props {
    return [
      id,
      phone,
      email,
      gender,
      image,
      isApproved,
      firstName,
      lastName,
      dateOfBirth,
      institutionName,
      institutionLevel,
    ];
  }
}
