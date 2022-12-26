import 'dart:convert';

import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import '../../domain/auth/model/user_model.dart';

class AuthState extends Equatable {
  final UserModel user;
  final bool loading;
  final bool success;
  final bool changePassSuccess;
  final CleanFailure failure;
  final String language;

  const AuthState({
    required this.user,
    required this.loading,
    required this.success,
    required this.changePassSuccess,
    required this.failure,
    required this.language,
  });

  factory AuthState.init() => AuthState(
        user: UserModel.init(),
        loading: false,
        success: false,
        changePassSuccess: false,
        failure: CleanFailure.none(),
        language: 'en',
      );

  AuthState copyWith({
    UserModel? user,
    bool? loading,
    bool? success,
    bool? changePassSuccess,
    CleanFailure? failure,
    String? language,
  }) {
    return AuthState(
      user: user ?? this.user,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      changePassSuccess: changePassSuccess ?? this.changePassSuccess,
      failure: failure ?? this.failure,
      language: language ?? this.language,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      user,
      loading,
      success,
      changePassSuccess,
      failure,
      language,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'loading': loading,
      'success': success,
      'changePassSuccess': changePassSuccess,
      'failure': failure,
      'language': language,
    };
  }

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(
      user: UserModel.fromMap(map['user']),
      loading: map['loading'] ?? false,
      success: map['success'] ?? false,
      changePassSuccess: map['changePassSuccess'] ?? false,
      failure: map['failure'],
      language: map['language'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthState.fromJson(String source) =>
      AuthState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthState(user: $user, loading: $loading, success: $success, changePassSuccess: $changePassSuccess, failure: $failure, language: $language)';
  }
}
