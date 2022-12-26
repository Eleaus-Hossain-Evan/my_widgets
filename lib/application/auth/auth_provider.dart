import 'dart:async';

import 'package:clean_api/clean_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/auth/login_body.dart';
import '../../domain/auth/model/user_model.dart';
import '../../domain/auth/password_change_body.dart';
import '../../domain/auth/signup_body.dart';
import '../../infrastructure/auth_repository.dart';
import '../../utils/strings.dart';
import '../../utils/theme.dart';
import '../global.dart';
import 'auth_state.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    return AuthNotifier(AuthRepository(), ref);
  },
  name: "authProvider",
);

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository repo;
  final Ref ref;

  AuthNotifier(this.repo, this.ref) : super(AuthState.init());

  void setUser(UserModel user) {
    state = state.copyWith(user: user);
  }

  Future<void> signUp(SignupBody body) async {
    state = state.copyWith(loading: true);

    final res = await repo.signUp(body);

    state = res.fold(
      (l) {
        showNotification(
          title: l.error,
          theme: ref.watch(themeProvider).theme,
        );
        return state.copyWith(failure: l, loading: false);
      },
      (r) {
        return state.copyWith(user: r.data.user, loading: false);
      },
    );
  }

  Future<bool> login(LoginBody body) async {
    state = state.copyWith(loading: true);

    final result = await repo.login(body);

    state = result.fold(
      (l) {
        showNotification(
          title: l.error,
          theme: ref.watch(themeProvider).theme,
        );
        return state.copyWith(failure: l, loading: false);
      },
      (r) {
        showNotification(
          title: r.message,
          theme: ref.watch(themeProvider).theme,
        );
        ref
            .read(loggedInProvider.notifier)
            .saveCache(r.data.token, r.data.user);
        // ref.read(loggedInProvider.notifier).isLoggedIn();
        return state.copyWith(
          loading: false,
          user: r.data.user,
          success: r.success,
        );
      },
    );
    Logger.i(state.success);
    Logger.i(state.user);

    return state.success;
  }

  Future<bool> changePassword(PasswordChangeBody body) async {
    state = state.copyWith(
      loading: true,
      changePassSuccess: false,
    );

    Logger.v('body: $body');
    final res = await repo.changePassword(body);

    state = res.fold(
      (l) {
        showNotification(
          title: l.error,
          theme: ref.watch(themeProvider).theme,
        );
        return state.copyWith(
          failure: l,
          loading: false,
          changePassSuccess: false,
        );
      },
      (r) {
        showNotification(
          title: r.message,
          theme: ref.watch(themeProvider).theme,
        );
        return state.copyWith(
          loading: false,
          changePassSuccess: r.success,
        );
      },
    );
    return state.changePassSuccess;
  }

  void logout() {
    showNotification(
      title:
          ' ${state.user.firstName} ${state.user.lastName} logged out succesfully',
      theme: ref.watch(themeProvider).theme,
    );
    state = state.copyWith(user: UserModel.init());

    ref.read(loggedInProvider.notifier).deleteCache();
  }
}

final loggedInProvider = ChangeNotifierProvider<LoggedInNotifier>((ref) {
  final box = Hive.box(KStrings.cacheBox);
  return LoggedInNotifier(ref, box);
});

class LoggedInNotifier extends ChangeNotifier {
  final Ref _ref;
  Box box;
  LoggedInNotifier(this._ref, this.box);

  void deleteCache() {
    box.delete(KStrings.token);
    box.delete(KStrings.user);
    notifyListeners();
  }

  void saveCache(String token, UserModel user) {
    box.put(KStrings.token, token);
    saveUser(user);
    notifyListeners();
  }

  void saveUser(UserModel user) {
    box.put(KStrings.user, user.toJson());
  }

  void saveToken(String token) {
    box.put(KStrings.token, token);
  }

  String get token {
    return box.get(KStrings.token, defaultValue: '');
  }

  UserModel get user {
    final user = box.get(KStrings.user);
    return user != null ? UserModel.fromJson(user) : UserModel.init();
  }

  bool get isLoggedIn {
    return box.get(KStrings.token) != null;
  }
}
