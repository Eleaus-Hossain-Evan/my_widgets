import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProfilePictureUpdateBody extends Equatable {
  final String image;
  const ProfilePictureUpdateBody({
    required this.image,
  });

  ProfilePictureUpdateBody copyWith({
    String? image,
  }) {
    return ProfilePictureUpdateBody(
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
    };
  }

  factory ProfilePictureUpdateBody.fromMap(Map<String, dynamic> map) {
    return ProfilePictureUpdateBody(
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfilePictureUpdateBody.fromJson(String source) =>
      ProfilePictureUpdateBody.fromMap(json.decode(source));

  @override
  String toString() => 'ProfilePictureUpdateBody(image: $image)';

  @override
  List<Object> get props => [image];
}
