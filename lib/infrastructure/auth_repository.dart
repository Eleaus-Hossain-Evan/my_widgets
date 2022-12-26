import 'dart:convert';

import 'package:clean_api/clean_api.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../domain/auth/auth_responce.dart';
import '../domain/auth/login_body.dart';
import '../domain/auth/password_change_body.dart';
import '../domain/auth/profile_picture_update.dart';
import '../domain/auth/signup_body.dart';
import '../domain/simple_response_body.dart';
import '../utils/api_routes.dart';
import '../utils/network_handler.dart';
import '../utils/strings.dart';

class AuthRepository {
  final api = CleanApi.instance;
  final myApi = NetworkHandler.instance;

  Future<Either<CleanFailure, AuthResponse>> login(LoginBody body) async {
    final Either<CleanFailure, AuthResponse> data = await myApi.post(
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: APIRoute.LIGNIN,
      body: body.toMap(),
      withToken: false,
      // failureHandler: (statusCode, responseBody) {
      //   Logger.i("This is responsebody: $responseBody");
      //   if (statusCode >= 200 && statusCode <= 299) {
      //     return right(AuthResponse.fromMap(responseBody));
      //   } else {
      //     return left(CleanFailure.withData(
      //       statusCode: statusCode,
      //       enableDialogue: true,
      //       tag: APIRoute.LIGNIN,
      //       method: 'post',
      //       url: "",
      //       header: const {" ": " "},
      //       body: responseBody,
      //       error: "",
      //     ));
      //   }
      // },
    );

    return data.fold((l) {
      final error = jsonDecode(l.error);
      final failure = l.copyWith(error: error['error']['message']);
      return left(failure);
    }, (r) {
      // final box = Hive.box(Constants.CACHE_BOX);

      // box.put(Constants.TOKEN, r.user.token);
      // box.put(Constants.USER, r.user.toJson());

      api.setToken({'Authorization': 'Bearer ${r.data.token}'});
      myApi.setToken({'Authorization': 'Bearer ${r.data.token}'});
      Logger.v("data: $data");
      return right(r);
    });
  }

  Future<Either<CleanFailure, AuthResponse>> signUp(SignupBody body) async {
    final data = await myApi.post(
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: APIRoute.SIGNUP,
      body: body.toMap(),
      withToken: false,
    );

    return data.fold((l) {
      final error = jsonDecode(l.error);
      final failure = l.copyWith(error: error['error']['message']);
      return left(failure);
    }, (r) {
      final box = Hive.box('cacheBox');
      box.put(KStrings.token, r.data.token);
      api.setToken({'Authorization': 'Bearer ${r.data.token}'});

      return right(r);
    });
  }

  Future<Either<CleanFailure, SimpleResponseBody>> changePassword(
      PasswordChangeBody body) async {
    final data = await myApi.patch(
      fromData: (json) => SimpleResponseBody.fromMap(json),
      endPoint: APIRoute.CHANGE_PASSWORD,
      body: body.toMap(),
      withToken: true,
    );

    return data.fold((l) {
      final error = jsonDecode(l.error);
      final failure = l.copyWith(error: error['error']['message']);
      return left(failure);
    }, (r) {
      return right(r);
    });
  }

  Future<Either<CleanFailure, SimpleResponseBody>> profilePictureUpdate(
      ProfilePictureUpdateBody body) async {
    final data = await myApi.patch(
      fromData: (json) => SimpleResponseBody.fromMap(json),
      endPoint: APIRoute.PROFILE_PICTIURE_UPDATE,
      body: body.toMap(),
      withToken: true,
    );

    return data.fold((l) {
      final error = jsonDecode(l.error);
      final failure = l.copyWith(error: error['error']['message']);
      return left(failure);
    }, (r) {
      return right(r);
    });
  }
}
